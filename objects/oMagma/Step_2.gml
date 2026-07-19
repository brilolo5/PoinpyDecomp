if (live_call())
    return global.live_result;

var viewx = getViewx(global.cam);
var viewy = getViewy(global.cam);

if (!puzzleModeInitialPause)
{
    if (!endingSubside)
    {
        x = room_width / 2;
        var _bottomline = (getViewy(global.cam) + global.viewHeight) - 24;
        _bottomline = getViewy(global.cam) + (global.viewHeight / 2) + 128;
        
        if (y > _bottomline && !inLaunchSequence)
            y = deltaLerp(y, _bottomline, 0.25);
    }
    else
    {
        y += (2 * global.timeScale);
        
        if (bbox_top > (getViewy(global.cam) + global.viewHeight + 32))
        {
            instance_destroy();
            exit;
        }
    }
}
else if (puzzleMagmaSetInPlace > 0)
{
    puzzleMagmaSetInPlace -= (1/30);
    var _bottomline = (getViewy(global.cam) + global.viewHeight) - 24;
    _bottomline = getViewy(global.cam) + (global.viewHeight / 2) + 128;
    
    if (y > _bottomline)
        y = deltaLerp(y, _bottomline, 0.25);
}
