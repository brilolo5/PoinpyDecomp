function audioSetPitch(arg0, arg1)
{
    var _struct = __audioGetStruct(arg0);
    
    if (_struct == undefined)
    {
        __audioTrace("Warning! Sound ID ", arg0, " doesn't exist");
        exit;
    }
    
    _struct.pitch = arg1;
    _struct.tick(false);
}
