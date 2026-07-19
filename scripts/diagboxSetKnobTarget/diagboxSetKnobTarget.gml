function diagboxSetKnobTarget()
{
    var _diagbox = argument[0];
    var _x = (argument_count > 1) ? argument[1] : undefined;
    var _y = (argument_count > 2) ? argument[2] : undefined;
    
    with (_diagbox)
    {
        if (_x != undefined)
            knobTargetX = _x;
        
        if (_y != undefined)
            knobTargetY = _y;
        
        posLerpRate = posLerpRateDefault;
    }
}
