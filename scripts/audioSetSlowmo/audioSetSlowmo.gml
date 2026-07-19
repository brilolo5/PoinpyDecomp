function audioSetSlowmo(arg0)
{
    var _struct = __audioGetStruct(arg0);
    
    if (_struct == undefined)
        __audioTrace("Warning! Sound ID ", arg0, " doesn't exist");
    
    _struct.slowmo = true;
    _struct.tick(false);
}
