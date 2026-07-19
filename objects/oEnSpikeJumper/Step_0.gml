var gts = global.timeScale;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    switch (enemyState)
    {
        case "idle":
            enemyState = "jumping";
            xShrink = 0.75;
            yShrink = 1.25;
            image_index = 1;
            ysp = -2;
            break;
        
        case "wind up":
            unstompable = -1;
            
            if (windUpTimer > 0 && grounded)
            {
                windUpTimer -= gts;
                xShrink = 1 + (((windUpTimerMax - windUpTimer) / windUpTimerMax) * 0.5);
                yShrink = 1 - (((windUpTimerMax - windUpTimer) / windUpTimerMax) * 0.5);
                
                if (windUpTimer <= 0)
                {
                    imageAngle = 0;
                    enemyState = "jumping";
                    windUpTimer = windUpTimerMax;
                    ysp = jumpSpeed;
                    xShrink = 0.5;
                    yShrink = 1.5;
                }
            }
            
            break;
        
        case "jumping":
            if (ysp > 0)
            {
                imageAngle = lerp(imageAngle, 180, 0.2);
                unstompable = -1;
            }
            else
            {
                unstompable = 1;
            }
            
            if (grounded)
            {
                enemyState = "stuck";
                imageAngle = 180;
                xShrink = 1.5;
                yShrink = 0.5;
                unstompable = -1;
            }
            
            break;
        
        case "stuck":
            unstompable = -1;
            
            if (stuckTimer > 0)
            {
                stuckTimer -= gts;
                
                if (stuckTimer <= 0)
                {
                    stuckTimer = stuckTimerMax;
                    enemyState = "wind up";
                }
            }
            
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
