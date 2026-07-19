function diagboxLock()
{
    var _diagbox = argument[0];
    var _x = (argument_count > 1) ? argument[1] : undefined;
    var _y = (argument_count > 2) ? argument[2] : undefined;
    
    with (_diagbox)
    {
        boxMode = "lock";
        
        if (_x != undefined)
            boxLockX = _x;
        
        if (_y != undefined)
            boxLockY = _y;
        
        posLerpRate = posLerpRateDefault;
    }
}
