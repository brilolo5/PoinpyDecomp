function debugAudioEngineDraw()
{
    if (!global.debugDrawAudioEngine)
        exit;
    
    var _string = concat("[ER_RED2]system[ER_WHITE]\n", "    sound gain: [ER_YELLOW]", global.__audioSoundGain, "[ER_WHITE]    music gain: [ER_YELLOW]", global.__audioMusicGain, "[ER_WHITE]\n", "    global pitch: [ER_YELLOW]", global.__audioPitchShift, "[ER_WHITE]    (-> [ER_YELLOW]", global.__audioPitchShiftTarget, "[ER_WHITE] @ [ER_YELLOW]", global.__audioPitchShiftSpeed, "[ER_WHITE])\n", "    duck gain: [ER_YELLOW]", global.__audioMusicDuckGain, "[ER_WHITE]    duck time: [ER_YELLOW]", global.__audioMusicDuckTime, "[ER_WHITE]\n");
    _string += "\n";
    var _key_array = array_create(ds_map_size(global.__audioSoundMap));
    var _i = 0;
    var _key = ds_map_find_first(global.__audioSoundMap);
    
    repeat (ds_map_size(global.__audioSoundMap))
    {
        array_set(_key_array, _i, _key);
        _key = ds_map_find_next(global.__audioSoundMap, _key);
        _i++;
    }
    
    _i = 0;
    var _arrayLength = array_length(_key_array);
    
    if (_arrayLength > 0)
    {
        repeat (_arrayLength)
        {
            _key = _key_array[_i];
            var _struct = global.__audioSoundMap[? _key];
            _string += (_struct.debugString() + "\n");
            _i++;
        }
    }
    
    drawSetAlign(0, 0);
    drawTextOutlined(global.windowRight + 16, 8, _string, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 0.75);
}
