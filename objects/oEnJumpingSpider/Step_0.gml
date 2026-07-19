var gts = global.timeScale;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    switch (enemyState)
    {
        case "idle":
            sprite_index = sEnemyJumper_idle;
            image_index = 0;
            
            if (abs(y - oPlayer.y) < 96)
            {
                enemyState = "alarm";
                playSoundEnemyFlatHopperAlert();
                xShrink = 0.5;
                yShrink = 1.5;
                image_index = 1;
                xDirection = sign((oPlayer.x - x) + 0.1);
            }
            
            break;
        
        case "alarm":
            sprite_index = sEnemyJumper_idle;
            xShrink = approach(xShrink, 1, 0.05 * gts);
            yShrink = approach(yShrink, 1, 0.05 * gts);
            xDirection = sign((oPlayer.x - x) + 0.1);
            stateTimer += gts;
            
            if (stateTimer > 60)
            {
                stateTimer = 0;
                enemyState = "prepare";
            }
            
            break;
        
        case "prepare":
            sprite_index = sEnemyJumper_charge;
            var _spriteNum = sprite_get_number(sprite_index) - 1;
            image_index = approach(image_index, _spriteNum, 0.15 * gts);
            
            if (audioVarFlatHopperJump == 0)
            {
                playSoundEnemyFlatHopperJump();
                audioVarFlatHopperJump = 1;
            }
            
            stateTimer += gts;
            
            if (stateTimer > 48)
            {
                xDirection = sign((oPlayer.x - x) + 0.1);
                enemyState = "jump";
                stateTimer = 0;
                maxFallSpeed = 3;
                ysp = -1.7;
                xsp = xDirection * 0.6;
                imageAngle = 0;
                image_index = 0;
                flutter = 0;
            }
            
            break;
        
        case "jump":
            if (!flutter)
            {
                sprite_index = sEnemyJumper_jump;
                _spriteNum = sprite_get_number(sprite_index) - 1;
                image_index = approach(image_index, _spriteNum, 0.3 * gts);
                
                if (image_index == _spriteNum)
                    flutter = 1;
                
                if (ysp > -1)
                    imageAngle = lerp(imageAngle, 0, 0.1);
            }
            else
            {
                sprite_index = sEnemyJumper_flutter;
                image_index += (0.25 * gts);
                imageAngle = 0;
            }
            
            if (grounded)
            {
                playSoundEnemyFlatHopperLand();
                audioVarFlatHopperJump = 0;
                enemyState = "land";
                stateTimer = 0;
                xShrink = 1.5;
                yShrink = 0.5;
                xsp = 0;
            }
            
            break;
        
        case "land":
            sprite_index = sEnemyJumper_idle;
            image_index = 1;
            xShrink = approach(xShrink, 1, 0.1 * gts);
            yShrink = approach(yShrink, 1, 0.1 * gts);
            xDirection = sign((oPlayer.x - x) + 0.1);
            stateTimer += gts;
            
            if (stateTimer > 30)
            {
                enemyState = "prepare";
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
    
    if (!grounded)
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
        grounded = 1;
    else
        grounded = -1;
    
    if (!grounded)
        ysp += (((grav * global.timeScale) / 2) * gravityEnabled);
    
    if (ysp > maxFallSpeed)
        ysp = maxFallSpeed;
}

xscale = xscaleBase * xShrink * xDirection;
yscale = yscaleBase * yShrink;
