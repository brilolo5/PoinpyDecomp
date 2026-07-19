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
            time += (gts * 2);
            xsp = dsin(time) * 0.25 * 1;
            ysp = dcos(time * 2) * 0.5 * 1;
            
            if (ysp < 0.2)
                image_index += (0.2 * gts);
            else
                image_index += (0.1 * gts);
            
            imageAngle = (dcos((time + 60) * 2) * 1 * 1 * 10) - 10;
            xDirection = sign((dsin(time + 30) * 0.5 * 1) + 0.01);
            break;
        
        case "active":
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
        
        if (target == -4)
            y += sign(yspRound);
        else
            ysp = 0;
    }
    
    ysp += (((grav * global.timeScale) / 2) * gravityEnabled);
    
    if (ysp > maxFallSpeed)
        ysp = maxFallSpeed;
}

xShrink = approach(xShrink, 1, 0.05 * gts);
yShrink = approach(yShrink, 1, 0.05 * gts);
xscale = -xDirection * xShrink * xscaleBase;
yscale = yDirection * yShrink * yscaleBase;
