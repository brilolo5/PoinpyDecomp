if (live_call())
    return global.live_result;

var _px = -1;
var _py = -1;

if (instance_exists(oPlayer))
{
    _px = oPlayer.x;
    _py = oPlayer.y;
}

if (state == "initialize")
    rabbitStateChange("notification - jumping", 1);

if (notificationActive)
{
    if (((_px - x) * image_xscale) < 0)
    {
        rabbitStateBuffer("notification - checking in", -1);
        
        if (instance_exists(oPlayer))
        {
            _px = oPlayer.x;
            _py = oPlayer.y;
            
            if (inRectArea(x, y, _px, _py, 80, 80))
            {
                if (oPlayer.currentState == "slam bounce" && playerStateTracker != "slam bounce")
                {
                    playerSlammed = 1;
                    spriteIndex = sNotifRabbit_Jump;
                    imageIndex = 7;
                }
            }
            
            playerStateTracker = oPlayer.currentState;
        }
    }
    else if (state == "notification - checking in")
    {
        rabbitStateChange("notification - checking back out", 1);
    }
    else
    {
        rabbitStateBuffer("notification - jumping", 1);
    }
}
else
{
    rabbitStateBuffer("notification cleared - asleep", xDirection * image_xscale);
    
    if (instance_exists(oPlayer))
    {
        _px = oPlayer.x;
        _py = oPlayer.y;
        
        if (inRectArea(x, y, _px, _py, 80, 80))
        {
            if (oPlayer.currentState == "slam bounce" && playerStateTracker != "slam bounce")
            {
                playerSlammed = 1;
                rabbitStateChange("jump awake", xDirection * image_xscale);
                imageIndex = 7;
            }
        }
        
        playerStateTracker = oPlayer.currentState;
    }
}

if (mouse_check_button_pressed(mb_right))
    notificationActive = 0;
