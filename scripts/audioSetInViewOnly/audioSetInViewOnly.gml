function audioSetInViewOnly(arg0, arg1, arg2)
{
    var _struct = __audioGetStruct(arg0);
    
    if (_struct == undefined)
        __audioTrace("Warning! Sound ID ", arg0, " doesn't exist");
    
    _struct.inViewOnly = true;
    _struct.x = arg1;
    _struct.y = arg2;
    _struct.tick(false);
}
