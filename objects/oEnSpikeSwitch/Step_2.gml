var gts = global.timeScale;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    cx += (xsp * global.timeScale);
    cy += (ysp * global.timeScale);
    var xspRound = floor(abs(cx)) * sign(cx);
    var yspRound = floor(abs(cy)) * sign(cy);
    cx -= xspRound;
    cy -= yspRound;
    
    if (place_meeting(x, y + 1, oWall))
    {
        repeat (abs(xspRound))
        {
            target = instance_place(x + sign(xspRound), y, parentWall);
            var maskWidth = sprite_get_bbox_right(sprite_index) - sprite_get_bbox_left(sprite_index);
            
            if (target == -4)
            {
                if ((!instance_place(x + sign(xspRound) + (sign(xspRound) * maskWidth), y + 1, parentWall) && instance_place(x + sign(xspRound), y + 1, parentWall)) || (!instance_place(x + sign(xspRound) + (sign(xspRound) * maskWidth), y + 1, oOnewayPlatform) && instance_place(x + sign(xspRound), y + 1, oOnewayPlatform)))
                {
                    xsp *= -1;
                    hitStop = 6;
                    xscale = 0.75;
                    yscale = 1.25;
                    break;
                }
                else
                {
                    x += sign(xspRound);
                }
            }
            else
            {
                xsp *= -1;
                hitStop = 6;
                xscale = 0.75;
                yscale = 1.25;
                break;
            }
        }
    }
    
    ysp += grav;
    
    repeat (abs(yspRound))
    {
        target = instance_place(x, y + sign(yspRound), parentWall);
        
        if (!target)
        {
            if (yspRound >= 0)
            {
                if (place_meeting(x, y + 1, oOnewayPlatform) && !place_meeting(x, y, oOnewayPlatform))
                    target = instance_place(x, y + 1, oOnewayPlatform);
            }
        }
        
        if (target == -4)
        {
            y += sign(yspRound);
        }
        else
        {
            ysp = 0;
            break;
        }
        
        y += sign(yspRound);
    }
}

xscale = approach(xscale, 1, 0.05 * gts);
yscale = approach(yscale, 1, 0.05 * gts);
image_xscale = sign(xsp) * xscale;
image_yscale = yscale;
