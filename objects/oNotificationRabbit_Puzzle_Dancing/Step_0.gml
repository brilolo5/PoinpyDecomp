if (live_call())
    return global.live_result;

if (instance_exists(oPlayer))
{
    var _px = oPlayer.x;
    var _py = oPlayer.y;
    
    if (inRectArea(x, y, _px, _py, 16, 16))
    {
        if (oPlayer.currentState == "slam bounce" && playerStateTracker != "slam bounce")
        {
            jumpAwake();
            xDirection = startXdir;
        }
    }
    
    playerStateTracker = oPlayer.currentState;
}
