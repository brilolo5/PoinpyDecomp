function phcol_WallJump()
{
    var _targetWall = instance_place(argument[0], argument[1], parentWall);
    
    if (_targetWall.object_index != oSoftWall)
    {
        audioEvent("wall jump occurs");
        playSoundPlayerWallJump();
        xsp *= -1;
        
        if (abilityCheck(UnknownEnum.Value_2))
        {
            playSoundAbilityGripRocks();
            fruitSuckInRadius = fruitSuckInRadiusWalljump;
        }
        
        jumpThrust = -1;
        
        if (abilityCheck(UnknownEnum.Value_12))
        {
            if (currentState != "invincible spin jump")
                playerStateChange("spin jump");
        }
        else
        {
            playerStateChange("free - after spin");
        }
        
        if (jumpThrust == -1)
        {
            jumpThrust = 0;
            spinSpeed = -25;
            spinSpeed = 12;
            var _imageAngle = 45;
            imgAngle = _imageAngle;
            yscale = 1.25;
            xscale = 0.75;
            ysp = -4;
            xsp = 1.75 * sign(xsp);
            
            if (abilityCheck(UnknownEnum.Value_5))
            {
                playSoundAbilityHighHeels();
                ysp = -5.25;
                xsp = 1.6 * sign(xsp);
                addHitStop(8);
            }
            else
            {
                addHitStop(8);
            }
            
            var _fxPosLen = 8;
            var _fxPosDir = imgAngle + 90 + 22;
            var _fxPosx = x + (lengthdir_x(_fxPosLen, _fxPosDir) * -xDirection);
            var _fxPosy = y + lengthdir_y(_fxPosLen, _fxPosDir);
            
            with (generateEffect(_fxPosx, _fxPosy, "temp white flash", 0))
            {
                xShrink = 0.5;
                yShrink = 0.5;
            }
            
            var _movex = x + (xDirection * 3);
            var _movey = y - 4;
            
            if (!place_meeting(_movex, _movey, parentWall))
            {
                x = _movex;
                y = _movey;
            }
        }
        
        return true;
    }
    else
    {
        audioEvent("soft wall bounce");
        playSoundPlayerWallBounce();
        var _smokeDir = (sign(xsp) == 1) ? 180 : 0;
        generateEffect(x, y, "soft wall contact", _smokeDir);
        xsp = -sign(xsp) * 0.5;
        ysp *= 0.75;
        playerStateChange("free");
    }
}
