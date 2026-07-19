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
    ysp += (((grav * gts) / 2) * gravityEnabled);
    
    switch (enemyState)
    {
        case "idle":
            xsp = 0;
            ysp = 0;
            gravityEnabled = 0;
            
            if (abs(y - oPlayer.y) < 64)
            {
                enemyState = "set";
                xDirection = sign((oPlayer.x - x) + 0.1);
            }
            
            image_index = 0;
            break;
        
        case "set":
            xsp = 0;
            ysp = 0;
            gravityEnabled = 0;
            setTimerCount -= gts;
            imageAngle = 0;
            
            if (!setTimerCount)
            {
                windingTimerCount = windingTime;
                
                if (place_meeting(x + 1, y, parentWall))
                    xDirection = -1;
                else if (place_meeting(x - 1, y, parentWall))
                    xDirection = 1;
                
                if (oPlayer.y < y)
                    enemyState = "winding up";
                else
                    enemyState = "winding down";
            }
            
            image_index = 4;
            break;
        
        case "winding up":
            xsp = 0;
            ysp = 0;
            gravityEnabled = 0;
            windingTimerCount -= gts;
            
            if (!windingTimerCount)
            {
                ysp = -3;
                xsp = xDirection * 1;
                enemyState = "jump";
                xShrink *= 0.5;
                yShrink *= 1.5;
            }
            
            image_index = 1;
            break;
        
        case "winding down":
            xsp = 0;
            ysp = 0;
            gravityEnabled = 0;
            windingTimerCount -= gts;
            
            if (!windingTimerCount)
            {
                ysp = -1.5;
                xsp = xDirection * 1.25;
                enemyState = "jump";
                xShrink *= 0.5;
                yShrink *= 1.5;
            }
            
            image_index = 2;
            break;
        
        case "jump":
            gravityEnabled = 1;
            image_index = 3;
            
            if (ysp > 2.5)
            {
                enemyState = "glide";
                gravityEnabled = 0;
                ysp = 0.25;
                xsp = xDirection * 1;
                xShrink *= 0.5;
                yShrink *= 1.5;
            }
            
            if (grounded)
            {
                xsp = 0;
                enemyState = "set";
                setTimerCount = setTime;
                xDirection = sign((oPlayer.x - x) + 0.1);
                image_index = 4;
                xShrink *= 1.25;
                yShrink *= 0.75;
            }
            
            break;
        
        case "glide":
            if (grounded)
            {
                xsp = 0;
                enemyState = "set";
                setTimerCount = setTime;
                xDirection = sign((oPlayer.x - x) + 0.1);
                xShrink *= 1.25;
                yShrink *= 0.75;
            }
            
            image_index = 5;
            break;
    }
    
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
            xShrink *= 0.75;
            yShrink *= 1.25;
            
            if (enemyState == "jump" || enemyState == "glide")
            {
                enemyState = "set";
                setTimerCount = setTime;
                ysp = 0;
            }
            
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

xShrink = approach(xShrink, xScaleDefault, 0.05 * gts);
yShrink = approach(yShrink, yScaleDefault, 0.05 * gts);
xscale = xDirection * xShrink;
yscale = yShrink;
