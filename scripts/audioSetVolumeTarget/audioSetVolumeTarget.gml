function audioSetVolumeTarget(arg0, arg1, arg2)
{
    var _struct = __audioGetStruct(arg0);
    
    if (_struct == undefined)
    {
        __audioTrace("Warning! Sound ID ", arg0, " doesn't exist");
    }
    else if (_struct.destroyAtZeroVolume)
    {
        __audioTrace("Warning! Cannot set volume target for audio instance, it is fading out");
    }
    else
    {
        _struct.volumeTarget = arg1;
        _struct.volumeSpeed = arg2;
        _struct.tick(false);
    }
}
