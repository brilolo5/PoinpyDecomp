var gts = global.timeScale;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    switch (bubbleState)
    {
        case "idle":
            tension = 0.02;
            dampening = 0.06;
            dir = point_direction(x, y, xstart, ystart);
            xdisplacement = xstart - x;
            ydisplacement = ystart - y;
            xsp += ((xdisplacement * tension) - (dampening * xsp));
            ysp += ((ydisplacement * tension) - (dampening * ysp));
            bubbleLifeMax = 120;
            bubbleLife = bubbleLifeMax;
            break;
        
        case "active":
            grav = 0.1;
            image_index = 1;
            gravityEnabled = 1;
            maxFallSpeed = -1.5;
            baseSize = 0.75 + ((bubbleLife / bubbleLifeMax) * 0.25);
            bubbleLife -= gts;
            
            if (bubbleLife < (bubbleLifeMax / 3.5))
            {
                flashModTime += gts;
                whiteFlash = round(flashModTime / 4) % 2;
                maxFallSpeed = -1;
            }
            
            if (bubbleLife <= 0)
            {
                if (place_meeting(x, y, oPlayer))
                {
                    with (oPlayer)
                    {
                        playerStateChange("spin jump");
                        xsp = other.xsp;
                        ysp = other.ysp;
                        ysp = -4;
                        addHitStop(8);
                        global.jumpTimes = approach(global.jumpTimes, 0, 1);
                    }
                }
                
                instance_destroy();
            }
            
            break;
    }
    
    cx += (xsp * global.timeScale);
    cy += (ysp * global.timeScale);
    var xspRound = floor(abs(cx)) * sign(cx);
    var yspRound = floor(abs(cy)) * sign(cy);
    cx -= xspRound;
    cy -= yspRound;
    var _grav = ((grav * global.timeScale) / 2) * gravityEnabled;
    ysp = approach(ysp, maxFallSpeed, _grav);
    var _fric = 0.015;
    xsp = lerp(xsp, xDirection * 0.3, 0.0025);
    
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
            xDirection *= -1;
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
        {
            y += sign(yspRound);
        }
        else if (ysp < 0)
        {
            ysp = 2;
            xsp *= 1.25;
        }
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
    
    ysp = approach(ysp, maxFallSpeed, _grav);
}

var _whileLoopCheck = 0;

while (place_meeting(x, y, parentWall))
{
    x += sign(xstart - x);
    y += sign(ystart - y);
    _whileLoopCheck += 1;
    
    if (_whileLoopCheck > 60)
    {
        instance_destroy();
        break;
    }
}

xShrink = approach(xShrink, 1, 0.075 * gts);
yShrink = approach(yShrink, 1, 0.075 * gts);
xscale = 1 * xShrink * xscaleBase * baseSize;
yscale = yDirection * yShrink * yscaleBase * baseSize;
