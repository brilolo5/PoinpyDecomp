var gts = global.timeScale;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    switch (enemyState)
    {
        case "idle":
            shotTimer -= global.timeScale;
            
            if (shotTimer <= 0)
            {
            }
            
            image_index = (shotTimer > (shotInterval / 2)) ? 1 : 0;
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
        target = instance_place(x + sign(xspRound), y, parentWall);
        
        if (target == -4)
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
            y += sign(yspRound);
        else
            ysp = 0;
    }
    
    if (!(place_meeting(x, y + 1, parentWall) || (place_meeting(x, y + 1, oOnewayPlatform) && !place_meeting(x, y, oOnewayPlatform))) || ysp < 0)
    {
        grounded = -1;
    }
    else
    {
        grounded = 1;
        cy = 0;
    }
    
    ysp += (((grav * global.timeScale) / 2) * gravityEnabled);
    
    if (ysp > maxFallSpeed)
        ysp = maxFallSpeed;
}

xShrink = approach(xShrink, 1, 0.05 * gts);
yShrink = approach(yShrink, 1, 0.05 * gts);
xscale = xDirection * xShrink;
yscale = yDirection * yShrink;
