function audioSystemPauseWorld()
{
    var _key_array = ds_map_keys_to_array(global.__audioSoundMap, []);
    var _i = 0;
    var _arrayLength = array_length(_key_array);
    
    if (_arrayLength > 0)
    {
        repeat (_arrayLength)
        {
            global.__audioSoundMap[? array_get(_key_array, _i)].pauseWorld();
            _i++;
        }
    }
}
