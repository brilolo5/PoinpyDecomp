global.__audioSoundMap = ds_map_create();
global.__audioAssetGain = ds_map_create();
global.__audioPitchShift = 1;
global.__audioPitchShiftTarget = 1;
global.__audioPitchShiftSpeed = 0.02;
global.__audioSoundGain = 0.75;
global.__audioMusicGain = 0.6;
global.__audioMusicDuckGain = 1;
global.__audioMusicDuckTime = 0;
var _i = 0;

repeat (10000)
{
    var _string = audio_get_name(_i);
    
    if (_string == "<undefined>")
        break;
    
    global.__audioAssetGain[? _i] = audio_sound_get_gain(_i);
    _i++;
}

function __audioTrace()
{
    var _string = "Audio: ";
    var _i = 0;
    
    repeat (argument_count)
    {
        _string += string(argument[_i]);
        _i++;
    }
    
    show_debug_message(_string);
    return _string;
}

function __audioError()
{
    var _string = "Audio:\n";
    var _i = 0;
    
    repeat (argument_count)
    {
        _string += string(argument[_i]);
        _i++;
    }
    
    show_debug_message("ERROR " + string_replace_all(_string, "\n", "\n      "));
    show_error(_string, true);
}

function __audioClassSound(arg0, arg1) constructor
{
    static isStopped = function()
    {
        return !audio_is_playing(audioId) && !audio_is_paused(audioId);
    };
    
    static tick = function(arg0)
    {
        if (destroyAtZeroVolume && arg0 && volume <= 0 && volumeTarget <= 0)
        {
            stop();
            exit;
        }
        
        if (arg0)
            volume = approach(volume, volumeTarget, doDelta(volumeSpeed));
        
        if (inViewOnly)
        {
            var _x = getViewx(global.cam);
            var _y = getViewy(global.cam);
            var _w = getVieww(global.cam);
            var _h = getViewh(global.cam);
            var _l = _x - 10;
            var _t = _y - 10;
            var _r = _x + 10 + _w;
            var _b = _y + 10 + _h;
            var _inView = point_in_rectangle(x, y, _l, _t, _r, _b);
            
            if (inViewPrev != _inView)
            {
                inViewPrev = _inView;
                __audioTrace(audio_get_name(asset), " in view = ", _inView, " ", x, ", ", y, " vs. ", _l, ", ", _t, " -> ", _r, ", ", _b);
            }
            
            if (!_inView)
            {
                if (firstFrame)
                    viewGain = 0;
                else if (arg0)
                    viewGain = max(0, viewGain - 0.1);
            }
            else if (arg0)
            {
                viewGain = min(1, viewGain + 0.1);
            }
        }
        else if (arg0)
        {
            viewGain = min(1, viewGain + 0.1);
        }
        
        if (isMusic)
            finalGain = global.__audioMusicDuckGain * global.__audioMusicGain * viewGain * volume * trimGain;
        else
            finalGain = global.__audioSoundGain * viewGain * volume * trimGain;
        
        if (slowmo)
            finalPitch = global.__audioPitchShift * pitch;
        else
            finalPitch = pitch;
        
        audio_sound_gain(audioId, finalGain, firstFrame ? 0 : 30);
        audio_sound_pitch(audioId, finalPitch);
        
        if (arg0)
            firstFrame = false;
    };
    
    static pauseWorld = function()
    {
        if (world)
        {
            __audioTrace("Pausing ", audio_get_name(asset));
            audio_pause_sound(audioId);
        }
    };
    
    static pauseUI = function()
    {
        if (!world)
        {
            __audioTrace("Pausing ", audio_get_name(asset));
            audio_pause_sound(audioId);
        }
    };
    
    static resume = function()
    {
        __audioTrace("Resuming ", audio_get_name(asset));
        audio_resume_sound(audioId);
    };
    
    static stopWorld = function()
    {
        if (world)
            stop();
    };
    
    static stopUI = function()
    {
        if (!world)
            stop();
    };
    
    static stop = function()
    {
        audio_stop_sound(audioId);
        ds_map_delete(global.__audioSoundMap, audioId);
    };
    
    static getGain = function()
    {
        tick(false);
        return finalGain;
    };
    
    static getPitch = function()
    {
        tick(false);
        return finalPitch;
    };
    
    static debugString = function()
    {
        var _string = concat(world ? "[ER_GREEN2]" : "[ER_BLUE2]", audio_get_name(asset), "[ER_WHITE]    ([ER_YELLOW]", (100 * audio_sound_get_track_position(audioId)) / audio_sound_length(audioId), "%[ER_WHITE])\n", "    ", audio_is_paused(audioId) ? "[ER_YELLOW2][[paused]  " : "", destroyAtZeroVolume ? "[ER_RED2][[fade out] " : "", loop ? "[[loop]  " : "", isMusic ? "[[music]  " : "[[sfx]  ", world ? "[[world]  " : "[[ui]  ", "[ER_WHITE]\n", "    volume: [ER_YELLOW]", volume, "[ER_WHITE]    final gain: [ER_YELLOW]", finalGain, "[ER_WHITE]\n", "    pitch: [ER_YELLOW]", pitch, "[ER_WHITE]    final pitch: [ER_YELLOW]", finalPitch, "[ER_WHITE]\n");
        return _string;
    };
    
    audioId = audio_play_sound(arg0, arg1 ? 100 : 1, arg1);
    global.__audioSoundMap[? audioId] = self;
    firstFrame = true;
    asset = arg0;
    isMusic = false;
    slowmo = false;
    inViewOnly = false;
    inViewPrev = undefined;
    x = undefined;
    y = undefined;
    world = true;
    duck = false;
    pitch = 1;
    loop = arg1;
    destroyAtZeroVolume = false;
    trimGain = global.__audioAssetGain[? arg0];
    viewGain = 1;
    volume = 1;
    volumeTarget = 1;
    volumeSpeed = 0.1;
    finalGain = 1;
    finalPitch = 1;
    
    if (trimGain == undefined)
    {
        __audioTrace("Warning! Asset ", audio_get_name(asset), " has no trim gain, setting to 0.5");
        trimGain = 0.5;
    }
}

function __audioGetStruct(arg0)
{
    var _struct = global.__audioSoundMap[? arg0];
    
    if (is_struct(_struct))
        return _struct;
    
    return undefined;
}
