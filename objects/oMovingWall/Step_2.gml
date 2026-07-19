if (!set)
{
    while (true)
    {
        cannibalizeTarget = instance_place(x + 1, y, oMovingWall);
        
        if (cannibalizeTarget)
        {
            expandSize = cannibalizeTarget.wallSizex;
            wallSizex += expandSize;
            image_xscale += expandSize;
            x += (expandSize * 8);
            
            with (cannibalizeTarget)
                instance_destroy();
        }
        else
        {
            break;
        }
    }
}

if (set && !stop)
{
    cx += (xsp * global.timeScale);
    cy += (ysp * global.timeScale);
    var xspRound = floor(abs(cx)) * sign(cx);
    var yspRound = floor(abs(cy)) * sign(cy);
    cx -= xspRound;
    cy -= yspRound;
    var _cxParse = cx;
    var _cyParse = cy;
    
    repeat (clamp(abs(xspRound), 1, 10))
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
                {
                    x += sign(xspRound);
                    dcx = _cxParse + cx;
                }
            }
            
            x += sign(xspRound);
        }
        else
        {
            xsp *= -1;
            stop = 20;
            screenShake(2, 2);
            break;
        }
    }
    
    repeat (abs(yspRound))
    {
        target = instance_place(x, y + sign(yspRound), parentWall);
        
        if (target == -4)
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
        else
        {
            ysp *= -1;
            stop = 20;
            screenShake(2, 2);
            break;
        }
    }
}

if (stop > 0)
    stop -= global.timeScale;
