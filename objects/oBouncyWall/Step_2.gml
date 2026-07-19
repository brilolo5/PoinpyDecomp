var yspRound, _cyParse, _cxParse;

if (set && !stop)
{
    dampening = 0.15;
    tension = dampening / 4;
    xdisplacement = xstart - x;
    ydisplacement = ystart - y;
    xsp += ((xdisplacement * tension) - (dampening * xsp));
    ysp += ((ydisplacement * tension) - (dampening * ysp));
    cx += (xsp * global.timeScale);
    cy += (ysp * global.timeScale);
    var xspRound = floor(abs(cx)) * sign(cx);
    yspRound = floor(abs(cy)) * sign(cy);
    cx -= xspRound;
    cy -= yspRound;
    _cxParse = cx;
    _cyParse = cy;
    
    repeat (abs(xspRound))
    {
        target = instance_place(x + sign(xspRound), y, parentWall);
        
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
    
    if (targetPlatform && !place_meeting(x, y, other.id) && !place_meeting_exception(x, y + sign(yspRound), parentWall, other.id))
    {
        dcy = _cyParse;
        dcx = _cxParse;
    }
}

if (stop > 0)
    stop -= global.timeScale;
