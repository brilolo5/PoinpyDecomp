function diagboxFloat()
{
    var _diagbox = argument[0];
    var _xoffset = (argument_count > 1) ? argument[1] : undefined;
    var _yoffset = (argument_count > 2) ? argument[2] : undefined;
    
    with (_diagbox)
    {
        boxMode = "float";
        
        if (_xoffset != undefined)
            boxFloatXOffset = _xoffset;
        
        if (_yoffset != undefined)
            boxFloatYOffset = _yoffset;
    }
}
