if (!fruitSet)
{
    if (getViewy(global.cam) < y)
    {
        fruitType = fruitGetRandomFromCycle();
        sprIndex = getFruitSprite(fruitType);
        fruitSet = 1;
    }
}

var gts = global.timeScale;

if (noGetTimer > 0)
{
    manualDraw = blink(1, 0, 0.05);
    noGetTimer -= gts;
    
    if (noGetTimer <= 0)
    {
        noGet = 0;
        manualDraw = 0;
    }
}

if (suckResistTimer > 0)
{
    suckResistTimer -= gts;
    
    if (suckResistTimer <= 0)
        suckResist = 0;
}

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    switch (fruitState)
    {
        case "idle":
            if (grounded)
                xsp = approach(xsp, 0, 0.1);
            
            image_index = 0;
            break;
        
        case "active":
            break;
    }
    
    if (inMotion)
    {
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
                xsp *= -0.75;
                hitStop = 3;
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
}

xShrink = approach(xShrink, 1, 0.05 * gts);
yShrink = approach(yShrink, 1, 0.05 * gts);
xscale = xDirection * xShrink;
yscale = yDirection * yShrink;
