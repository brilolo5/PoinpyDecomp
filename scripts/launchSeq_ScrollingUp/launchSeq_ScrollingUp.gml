function launchSeq_ScrollingUp(arg0)
{
    if (live_call())
        return global.live_result;
    
    scrollSpeed = arg0;
    var _scrollBy = doDelta(arg0);
    var _viewy = getViewy(global.cam);
    oCamera.y -= _scrollBy;
    oCamera.camPosy -= _scrollBy;
    oCamera.camManualControl = 1;
    
    with (oCamera)
    {
    }
    
    with (oGameBackground)
    {
        finalAreaHorizonOffset = getViewy(global.cam) - 2600;
        finalAreaStarScrolly = -_viewy * 0.0175;
    }
    
    launchSeq_magmaOffset();
    launchSeq_playerLockToBeast();
}

function launchSeq_playerLockToBeast()
{
    var _viewx = getViewx(global.cam);
    var _viewy = getViewy(global.cam);
    
    with (oBeastMainGame)
    {
        beastForcePos = 1;
        beastForcePosy = oMagma.y - 16;
        beastForcePosx = global.viewWidth / 2;
        var _tweenDelayOffset = (beastyTween - beastBasey) * 1;
        var _headOffset = 30;
        oPlayer.y = oBeastMainGame.beastForcePosy - 16 - 8 - 4;
    }
    
    oPlayer.x = _viewx + (global.viewWidth / 2);
    oPlayer.image_index = 6;
}

function launchSeq_magmaOffset()
{
    var _viewy = getViewy(global.cam);
    magmaTide += doDelta(1);
    var _scrollSpeedRate = scrollSpeed / scrollSpeedDefault;
    var _magmaTideOffset = sin(magmaTide / 25) * 16 * _scrollSpeedRate;
    magmaOffset = approach(magmaOffset, _magmaTideOffset, doDelta(32));
    
    with (oMagma)
        y = _viewy + (global.viewHeight / 2) + other.magmaOffset + 48 + (random(1.5) * _scrollSpeedRate);
}
