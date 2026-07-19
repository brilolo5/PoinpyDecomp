playerControlLock();

switch (currentSequence)
{
    case "init":
        with (oOrderControl)
            satisfactionMeter_draw = 0;
        
        sequenceTimer += doDelta(0.016666666666666666);
        
        if (sequenceTimer >= 1)
        {
            currentSequence = "player enter";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "player enter":
        if (sequenceInit)
        {
            sequenceInit = 0;
            
            with (oPlayer)
            {
                currentState = "spin jump";
                ysp = -8.8;
            }
        }
        
        sequenceTimer += doDelta(1/120);
        
        if (sequenceTimer >= 1)
        {
            currentSequence = "start shake";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "start shake":
        if (sequenceInitialize())
            playSoundBeastEnterRumble();
        
        var _shakeAmount = 0.5;
        _shakeAmount = clamp(sequenceTimer, 0.5, 1) * 1;
        screenShake(_shakeAmount, 2);
        sequenceTimer += doDelta(1/120);
        
        if (sequenceTimer >= 1)
        {
            currentSequence = "beast enter";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "beast enter":
        if (sequenceInit)
        {
            sequenceInit = 0;
            playSoundBeastEnterWhoosh();
            
            with (oBeastMainGame)
                gameStartBeastEnterTweenStart = 1;
        }
        
        _shakeAmount = 0.5;
        _shakeAmount = clamp(1 - sequenceTimer, 0, 1) * 2;
        screenShake(_shakeAmount, 2);
        sequenceTimer += doDelta(1/120);
        
        if (sequenceTimer >= 1)
        {
            currentSequence = "pause 1";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "pause 1":
        if (sequenceInit)
            sequenceInit = 0;
        
        sequenceTimer += doDelta(0.009523809523809525);
        
        if (sequenceTimer >= 1)
        {
            currentSequence = "screen darken";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "screen darken":
        if (sequenceInit)
            sequenceInit = 0;
        
        darkOverlayTween = approach(darkOverlayTween, 2, doDelta(0.037037037037037035));
        var _overlayAlpha = darkOverlayTween * 0.4;
        _overlayAlpha = clamp(_overlayAlpha, 0, 0.4);
        drawRectangleFast(global.windowLeft, global.windowTop, global.windowRight, global.windowBottom, make_color_rgb(46, 50, 59), _overlayAlpha);
        sequenceTimer += doDelta(0.016666666666666666);
        
        if (sequenceTimer >= 1)
        {
            currentSequence = "feed instruction";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "feed instruction":
        if (sequenceInit)
        {
            sequenceInit = 0;
            textOffsety = 4;
        }
        
        darkOverlayTween = approach(darkOverlayTween, 2, doDelta(1/15));
        _overlayAlpha = darkOverlayTween * 0.4;
        _overlayAlpha = clamp(_overlayAlpha, 0, 0.4);
        drawRectangleFast(global.windowLeft, global.windowTop, global.windowRight, global.windowBottom, make_color_rgb(46, 50, 59), _overlayAlpha);
        
        if (darkOverlayTween >= 1.2)
        {
            if (textOffsety == 4)
            {
                var _introMusic = playSfxUI(music_firstMainGameLeadIn, false, true);
                audioSetVolume(_introMusic, 0.6);
                sequenceTimer = 0;
            }
            
            var _text = loc("main game instruction");
            drawTextOutlined(global.windowCenterx, (global.windowMiddley / 1.5) + textOffsety, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 1, 150);
            textOffsety = approach(textOffsety, 0, doDelta(2));
        }
        
        sequenceTimer += doDelta(0.003472222222222222);
        
        if (sequenceTimer >= 1)
        {
            currentSequence = "recipe appear";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "recipe appear":
        if (sequenceInit)
        {
            sequenceInit = 0;
            recipeForceOff = 0;
            
            with (oOrderControl)
            {
                recipeRiseSequence = 1;
                satisfactionMeter_draw = 1;
                angerTimer = angerTimerMax * 1.2;
            }
            
            with (oPlayer)
                myAlarm9.setTimer(12);
            
            textOffsety = 4;
        }
        
        darkOverlayTween = approach(darkOverlayTween, 0, doDelta(0.16666666666666666));
        _overlayAlpha = darkOverlayTween * 0.4;
        _overlayAlpha = clamp(_overlayAlpha, 0, 0.4);
        drawRectangleFast(global.windowLeft, global.windowTop, global.windowRight, global.windowBottom, make_color_rgb(46, 50, 59), _overlayAlpha);
        
        if (sequenceTimer > 0.07666666666666666)
        {
            var _text = loc("main game start");
            drawSetAlign(1, 1);
            drawTextOutlined(global.windowCenterx, (global.windowMiddley / 1.5) + textOffsety, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 2, 140);
            textOffsety = approach(textOffsety, 0, 2);
        }
        
        sequenceTimer += doDelta(0.006666666666666667);
        playerControlLockRelease();
        
        if (sequenceTimer >= 1)
        {
            currentSequence = "end";
            sequenceTimer = 0;
            sequenceInit = 1;
            
            with (oOrderControl)
                drawSideGoalText = 1;
            
            instance_destroy();
        }
        
        break;
    
    default:
        break;
}

if (recipeForceOff)
{
    with (oOrderControl)
        recipeRiseSequence = 1;
}
