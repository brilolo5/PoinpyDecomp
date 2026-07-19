var gts = global.timeScale;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    switch (enemyState)
    {
        case "initialize":
            ysp = 0;
            xsp = 0;
            
            if (getViewy(global.cam) < y)
            {
                enemyState = "flutter";
                xsp = 0;
            }
            
            break;
        
        case "flutter":
            if (ysp < 0)
                image_index = (xDirection == -1) ? 1 : 3;
            else
                image_index = (xDirection == -1) ? 0 : 2;
            
            xShrink = approach(xShrink, 1, 0.01 * gts);
            yShrink = approach(yShrink, 1, 0.01 * gts);
            imageAngle = lerp(imageAngle, 0, 0.15);
            grav = 0.018;
            gravityEnabled = 1;
            maxFallSpeed = 10;
            
            if (y > flutterKeep_y)
            {
                playSoundEnemyBungeeBoyBounce();
                y = flutterKeep_y;
                ysp = -1.5;
                xsp = 0;
                stateTimer = 0;
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
            xsp *= -0.5;
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
    
    if (ysp >= 0 && place_meeting(x, y + 1, parentWall))
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

dcx = cx;
dcy = cy;
xShrink = 1;
yShrink = 1;
xscale = xShrink * xscaleBase;
yscale = yShrink * yDirection * yscaleBase;
