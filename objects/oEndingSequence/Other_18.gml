if (mouse_check_button_pressed(mb_right))
{
    nextSequence("white out player moved hold a moment");
    
    with (oBeastMainGame)
        instance_destroy();
}

drawFakePlayer = function(arg0, arg1, arg2, arg3, arg4 = sPlayerHeu, arg5 = 1, arg6 = 0)
{
    playerFloatWobbleTime += doDelta(1);
    var playerFloatWobbleOffset = sin(playerFloatWobbleTime / 45) * arg2;
    arg0 += random_range(-arg3, arg3);
    arg1 += random_range(-arg3, arg3);
    arg1 += playerFloatWobbleOffset;
    draw_sprite_ext(arg4, arg5, arg0, arg1, 0.1, 0.1, 0, c_white, 1);
};

drawWhiteOut = function(arg0)
{
    draw_set_color(make_color_rgb(255, 255, 255));
    draw_set_alpha(arg0);
    drawRectFromCenter(guiXToRoom(global.viewWidth / 2), guiYToRoom(global.viewHeight / 2), global.viewWidth, global.viewHeight, 0);
    draw_set_alpha(1);
};

drawPrimDiamond = function(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    draw_set_color(arg5);
    draw_set_alpha(arg6 + random_range(-0.1, 0.1));
    draw_primitive_begin(pr_trianglefan);
    arg2 = clamp(arg2, 0, 360);
    draw_vertex(arg0, arg1);
    
    if (arg2 < 180)
    {
        var _ax = lengthdir_x(arg4, arg3 - (arg2 / 2));
        var _ay = lengthdir_y(arg4, arg3 - (arg2 / 2));
        draw_vertex(arg0 + _ax, arg1 + _ay);
        var _tipx = lengthdir_x(arg4, arg3);
        var _tipy = lengthdir_y(arg4, arg3);
        draw_vertex(arg0 + _tipx, arg1 + _tipy);
        var _bx = lengthdir_x(arg4, arg3 + (arg2 / 2));
        var _by = lengthdir_y(arg4, arg3 + (arg2 / 2));
        draw_vertex(arg0 + _bx, arg1 + _by);
    }
    else
    {
        var _ax = lengthdir_x(arg4, arg3 - (arg2 / 2));
        var _ay = lengthdir_y(arg4, arg3 - (arg2 / 2));
        draw_vertex(arg0 + _ax, arg1 + _ay);
        var _rtipx = lengthdir_x(arg4, arg3 - 90);
        var _rtipy = lengthdir_y(arg4, arg3 - 90);
        draw_vertex(arg0 + _rtipx, arg1 + _rtipy);
        var _tipx = lengthdir_x(arg4, arg3);
        var _tipy = lengthdir_y(arg4, arg3);
        draw_vertex(arg0 + _tipx, arg1 + _tipy);
        var _ltipx = lengthdir_x(arg4, arg3 + 90);
        var _ltipy = lengthdir_y(arg4, arg3 + 90);
        draw_vertex(arg0 + _ltipx, arg1 + _ltipy);
        var _bx = lengthdir_x(arg4, arg3 + (arg2 / 2));
        var _by = lengthdir_y(arg4, arg3 + (arg2 / 2));
        draw_vertex(arg0 + _bx, arg1 + _by);
    }
    
    draw_primitive_end();
    draw_set_color(c_white);
    draw_set_alpha(1);
};

drawDreamBg = function(arg0 = 0)
{
    drawSetInterpolation(false);
    drawTranscendenceBg(arg0);
    drawSetInterpolation(true);
};

