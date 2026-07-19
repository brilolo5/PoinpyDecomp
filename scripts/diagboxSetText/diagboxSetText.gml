function diagboxSetText()
{
    var _diagbox = argument[0];
    var _text = (argument_count > 1) ? argument[1] : undefined;
    var _scale = (argument_count > 2) ? argument[2] : undefined;
    
    with (_diagbox)
    {
        if (_text != undefined)
            text = _text;
        
        if (_scale != undefined)
            textScaling = _scale;
        
        posLerpRate = posLerpRateDefault;
    }
}
