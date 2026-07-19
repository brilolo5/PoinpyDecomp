var gts = global.timeScale;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    switch (enemyState)
    {
        case "idle":
            mask_index = sEnCannonFodderTest;
            spriteIndex = sHoodedHopper_idle;
            imageIndex += (0.1 * gts);
            var _middley = lerp(bbox_top, bbox_bottom, 0.5);
            
            if (abs(_middley - oPlayer.y) < 48 && sign(oPlayer.x - x) == sign(xDirection))
            {
                enemyState = "alarm";
                
                if (audioVarHoodedHopperAlert == 0)
                {
                    playSoundEnemyHoodedHopperAlert();
                    audioVarHoodedHopperAlert = 1;
                }
                
                yShrink = 1.5;
                xShrink = 0.5;
                ysp = -1;
                xsp = -xDirection * 0.25;
                stateTimer = -15;
                spriteIndex = sHoodedHopper_hopBack;
                imageIndex = 0;
            }
            
            break;
        
        case "alarm":
            imageIndex = approach(imageIndex, 1, 0.2 * gts);
            
            if (grounded)
            {
                imageIndex = 2;
                xsp = 0;
            }
            
            xShrink = approach(xShrink, 1, 0.05 * gts);
            yShrink = approach(yShrink, 1, 0.05 * gts);
            stateTimer += gts;
            
            if (grounded)
            {
                xShrink = 0.8;
                yShrink = 1.2;
                enemyState = "prepare";
                stateTimer = 0;
            }
            
            break;
        
        case "prepare":
            spriteIndex = sHoodedHopper_hopBack;
            imageIndex = 2;
            xShrink = lerp(xShrink, 1, 0.05);
            yShrink = lerp(yShrink, 1, 0.05);
            stateTimer += gts;
            
            if (stateTimer > 42)
            {
                playSoundEnemyHoodedHopperJump();
                enemyState = "leap";
                stateTimer = 0;
                xShrink = 0.65;
                yShrink = 1.3;
                ysp = -2.5;
                xsp = xDirection * 1;
                spriteIndex = sHoodedHopper_leapStart;
                imageIndex = 1;
                descent = 0;
            }
            
            break;
        
        case "leap":
            if (ysp < -0.9)
            {
                spriteIndex = sHoodedHopper_leapStart;
                imageIndex = approach(imageIndex, 1, 0.5 * gts);
            }
            else if (!descent)
            {
                spriteIndex = sHoodedHopper_leapStart;
                imageIndex = approach(imageIndex, 3, 0.2 * gts);
                
                if (imageIndex == 3)
                    descent = 1;
            }
            else
            {
                spriteIndex = sHoodedHopper_airborneLoop;
                imageIndex += (0.15 * gts);
            }
            
            xShrink = approach(xShrink, 1, 0.05 * gts);
            yShrink = approach(yShrink, 1, 0.05 * gts);
            
            if (grounded)
            {
                playSoundEnemyHoodedHopperLand();
                xsp = 0;
                enemyState = "alarm";
                stateTimer = 0;
                xShrink = 0.9;
                yShrink = 1.25;
                spriteIndex = sHoodedHopper_land;
                imageIndex = 0;
                stateTimer = 0;
                xDirection = (x > oPlayer.x) ? -1 : 1;
            }
            
            break;
        
        case "land":
            xShrink = approach(xShrink, 1, 0.1 * gts);
            yShrink = approach(yShrink, 1, 0.1 * gts);
            spriteIndex = sHoodedHopper_land;
            imageIndex = approach(imageIndex, 1, 0.5 * gts);
            stateTimer += gts;
            enemyState = "prepare";
            stateTimer = 12;
            xDirection = (x > oPlayer.x) ? -1 : 1;
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
            xDirection = sign(xsp);
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

xscale = xShrink * xDirection * xscaleBase;
yscale = yShrink * yDirection * yscaleBase;
dcx = cx;
dcy = cy;
