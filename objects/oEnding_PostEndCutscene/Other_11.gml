global.playerControlLock = 1;
targetDelta = 0.016666666666666666;
actualDelta = delta_time / 1000000;
deltaRate = actualDelta / targetDelta;

if (mouse_check_button_pressed(mb_right))
    audio_sound_set_track_position(sfx_ending_full, 40);

if (audioStart)
{
    audioStartAlarm -= deltaRate;
    
    if (audioStartAlarm <= 0)
    {
        endingAudio = playSfxUI(sfx_ending_full, 0, 1);
        audioStart = 0;
    }
}

if (darkAlpha < 1)
{
    if (dreamBubbleZoomOutSequence == -1)
    {
        if (audio_is_playing(sfx_ending_full))
            endingAudioPosition = round(audio_sound_get_track_position(audioGetByAsset(sfx_ending_full)) * 60) - 720;
        
        var _countingupTime = 0;
        var _pCountingupTime = 0;
        
        for (var i = 0; i < (assetIndexMax + 1); i += 1)
        {
            var _curveSp = sceneSpeed[i];
            var _sceneLength = 1 / _curveSp;
            _countingupTime += _sceneLength;
            
            if (endingAudioPosition < _countingupTime)
            {
                assetIndex = i;
                currentAnimCurve = sceneCurve[assetIndex];
                currentSceneSprite = sceneSprite[assetIndex];
                currentSceneBgSprite = sceneBgSprite[assetIndex];
                currentSceneBgIndex = sceneBgIndex[assetIndex];
                curvePos = (endingAudioPosition - _pCountingupTime) / _sceneLength;
                break;
            }
            else if (i >= assetIndexMax)
            {
                if (i >= assetIndexMax)
                    assetIndex = assetIndexMax;
                
                sceneEnd = 1;
                currentAnimCurve = sceneCurve[assetIndex];
                currentSceneSprite = sceneSprite[assetIndex];
                currentSceneBgSprite = sceneBgSprite[assetIndex];
                currentSceneBgIndex = sceneBgIndex[assetIndex];
                curvePos = ((endingAudioPosition - _pCountingupTime) / _sceneLength) % 1;
            }
            else
            {
            }
            
            _pCountingupTime += _sceneLength;
        }
    }
    
    if (dreamBubbleZoomOutSequence == -1)
        curvePos += (curveSp * deltaRate);
    
    var _animCurve = animcurve_get(currentAnimCurve);
    var _animCurveChannel = animcurve_get_channel(_animCurve, "index");
    var _animCurveIndex = round(animcurve_channel_evaluate(_animCurveChannel, curvePos));
    currentSceneSpriteIndex = _animCurveIndex;
    var _sprHeight = sprite_get_height(currentSceneSprite);
    var _sprScale = (global.applicationSurfaceDrawHeight / _sprHeight) + (dbShrink * 0.1);
    
    if (currentSceneBgSprite != -1)
    {
        draw_clear(c_black);
        draw_sprite_ext(currentSceneBgSprite, currentSceneBgIndex, global.windowCenterx, global.windowMiddley, _sprScale, _sprScale, 0, c_white, 1);
    }
    
    draw_sprite_ext(currentSceneSprite, currentSceneSpriteIndex, global.windowCenterx, global.windowMiddley, _sprScale, _sprScale, 0, c_white, 1);
}

if (sceneEnd)
{
    darkAlpha = approach(darkAlpha, 1, 0.0020833333333333333 * deltaRate);
    var _darkFrames = 4;
    var _darkAlpha = round(darkAlpha * _darkFrames) / _darkFrames;
    draw_set_color(make_color_rgb(46, 50, 59));
    draw_set_alpha(_darkAlpha);
    draw_rectangle(global.windowLeft, global.windowTop, global.windowRight, global.windowBottom, 0);
    draw_set_alpha(1);
    
    if (darkAlpha >= 1)
    {
        thankYouTextAppearTimer += (0.004166666666666667 * deltaRate);
        
        if (thankYouTextAppearTimer >= 1 && thankYouTextDisappearTimer <= 1)
        {
            var _textSize = 0.5;
            scribble(loc("ending post end thank you for playing")).starting_format(global.defaultFont, make_color_rgb(255, 255, 255)).blend(make_color_rgb(255, 255, 255), 1).transform(_textSize, _textSize, 0).wrap(150 / _textSize, -1, locIsAsian()).align(1, 1).draw(global.windowCenterx, global.windowMiddley);
            thankYouTextDisappearTimer += (0.004166666666666667 * deltaRate);
        }
    }
}

if (thankYouTextDisappearTimer >= 1 && !resultScreenAppear)
{
    skipped = 1;
    var _darkScreenLength = 180;
    
    if (global.endingReached >= UnknownEnum.Value_2)
        _darkScreenLength = 30;
    
    resultScreenAppearTimer += ((1 / _darkScreenLength) * deltaRate);
    
    if (resultScreenAppearTimer >= 1)
    {
        resultScreenAppear = 1;
        
        if (global.endingReached <= UnknownEnum.Value_1)
        {
            instance_create_depth(x, y, 0, oPostEndUnlockScreen);
            global.endingReached = UnknownEnum.Value_2;
        }
        else
        {
            instance_create_depth(x, y, 0, oResultsScreen);
        }
    }
}

