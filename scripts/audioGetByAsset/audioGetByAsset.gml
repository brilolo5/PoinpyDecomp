function audioGetByAsset()
{
    var _asset = argument[0];
    var _nth = (argument_count > 1 && argument[0] != undefined) ? argument[1] : 0;
    var _key_array = ds_map_keys_to_array(global.__audioSoundMap, []);
    var _i = 0;
    var _n = 0;
    var _arrayLength = array_length(_key_array);
    
    if (_arrayLength > 0)
    {
        repeat (_arrayLength)
        {
            var _struct = global.__audioSoundMap[? array_get(_key_array, _i)];
            
            if (_struct.asset == _asset)
            {
                if (_nth == _n)
                    return _struct.audioId;
                
                _n++;
            }
            
            _i++;
        }
    }
    
    return undefined;
}
