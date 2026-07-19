var gts = global.timeScale;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    switch (enemyState)
    {
        case "idle":
            if (getViewy(global.cam) < (y + 8))
            {
                while (place_meeting(x, y, oWall))
                {
                    if (collision_point(x, y + 16, parentWall, 0, 0))
                        ysp -= 1;
                    
                    if (collision_point(x, y - 16, parentWall, 0, 0))
                        ysp += 1;
                    
                    if (collision_point(x + 16, y, parentWall, 0, 0))
                        xsp -= 1;
                    
                    if (collision_point(x - 16, y + 16, parentWall, 0, 0))
                        xsp += 1;
                    
                    if ((abs(xsp) + abs(ysp)) == 0)
                    {
                        if (collision_point(x + 16, y + 16, parentWall, 0, 0))
                        {
                            ysp -= 1;
                            xsp -= 1;
                        }
                        
                        if (collision_point(x + 16, y - 16, parentWall, 0, 0))
                        {
                            xsp -= 1;
                            ysp += 1;
                        }
                        
                        if (collision_point(x - 16, y - 16, parentWall, 0, 0))
                        {
                            xsp += 1;
                            ysp += 1;
                        }
                        
                        if (collision_point(x - 16, y + 16, parentWall, 0, 0))
                        {
                            xsp += 1;
                            ysp -= 1;
                        }
                    }
                    
                    xsp = clamp(xsp, -1, 1);
                    ysp = clamp(ysp, -1, 1);
                    x += xsp;
                    y += ysp;
                    
                    if ((abs(xsp) + abs(ysp)) == 0)
                    {
                        if (place_meeting(x, y, parentWall))
                            instance_destroy();
                    }
                    
                    xsp = 0;
                    ysp = 0;
                }
                
                enemyState = "active";
            }
            
            break;
        
        case "active":
            turncheck();
            xDirection = clockwiseOrNo;
            yDirection = 1;
            
            if (clockwiseOrNo && crawlDirection == 0)
                unstompable = 0;
            else if (!clockwiseOrNo && crawlDirection == 180)
                unstompable = 0;
            else
                unstompable = 0;
            
            turnInterval -= gts;
            xsp = lengthdir_x(crawlSpeed, crawlDirection);
            ysp = lengthdir_y(crawlSpeed, crawlDirection);
            
            if (stop)
            {
                xsp = 0;
                ysp = 0;
            }
            
            if (place_meeting(x, y, parentWall))
                instance_destroy();
            
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
            
            if (turnCheckOnly())
                break;
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
        
        if (target == -4)
        {
            if (turnCheckOnly())
                break;
            
            y += sign(yspRound);
        }
        else
        {
            ysp = 0;
        }
    }
    
    ysp += (((grav * global.timeScale) / 2) * gravityEnabled);
    
    if (ysp > maxFallSpeed)
        ysp = maxFallSpeed;
}

xShrink = approach(xShrink, 1, 0.05 * gts);
yShrink = approach(yShrink, 1, 0.05 * gts);
xscale = xscaleBase * xDirection * xShrink;
yscale = yscaleBase * yDirection * yShrink;
