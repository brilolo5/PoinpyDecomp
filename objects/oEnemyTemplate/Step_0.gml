var gts;

if (editing)
    gts = global.timeScale;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    switch (enemyState)
    {
        case "idle":
            xsp = 0;
            ysp = 0;
            
            if (abs(y - oPlayer.y) < 64)
                enemyState = "active";
            
            image_index = 0;
            break;
        
        case "active":
            break;
    }
    
    cx += (xsp * global.timeScale);
    cy += (ysp * global.timeScale);
    var xspRound = floor(abs(cx)) * sign(cx);
    var yspRound = floor(abs(cy)) * sign(cy);
    cx -= xspRound;
    cy -= yspRound;
    ysp += (((grav * gts) / 2) * gravityEnabled);
    
    repeat (abs(xspRound))
    {
        var target = instance_place(x + sign(xspRound), y, parentWall);
        var targetHazard = instance_place(x + sign(xspRound), y, parentHazard);
        
        if (!target && !targetHazard)
        {
            x += sign(xspRound);
        }
        else
        {
            xsp = 0;
            hitStop = 6;
            break;
        }
    }
    
    repeat (abs(yspRound))
    {
        var target = instance_place(x, y + sign(yspRound), parentWall);
        var targetHazard = instance_place(x, y + sign(yspRound), parentHazard);
        
        if (!(target || targetHazard))
        {
            if (yspRound > 0)
            {
                if (place_meeting(x, y + 1, oOnewayPlatform) && !place_meeting(x, y, oOnewayPlatform))
                    target = instance_place(x, y + 1, oOnewayPlatform);
            }
        }
        
        if (!(target || targetHazard))
            y += sign(yspRound);
        else
            ysp = 0;
    }
    
    if (ysp >= 0 && (place_meeting(x, y + 1, parentWall) || (place_meeting(x, y + 1, oOnewayPlatform) && !place_meeting(x, y, oOnewayPlatform))))
    {
        grounded = 1;
        cy = 0;
    }
    else
    {
        grounded = -1;
    }
    
    ysp += (((grav * global.timeScale) / 2) * gravityEnabled);
    
    if (ysp > maxFallSpeed)
        ysp = maxFallSpeed;
}

xShrink = approach(xShrink, 1, 0.05 * gts);
yShrink = approach(yShrink, 1, 0.05 * gts);
xscale = xscaleBase * xDirection * xShrink;
yscale = yscaleBase * yDirection * yShrink;
dcx = cx;
dcy = cy;
