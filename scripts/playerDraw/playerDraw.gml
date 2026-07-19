function playerDraw(arg0, arg1)
{
    var _playerPosx = arg0;
    var _playerPosy = arg1;
    var _checkMbHeld = (mbHeld && slingLength >= 2) ? 1 : 0;
    playerDrawx = _playerPosx + dcx;
    playerDrawy = _playerPosy + dcy;
    
    if (selfShake)
    {
        playerDrawx += irandom_range(-selfShakeAmount, selfShakeAmount);
        playerDrawy += irandom_range(-selfShakeAmount, selfShakeAmount);
        selfShake -= 1;
    }
    
    if (damageInvincibility)
    {
    }
    
    if (_checkMbHeld)
    {
        if (readyToJump)
        {
            if ((global.jumpTimes == 1 && abilityCheck(UnknownEnum.Value_13)) || currentState == "invincible spin jump" || (currentState == "in bubble" && stateBeforeBubble == "invincible spin jump"))
                playerDrawTrajectory_invincible(x, cx, y, cy, slingLength, xspSet, yspSet);
            else
                playerDrawTrajectory(x, cx, y, cy, slingLength, xspSet, yspSet);
        }
        
        with (oGimCannon)
        {
            trajectoryExtend = 1;
            
            if (abs(y - other.y) < 256)
            {
                var _dir = global.cannonTempSlingAngle + 90;
                var _launchSpeed = 7;
                
                if (global.wideGame)
                    _launchSpeed = 8;
                
                cx = 0;
                cy = 0;
                grv = oPlayer.grv;
                var _gimxsp = lengthdir_x(_launchSpeed, _dir);
                var _gimysp = lengthdir_y(_launchSpeed, _dir);
                var _cannonTipLength = 18;
                var _cannonTipx = x + lengthdir_x(_cannonTipLength, _dir);
                var _cannonTipy = y + lengthdir_y(_cannonTipLength, _dir);
                playerDrawTrajectory_invincible(_cannonTipx, 0, _cannonTipy, 0, _launchSpeed, _gimxsp, _gimysp);
            }
        }
    }
    else if (currentState == "in cannon")
    {
        var _dir = myCannon.cannonAngle + 90;
        var _launchSpeed = 7;
        var _xspSet = lengthdir_x(_launchSpeed, _dir);
        var _yspSet = lengthdir_y(_launchSpeed, _dir);
        playerDrawTrajectory_invincible(x, cx, y, cy, _launchSpeed, _xspSet, _yspSet);
    }
    else
    {
        trajectoryTweenXsp = 0;
        trajectoryTweenYsp = 0;
        trajecoryDashAppearTween = 1;
        trajectoryExtend = 0;
    }
    
    if (damageInvincibilityFlash)
    {
        spriteFlash = 0;
        
        if (!(round(damageInvincibility / 2) % 4))
            selfAlpha = 0.1;
        else
            selfAlpha = 1;
    }
    else
    {
        selfAlpha = 1;
        spriteFlash = 0;
    }
    
    if (whiteFlash)
    {
        shader_set_track(shaderWhiteFlash);
        whiteFlash -= global.timeScale;
    }
    
    xscale = approach(xscale, 1, 0.05 * global.timeScale);
    yscale = approach(yscale, 1, 0.05 * global.timeScale);
    var _playerBaseScale = 0.1;
    
    if (!spriteFlash)
    {
        if ((currentState == "spin jump" || currentState == "invincible spin jump" || currentState == "cog cling") && sprite_index == sPlayerSpin8)
        {
            var _currentFrame = image_index;
            var _previousFrame = previousImageIndex;
            var _spriteFrames = sprite_get_number(sprite_index);
            
            if (_currentFrame < _previousFrame)
                _currentFrame += _spriteFrames;
            
            var _skippedFrames = _currentFrame - _previousFrame;
            
            for (var i = _skippedFrames; i > 0; i -= 1)
            {
                var _drawingPrvFrame = (_currentFrame - i) % _spriteFrames;
                draw_sprite_ext(sprite_index, _drawingPrvFrame, playerDrawx, playerDrawy, xDirection * xscale * _playerBaseScale, yscale * _playerBaseScale, 0, c_white, 0.75);
            }
        }
        
        draw_sprite_ext(sprite_index, image_index, playerDrawx, playerDrawy, xDirection * xscale * _playerBaseScale, yscale * _playerBaseScale, 0, c_white, selfAlpha);
    }
    
    shader_reset_track();
    previousImageIndex = image_index;
}
