var _cxParse = 0;
var _cyParse = 0;

if (oPlayer.currentState == "slamming")
    mask_index = sLobbyBeast_slamMask;
else
    mask_index = sLobbyBeast;

if (set && !stop)
{
    if (pressed)
    {
        dampening = 0.15;
        tension = dampening / 4;
        xdisplacement = xstart - x - cx;
        ydisplacement = ystart - y - cy;
        xsp += doDelta((xdisplacement * tension) - (dampening * xsp));
        ysp += doDelta((ydisplacement * tension) - (dampening * ysp));
    }
    else if (briefBounce)
    {
        dampening = 0.25;
        tension = dampening / 3;
        xdisplacement = xstart - x;
        ydisplacement = ystart - y;
        xsp += doDelta((xdisplacement * tension) - (dampening * xsp));
        ysp += doDelta((ydisplacement * tension) - (dampening * ysp));
        briefBounce = approach(briefBounce, 0, 0.011111111111111112 * global.timeScale);
    }
    else if (!breathStop)
    {
        breath += (global.timeScale / 54);
        ysp = sin(breath) * 0.025;
    }
    else if (breathStop)
    {
        ysp = 0;
    }
    
    cx += (xsp * global.timeScale);
    cy += (ysp * global.timeScale);
    var xspRound = floor(abs(cx)) * sign(cx);
    var yspRound = floor(abs(cy)) * sign(cy);
    cx -= xspRound;
    cy -= yspRound;
    _cxParse = cx;
    _cyParse = cy;
    
    repeat (abs(xspRound))
    {
        target = -4;
        
        if (target == -4)
        {
            with (parentEntity)
            {
                if (place_meeting(x - sign(xspRound), y, other.id))
                    x += sign(xspRound);
                
                targetPlatform = place_meeting(x, y + 1, other.id);
                
                if (!place_meeting(x + sign(xspRound), y, parentWall) && targetPlatform)
                    x += sign(xspRound);
            }
            
            x += sign(xspRound);
        }
        else
        {
            xsp *= -1;
            stop = 45;
            break;
        }
    }
    
    repeat (clamp(abs(yspRound), 1, 99))
    {
        with (parentEntity)
        {
            if (place_meeting(x, y - sign(yspRound), other.id))
                y += sign(yspRound);
            
            targetPlatform = place_meeting(x, y + 1, other.id);
            
            if (targetPlatform && !place_meeting_exception(x, y + sign(yspRound), parentWall, other.id))
                y += sign(yspRound);
        }
        
        y += sign(yspRound);
    }
}

with (parentEntity)
{
    targetPlatform = place_meeting(x, y + 1, other.id);
    
    if (targetPlatform && !place_meeting(x, y, other.id))
    {
        dcy = _cyParse;
        dcx = _cxParse;
    }
}

if (stop > 0)
    stop -= global.timeScale;

y = clamp(y, ystart - 12, ystart + 64);

if (pressed > 0)
{
    pressed += doDelta(1);
    
    if (pressed > 35)
        image_index = 3;
}
