var gts = global.timeScale;

if (hitStop)
    hitStop -= gts;

stepWidth = 6;
enemyWidth = 14;

if (!hitStop)
{
    switch (enemyState)
    {
        case "flipped":
            stateTimer += gts;
            image_index = approach(image_index, 1, gts * 0.6);
            
            if (stateTimer > 3)
            {
                stateTimer = 0;
                enemyState = "rest";
            }
            
            break;
        
        case "rest":
            xShrink = approach(xShrink, 1, 0.05 * gts);
            yShrink = approach(yShrink, 1, 0.05 * gts);
            stateTimer += gts;
            xsp = approach(xsp, 0, gts * 0.15);
            
            if (flipCheck && xsp == 0)
            {
                flipCheck = 0;
                var _flip = 0;
                _flip = !(instance_position(x + (xDirection * enemyWidth), y + 1, parentWall) || instance_position(x + (xDirection * enemyWidth), y + 1, oOnewayPlatform)) || place_meeting(x + (xDirection * 3), y, parentWall);
                
                if (_flip)
                {
                    xDirection *= -1;
                    spikeMirror(side);
                    stateTimer = -10;
                    enemyState = "flipped";
                    image_index = 2;
                    break;
                }
            }
            
            image_index = approach(image_index, 5, gts * 0.2);
            
            if (round(image_index) == 3)
                image_index = 5;
            
            if (stateTimer > 62)
            {
                stateTimer = 0;
                enemyState = "prepare";
                target = instance_position(x + (xDirection * enemyWidth), y + 1, parentWall);
                
                if (!target)
                    target = instance_position(x + (xDirection * enemyWidth), y + 1, oOnewayPlatform);
                
                if (target)
                {
                    if (place_meeting(x + (xDirection * 1), y, parentWall))
                        target = -4;
                }
                
                if (!target)
                {
                }
                
                image_index = 4;
            }
            
            break;
        
        case "prepare":
            stateTimer += gts;
            image_index = approach(image_index, 1, gts * 0.15);
            
            if (stateTimer > 36)
            {
                stateTimer = 0;
                enemyState = "flip";
            }
            
            break;
        
        case "flip":
            playSoundEnemySpikeBoxFlip();
            spikeRoll(side);
            image_index = 0;
            enemyState = "air";
            xsp = xDirection * 0.5;
            ysp = -1.5;
            flipCheck = 1;
            break;
        
        case "air":
            xShrink = approach(xShrink, 1, 0.05 * gts);
            yShrink = approach(yShrink, 1, 0.05 * gts);
            image_index = approach(image_index, 1, gts * 0.75);
            
            if (grounded)
            {
                imageAngle = 0;
                enemyState = "rest";
                xShrink = 1.25;
                yShrink = 0.75;
                image_index = 2;
            }
            
            break;
    }
    
    unstompable = side == UnknownEnum.Value_0;
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
            break;
        }
    }
    
    repeat (abs(yspRound))
    {
        target = instance_place(x, y + sign(yspRound), parentWall);
        
        if (!target)
        {
            if (yspRound > 0)
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
    
    if (ysp >= 0 && (place_meeting(x, y + 1, parentWall) || (place_meeting(x, y + 1, oOnewayPlatform) && !place_meeting(x, y, oOnewayPlatform))))
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

xShrink = 1;
yShrink = 1;
xscale = xShrink * xDirection * xscaleBase;
yscale = yShrink * yDirection * yscaleBase;
