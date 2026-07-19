function uiCalcTime()
{
    var _duration = argument[0];
    var _delay = (argument_count > 1 && argument[1] != undefined) ? argument[1] : 0;
    
    if (animStartTime == undefined)
        return 1;
    
    return clamp((animTime - _delay - animStartTime) / _duration, 0, 1);
}
