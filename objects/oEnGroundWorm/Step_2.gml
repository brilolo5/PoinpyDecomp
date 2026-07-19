var gts = global.timeScale;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    xsp = sign(xsp) * 0.15;
    cx += (xsp * global.timeScale);
    cy += (ysp * global.timeScale);
    var xspRound = floor(abs(cx)) * sign(cx);
    var yspRound = floor(abs(cy)) * sign(cy);
    cx -= xspRound;
    cy -= yspRound;
    
    repeat (abs(xspRound))
    {
        target = instance_place(x + sign(xspRound), y, parentWall);
        var maskWidth = sprite_get_bbox_right(mask_index) - sprite_get_bbox_left(mask_index);
        
        if (target == -4)
        {
            if ((!instance_place(x + sign(xspRound) + (sign(xspRound) * maskWidth), y + 1, parentWall) && instance_place(x + sign(xspRound), y + 1, parentWall)) || (!instance_place(x + sign(xspRound) + (sign(xspRound) * maskWidth), y + 1, oOnewayPlatform) && instance_place(x + sign(xspRound), y + 1, oOnewayPlatform)))
            {
                xsp *= -1;
                hitStop = 6;
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
            break;
        }
    }
}

xDirection = sign(xsp);
xShrink = approach(xShrink, 1, 0.05 * gts);
yShrink = approach(yShrink, 1, 0.05 * gts);
xscale = xDirection * xShrink * xscaleBase;
yscale = yDirection * yShrink * yscaleBase;
