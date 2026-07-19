function audioSetVolume(arg0, arg1)
{
    var _struct = __audioGetStruct(arg0);
    
    if (_struct == undefined)
        __audioTrace("Warning! Sound ID ", arg0, " doesn't exist");
    
    if (_struct.destroyAtZeroVolume)
    {
    }
    else
    {
        _struct.volume = arg1;
        _struct.volumeTarget = arg1;
        _struct.tick(false);
    }
}