if (dreamBubbleZoomOutSequence != -1)
{
    var _dbOffsetx = dbOffsetx;
    var _dbOffsety = dbOffsety;
    initialThankYouTextOffsetRate = approach(initialThankYouTextOffsetRate, -2, 0.0016666666666666668 * deltaRate);
    
    switch (dreamBubbleZoomOutSequence)
    {
        case "thank you rising":
            dbShrink = 1;
            
            if (initialThankYouTextOffsetRate <= 0.75)
            {
                dreamBubbleZoomOutSequence = "bubble shrink";
                audioStart = 1;
            }
            
            break;
        
        case "bubble shrink":
            dreamBubbleZoomOutSequenceTimer += (0.001851851851851852 * deltaRate);
            var _animCurveIndex;
            
            if (dreamBubbleZoomOutSequenceTimer < 0.5)
            {
                var _animCurve = animcurve_get(curveSine);
                var _animCurveChannel = animcurve_get_channel(_animCurve, "curve1");
                _animCurveIndex = animcurve_channel_evaluate(_animCurveChannel, dreamBubbleZoomOutSequenceTimer / 0.5);
                _animCurveIndex = _animCurveIndex * 0.5;
            }
            else
            {
                var _animCurve = animcurve_get(curveSineInv);
                var _animCurveChannel = animcurve_get_channel(_animCurve, "curve1");
                _animCurveIndex = animcurve_channel_evaluate(_animCurveChannel, (dreamBubbleZoomOutSequenceTimer - 0.5) / 0.5);
                _animCurveIndex = (_animCurveIndex * 0.5) + 0.5;
            }
            
            dbShrink = 1 - _animCurveIndex;
            
            if (dreamBubbleZoomOutSequenceTimer >= 1)
            {
                dreamBubbleZoomOutSequenceTimer -= 1;
                dreamBubbleZoomOutSequence = "bubble linger before pop";
            }
            
            break;
        
        case "bubble linger before pop":
            dreamBubbleZoomOutSequenceTimer += (0.004166666666666667 * deltaRate);
            
            if (dreamBubbleZoomOutSequenceTimer >= 1)
                dreamBubbleZoomOutSequence = -1;
            
            break;
    }
    
    _dbOffsety += (sin(global.time / 50) * 2);
    var _cr = global.surfaceCompressionRate;
    var _bubbleW = sprite_get_width(sUItestThoughtCloud);
    var _bubbleH = sprite_get_height(sUItestThoughtCloud);
    var _surfW = global.applicationSurfaceDrawWidth * _cr;
    var _surfH = global.applicationSurfaceDrawHeight * _cr;
    
    if (surface_exists(dbCropSurface))
        surface_resize_track(dbCropSurface, _surfW, _surfH);
    else
        dbCropSurface = surface_create_track(_surfW, _surfH);
    
    if (surface_exists(dbInsideSurface))
        surface_resize_track(dbInsideSurface, _surfW, _surfH);
    else
        dbInsideSurface = surface_create_track(_surfW, _surfH);
    
    if (surface_exists(dbCropSurface))
    {
        surface_set_target(dbCropSurface);
        draw_clear(c_black);
        gpu_set_blendmode(bm_subtract);
        var _surfCenterx = _surfW / 2;
        var _surfMiddley = _surfH / 2;
        var _bubblex = _surfCenterx + (_dbOffsetx * _cr);
        var _bubbley = _surfMiddley + (_dbOffsety * _cr);
        var _bubbleBaseScale = 0.1 * _cr * 1.4;
        var _bubbleScale = _bubbleBaseScale * (1 + (dbShrink * 16));
        draw_sprite_ext(sUItestThoughtCloud, 0, _bubblex, _bubbley, _bubbleScale, _bubbleScale, 0, c_white, 1);
        gpu_set_blendmode(bm_normal);
        surface_reset_target();
        
        if (surface_exists(dbInsideSurface))
        {
            surface_set_target(dbInsideSurface);
            draw_clear(make_color_rgb(255, 255, 255));
            var _bgTileScale = (dbShrink * 0.5) + 0.5;
            var _logoScale = 0.1 * _cr * (0.75 + (dbShrink * 0.25));
            var _flippedDbShrink = 1 - dbShrink;
            var _textOffsety = initialThankYouTextOffsetRate * (global.viewHeight / 2) * _cr;
            var _textScale = _logoScale * 4;
            scribble(loc("ending thank you for playing")).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).blend(make_color_rgb(46, 50, 59), 1).transform(_textScale, _textScale, 0).align(1, 0).wrap(280, -1, locIsAsian()).draw((_surfW / 2) + (dbOffsetx * _cr * _flippedDbShrink), _textOffsety + (_surfH / 2) + (dbOffsety * _cr * _flippedDbShrink) + (sin(global.time / 30) * 2));
            var _outlineSurfScale = 0.95;
            var _outlineSurfx = (_surfW - (_surfW * _outlineSurfScale)) / 2;
            var _outlineSurfy = (_surfH - (_surfH * _outlineSurfScale)) / 2;
            gpu_set_blendmode(bm_subtract);
            draw_surface(dbCropSurface, 0, 0);
            gpu_set_blendmode(bm_normal);
            surface_reset_target();
            dreamBubbleScaleDefault = 16;
            dreamBubbleScale = dreamBubbleScaleDefault;
            var _surfaceScale = 0.1 * dreamBubbleScale;
            var _outlineBaseWidth = 1.5;
            var _outlineWidth = 10;
            draw_surface_stretched(dbInsideSurface, global.windowLeft, global.windowTop, global.applicationSurfaceDrawWidth, global.applicationSurfaceDrawHeight);
        }
    }
}
