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
            xsp += doDelta((xdisplacement * tension) - (dampening * xsp));
            ysp += doDelta((ydisplacement * tension) - (dampening * ysp));
            bubbleLifeMax = 210;
            image_index = 0;
            break;
        
        case "active":
            tension = 0.02;
            dampening = 0.06;
            dir = point_direction(x, y, xstart, ystart);
            xdisplacement = xstart - x;
            ydisplacement = ystart - y;
            xsp += doDelta((xdisplacement * tension) - (dampening * xsp));
            ysp += doDelta((ydisplacement * tension) - (dampening * ysp));
            image_index = 1;
            baseSize = 0.5 + ((bubbleLife / bubbleLifeMax) * 0.5);
            bubbleLife -= gts;
            var _startFlashingAt = bubbleLifeMax / 2;
            
            if (bubbleLife < _startFlashingAt)
            {
                flashModTime += gts;
                var _flashSpeed = 6 + ((bubbleLife / _startFlashingAt) * 4);
                whiteFlash = round(flashModTime / _flashSpeed) % 2;
            }
            
            if (bubbleLife <= 0)
            {
                with (oPlayer)
                {
                    if (currentState == "in bubble")
                    {
                        playerStateChange("free");
                        addHitStop(8);
                        xsp = 0;
                        ysp = -2;
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
            xsp *= -1;
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
        
        if (bubbleState == "active")
        {
            if (!target)
                target = instance_place(x, y + sign(yspRound), oMagma);
        }
        
        if (target == -4)
            y += sign(yspRound);
        else
            ysp *= -1;
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
xscale = xDirection * xShrink * xscaleBase * baseSize;
yscale = yDirection * yShrink * yscaleBase * baseSize;
