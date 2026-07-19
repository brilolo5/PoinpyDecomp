function audioSystemTick()
{
    var _duck = false;
    var _key_array = ds_map_keys_to_array(global.__audioSoundMap, []);
    var _i = 0;
    var _arrayLength = array_length(_key_array);
    
    if (_arrayLength > 0)
    {
        repeat (_arrayLength)
        {
            var _struct = global.__audioSoundMap[? array_get(_key_array, _i)];
            
            if (is_struct(_struct))
            {
                with (_struct)
                {
                    if (isStopped())
                        stop();
                    else if (duck)
                        _duck = true;
                }
            }
            
            _i++;
        }
    }
    
    global.__audioSoundGain = global.soundEnabled * 0.75;
    global.__audioMusicGain = global.musicEnabled * 0.6;
    global.__audioPitchShift = approach(global.__audioPitchShift, global.__audioPitchShiftTarget, global.__audioPitchShiftSpeed);
    
    if (_duck)
        global.__audioMusicDuckTime = 1;
    else if (global.__audioMusicDuckGain <= 0.7)
        global.__audioMusicDuckTime -= (delta_time / 1000);
    
    if (global.__audioMusicDuckTime > 0)
        global.__audioMusicDuckGain = max(0.7, global.__audioMusicDuckGain - 0.1);
    else
        global.__audioMusicDuckGain = min(1, global.__audioMusicDuckGain + 0.1);
    
    _i = 0;
    
    if (_arrayLength > 0)
    {
        repeat (_arrayLength)
        {
            var _key = _key_array[_i];
            var _struct = global.__audioSoundMap[? _key];
            
            if (is_struct(_struct))
                _struct.tick(true);
            else
                ds_map_delete(global.__audioSoundMap, _key);
            
            _i++;
        }
    }
}
