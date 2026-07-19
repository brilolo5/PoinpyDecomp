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
            expandBy = 1;
            
            while (true)
            {
                if (place_meeting(x, y + (16 * expandBy), parentWall))
                {
                    expandBy += 1;
                }
                else
                {
                    expandBy += 1;
                    break;
                }
            }
            
            image_yscale *= expandBy;
            yScaleDefault = image_yscale;
            yShrink = image_yscale;
            y += (8 * (expandBy - 1));
            
            if (place_meeting(x, y, oMovingWall))
                enemyState = "movingWallAttach";
            else
                enemyState = "active";
            
            image_index = 0;
            break;
        
        case "movingWallAttach":
            if (attachToMovingWall == -4)
            {
                targetWall = instance_place(x, y, oMovingWall);
                
                if (targetWall)
                {
                    if (targetWall.set == 1)
                        attachToMovingWall = targetWall;
                }
            }
            else if (instance_exists(attachToMovingWall))
            {
                x = attachToMovingWall.x;
                cx = attachToMovingWall.cx;
            }
            
            if (shotTimer > 0)
            {
                shotTimer -= gts;
                
                if (shotTimer <= 0)
                {
                    shotTimer = shotTimerMax;
                    
                    with (instance_create_depth(x, bbox_bottom - 8, -1000, oDamageBall))
                    {
                        ysp = 0.75;
                        destroyTimer = 180;
                    }
                }
            }
            
            break;
        
        case "active":
            if (shotTimer > 0)
            {
                shotTimer -= gts;
                
                if (shotTimer <= 0)
                {
                    shotTimer = shotTimerMax;
                    
                    with (instance_create_depth(x, bbox_bottom - 8, -1000, oDamageBall))
                    {
                        ysp = 0.75;
                        destroyTimer = 180;
                    }
                }
            }
            
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
