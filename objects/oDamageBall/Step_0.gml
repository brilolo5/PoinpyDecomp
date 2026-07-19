if (destroyTimer > 0)
{
    destroyTimer -= global.timeScale;
    
    if (destroyTimer <= 0)
        instance_destroy();
}

image_xscale -= (global.timeScale / 480);
image_yscale = image_xscale;
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
        target = -4;
        
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
xscale = xDirection * xShrink;
yscale = yShrink;
