function diagboxSetSize()
{
    var _diagbox = argument[0];
    var _width = (argument_count > 1) ? argument[1] : undefined;
    var _height = (argument_count > 2) ? argument[2] : undefined;
    
    with (_diagbox)
    {
        if (_width != undefined)
            boxWidth = _width;
        
        if (_height != undefined)
            boxHeight = _height;
    }
}