switch (currentSequence)
{
    case "nudge player":
        var _beastx = oBeastMainGame.beastBasex;
        var _beasty = oBeastMainGame.beastDrawy - 16 - 4;
        draw_set_color(make_color_rgb(255, 255, 255));
        draw_set_alpha(random_range(0.5, 1));
        draw_circle(_beastx - (1 * (os_type == os_windows)), _beasty - (1 * (os_type == os_windows)) - 2, 1, 0);
        draw_set_alpha(1);
        break;
    
    case "beam - appear":
        if (sequenceInitialize())
        {
            with (oGameBackground)
                bgArea = UnknownEnum.Value_6;
            
            with (oPlayer)
                playerVisible = 1;
            
            global.endingDialogMusic = playMusicUI(music_beastBeamWipe, 0, 1);
            playerStartFloating = 0;
            beamLength = 64;
            beamHoldBeforeOpening = 0;
            beamColorScroll = 0;
            screenShake(10, 7);
        }
        
        _beastx = oBeastMainGame.beastBasex;
        _beasty = oBeastMainGame.beastDrawy - 16 - 4 - 2;
        beamHoldBeforeOpening = approach(beamHoldBeforeOpening, 1, doDelta(0.004166666666666667));
        
        if (beamHoldBeforeOpening >= 1)
            beamTime += doDelta(0.002564102564102564);
        
        var _beamTestCycle = beamTime % 1.25;
        var _sShakeAmount = 0.25 + (2 * _beamTestCycle);
        screenShake(_sShakeAmount, 4);
        var _beamTestCycleRatio = animcurveGetValueAtPos(acHeadBeamWhiteOut, "curve1", _beamTestCycle);
        _beamTestCycleRatio = clamp(_beamTestCycleRatio, 0, 1);
        var _beamAngleMax = 360;
        var _beamAngle = 360 * _beamTestCycleRatio;
        var _beamStartAngle = 90;
        var _beamHeight = 64;
        var _diamondSize = beamLength;
        drawPrimDiamond(_beastx, _beasty, _beamAngle * 3, 90, _diamondSize, getAuroraColor(0.8, undefined, undefined, beamColorScroll), (0.5 * beamTime) + 0.1);
        drawPrimDiamond(_beastx, _beasty, _beamAngle * 2, 90, _diamondSize, getAuroraColor(0.8, undefined, undefined, beamColorScroll), (1 * beamTime) + 0.2);
        drawPrimDiamond(_beastx, _beasty + 1, _beamAngle, 90, _diamondSize, make_color_rgb(255, 255, 255), 1);
        beamLength = approach(beamLength, 500, doDelta(100));
        draw_set_color(make_color_rgb(255, 255, 255));
        
        if ((beamTime > 0.8 && !playerStartFloating) || sequenceTimer >= 1)
        {
            playerStartFloating = 1;
            
            with (oPlayer)
                playerVisible = 0;
            
            playerystart = oPlayer.y;
            playerxstart = oPlayer.x;
            playerx = oPlayer.x;
            playery = oPlayer.y;
            playerxgoal = guiXToRoom(global.viewWidth / 2);
            playerxgoal = playerxstart;
        }
        
        if (playerStartFloating)
        {
            playery = deltaLerp(playery, playerystart - 8, 0.05);
            drawFakePlayer(playerx, playery, 0, (1 - sequenceTimer) * 4, undefined, 2);
        }
        
        if (beamTime > 1 || sequenceTimer >= 1)
        {
            beamTime = 0;
            nextSequence("white out player visible");
        }
        
        break;
    
    case "white out player visible":
        if (sequenceInitialize())
        {
            with (oGameBackground)
                bgArea = -1;
            
            with (oPlayer)
                playerVisible = 0;
            
            with (oBeastMainGame)
                instance_destroy();
            
            playerystart = playery;
            playerxstart = playerx;
            playerxgoal = playerxstart + (sign((playerx - (global.viewWidth / 2)) + 0.1) * 8);
            playerxgoal = clamp(playerxgoal, 16, global.viewWidth - 16);
            playerRiseAnimationTime = 0;
        }
        
        drawWhiteOut(1);
        playerRiseAnimationTime = approach(playerRiseAnimationTime, 1, doDelta(0.011111111111111112));
        var _acValue = animcurveGetValueAtPos(curveExpoInv, "curve1", playerRiseAnimationTime);
        playery = lerp(playerystart, playerystart - 32, _acValue);
        playerx = lerp(playerxstart, playerxgoal, _acValue);
        drawFakePlayer(playerx, playery, 0, (1 - sequenceTimer) * 4);
        var _sequenceTime = 300;
        
        if (sequenceTimerIncrementAndCheck(_sequenceTime))
            nextSequence("white out player float");
        
        break;
    
    case "white out player float":
        if (sequenceInitialize())
        {
        }
        
        drawWhiteOut(1);
        var _playerDrawx = playerx;
        var _playerDrawy = playery;
        drawFakePlayer(_playerDrawx, _playerDrawy, 0, 0.2 * (1 - sequenceTimer));
        _sequenceTime = 300;
        
        if (sequenceTimerIncrementAndCheck(_sequenceTime))
            nextSequence("moment before poinpy starts moving");
        
        break;
    
    case "moment before poinpy starts moving":
        if (sequenceInitialize())
            global.endingDialogMusic = playMusicUI(music_poinpyFloats, 0, 1);
        
        drawWhiteOut(1);
        _playerDrawx = playerx;
        _playerDrawy = playery;
        drawFakePlayer(_playerDrawx, _playerDrawy, 0, 0);
        _sequenceTime = 60;
        
        if (sequenceTimerIncrementAndCheck(_sequenceTime))
            nextSequence("white out player move into place");
        
        break;
    
    case "white out player move into place":
        if (sequenceInitialize())
        {
            playerxstart = playerx;
            playerystart = playery;
            playerWobbleValue = 0;
        }
        
        drawWhiteOut(1);
        playerGoalPosx = guiXToRoom(global.viewWidth / 2);
        playerGoalPosy = guiYToRoom((global.viewHeight / 7) * 5);
        var _acValuex = animcurveGetValueAtPos_combine2(curveSine, "curve1", curveSineInv, "curve1", 0.5, sequenceTimer);
        var _acValuey = animcurveGetValueAtPos_combine2(curveBack, "curve1", curveBackInv, "curve1", 0.5, sequenceTimer);
        playerx = lerp(playerxstart, playerGoalPosx, _acValuex);
        playery = lerp(playerystart, playerGoalPosy, _acValuey);
        playerWobbleValue = 0;
        drawFakePlayer(playerx, playery, playerWobbleValue, 0);
        _sequenceTime = 420;
        
        if (sequenceTimerIncrementAndCheck(_sequenceTime))
            nextSequence("white out player moved hold a moment");
        
        break;
    
    case "white out player moved hold a moment":
        if (sequenceInitialize())
        {
            with (oGameBackground)
                bgArea = -1;
            
            with (oPlayer)
                playerVisible = 0;
            
            playerGoalPosx = guiXToRoom(global.viewWidth / 2);
            playerGoalPosy = guiYToRoom((global.viewHeight / 7) * 5);
            playerx = playerGoalPosx;
            playery = playerGoalPosy;
            playerWobbleValue = 0;
        }
        
        drawWhiteOut(1);
        playerWobbleValue = sequenceTimer * 2;
        drawFakePlayer(playerx, playery, playerWobbleValue, 0);
        _sequenceTime = 120;
        
        if (sequenceTimerIncrementAndCheck(_sequenceTime))
            nextSequence("white out fade");
        
        break;
    
    case "white out fade":
        if (sequenceInitialize())
        {
            _backgroundSound = -1;
            _oceanbackgroundSound = playSoundEndingTrippyBackground();
            beamWhiteOutAlpha = 1;
            bgBreatheScrollTime = 0;
        }
        
        beamWhiteOutAlpha = approach(beamWhiteOutAlpha, 0, doDelta(0.0033333333333333335));
        bgBreatheScrollTime = sin(current_time / 2500) * 8;
        drawDreamBg();
        drawWhiteOut(beamWhiteOutAlpha);
        drawFakePlayer(playerx, playery, playerWobbleValue, 0, undefined, undefined, 1);
        _sequenceTime = 420;
        
        if (sequenceTimerIncrementAndCheck(_sequenceTime))
            nextSequence("message appear");
        
        break;
    
    case "message appear":
        if (sequenceInitialize())
            instance_create_depth(0, 0, 0, oEndingSequence_BeastDialogue);
        
        drawDreamBg();
        drawFakePlayer(playerx, playery, playerWobbleValue, 0, undefined, undefined, 1);
        _sequenceTime = 360;
        break;
    
    case "message ended":
        if (sequenceInitialize())
        {
            playSoundEndingTransitionRumble(_oceanbackgroundSound);
            delayBeforeWhiteOut = 0;
            finalWhiteOutAlpha = 0;
            finalWhiteOutAlpha2 = 0;
            killMusic = 0;
        }
        
        delayBeforeWhiteOut = approach(delayBeforeWhiteOut, 1, doDelta(1/120));
        
        if (delayBeforeWhiteOut >= 1)
        {
            finalWhiteOutAlpha = approach(finalWhiteOutAlpha, 1, doDelta(0.005555555555555556));
            
            if (!killMusic)
            {
                killMusic = 1;
                
                with (oEndingSequence_BeastDialogue)
                    audioFadeOut(dialogMusic, 0.005555555555555556);
            }
            
            if (finalWhiteOutAlpha >= 1)
                finalWhiteOutAlpha2 = approach(finalWhiteOutAlpha2, 1, doDelta(1/30));
        }
        
        screenShake((3 * finalWhiteOutAlpha) + 0.5, 2);
        drawDreamBg(0.75);
        bgForceFillWhite = finalWhiteOutAlpha;
        drawFakePlayer(playerx, playery, playerWobbleValue, 3 * finalWhiteOutAlpha, undefined, undefined, 1);
        drawWhiteOut(finalWhiteOutAlpha2);
        
        if (finalWhiteOutAlpha2 >= 1)
        {
            _sequenceTime = 180;
            
            if (sequenceTimerIncrementAndCheck(_sequenceTime))
            {
                with (oEndingSequence_BeastDialogue)
                    _nextSequence("i love you");
                
                nextSequence("all white");
            }
        }
        
        break;
    
    case "all white":
        if (sequenceInitialize())
        {
        }
        
        drawWhiteOut(1);
        break;
    
    default:
        break;
}
