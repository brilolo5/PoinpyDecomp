var centerx = global.windowCenterx;

if (!abilityCheck(UnknownEnum.Value_22) && drawSideGoalText)
{
    var _goalTextPosx = (((global.windowLeft + 16) - 1 - 8 - 4) + 4 + 2) - 4 - 1;
    var _goalTextPosy = ((((global.windowTop + 32 + 16 + 16 + 10) - 10 - 10 - 8) + 1 + global.notchOffset) - 10) + 12;
    
    if (sideGoalTextAppearAnimTracker < 1)
    {
        sideGoalTextAppearAnimTracker += doDelta(0.016666666666666666);
        var _curveValue = animcurveGetValueAtPos(curveBackInv, "curve1", sideGoalTextAppearAnimTracker);
        var _enterAnimWidth = 52;
        _goalTextPosx += (-_enterAnimWidth + (_enterAnimWidth * _curveValue));
    }
    
    var _bgBoxLeft = _goalTextPosx - 8 - 16;
    var _bgBoxRight = (((((_goalTextPosx + 64) - 16) + 8) - 8 - 8) + 2 + 2 + 2 + 4 + 4) - 8;
    var _bgBoxTop = _goalTextPosy - 12;
    var _bgBoxBottom = (_goalTextPosy + 12) - 1;
    var _goalTextSize = 0.45;
    draw_set_color(make_color_rgb(46, 50, 59));
    draw_set_alpha(1);
    draw_set_color(make_color_rgb(46, 50, 59));
    
    if (meterLevel < 20)
    {
        var _areaUnlockThreshold = getAreaDiscoveryThreshold();
        var _goalTextBoxColor, _goalTextBoxAlpha, _nextDiscoveryText;
        
        if (_areaUnlockThreshold > 0 || instance_exists(oDiscoveryLine))
        {
            _areaUnlockThreshold = getAreaDiscoveryThreshold();
            
            if (meterLevel >= _areaUnlockThreshold || instance_exists(oDiscoveryLine))
            {
                _nextDiscoveryText = "[wave][cycle,32,43]" + loc("main game UI discovery imminent");
                _goalTextBoxColor = make_color_rgb(69, 80, 97);
                _goalTextBoxAlpha = 0.75;
                
                if (thresholdOfAreaBeingDiscovered > global.areaUnlockThreshold[0])
                {
                    if (ObjectiveUICompleteSound == 0)
                        playSoundObjectiveUIComplete();
                    
                    ObjectiveUICompleteSound = 1;
                    goalTextWobbleAnimation = (goalTextWobbleAnimation + doDelta(0.041666666666666664)) % 6;
                    _areaUnlockThreshold = thresholdOfAreaBeingDiscovered;
                }
            }
            else
            {
                ObjectiveUICompleteSound = 0;
                goalTextWobbleAnimation = 0;
                thresholdOfAreaBeingDiscovered = _areaUnlockThreshold;
            }
            
            if (thresholdOfAreaBeingDiscovered >= 4)
            {
                _nextDiscoveryText = "" + loc("main game UI next discovery", locGetNumFont(true) + string(thresholdOfAreaBeingDiscovered) + "[" + locGetFontFromLanguage() + "]");
                _nextDiscoveryText += (locGetNumFont(true) + "\n(" + string(meterLevel) + "/" + string(thresholdOfAreaBeingDiscovered) + ")");
                _goalTextBoxColor = make_color_rgb(248, 45, 97);
                
                switch (thresholdOfAreaBeingDiscovered)
                {
                    case global.areaUnlockThreshold[1]:
                        _goalTextBoxColor = make_color_rgb(36, 145, 249);
                        break;
                    
                    case global.areaUnlockThreshold[2]:
                        _goalTextBoxColor = make_color_rgb(248, 45, 97);
                        break;
                    
                    case global.areaUnlockThreshold[3]:
                        _goalTextBoxColor = make_color_rgb(225, 223, 1);
                        break;
                }
                
                _goalTextBoxAlpha = 0.5;
            }
            else
            {
                _goalTextBoxColor = make_color_rgb(65, 231, 125);
                _goalTextBoxAlpha = 0.5;
                _nextDiscoveryText = loc("main game instruction");
            }
        }
        else
        {
            goalTextWobbleAnimation = 0;
            _goalTextBoxColor = make_color_rgb(69, 80, 97);
            _goalTextBoxAlpha = 0.5;
            _nextDiscoveryText = loc("main game UI final area at", locGetNumFont(true) + string(20) + "[" + locGetFontFromLanguage() + "]");
            _nextDiscoveryText += (locGetNumFont(true) + "\n(" + string(meterLevel) + "/" + string(20) + ")");
        }
        
        var _boxScale = 0.08;
        _boxScale = 0.1;
        var _drawDoneText = 0;
        var _goalTextColor = make_color_rgb(255, 255, 255);
        var _goalTextBorderSize = 1.75;
        var _goalTextBoxOutlineColor = make_color_rgb(46, 50, 59);
        
        if (goalTextWobbleAnimation > 0)
        {
            _goalTextBoxAlpha = 0.9;
            
            if ((floor(goalTextWobbleAnimation) % 2) == 0)
                _goalTextBoxColor = merge_color(_goalTextBoxColor, make_color_rgb(255, 255, 255), 0.5);
            
            _drawDoneText = 1;
        }
        
        var _goalTextCurveValue = animcurveGetValueAtPos(acGoalTextWobble, "curve1", goalTextWobbleAnimation);
        _bgBoxTop += (_goalTextCurveValue * -16);
        
        if (goalTextWobbleRecordAnimCurve < _goalTextCurveValue)
        {
            if (!goalTextWobbleSound)
            {
                playSoundObjectiveShake();
                goalTextWobbleSound = 1;
            }
        }
        else
        {
            goalTextWobbleSound = 0;
        }
        
        goalTextWobbleRecordAnimCurve = _goalTextCurveValue;
        
        if (global.toggleObjectiveUI)
        {
            drawSetInterpolation(false);
            drawThreeSliceExt(sObjectiveBar3Slice_inside, _bgBoxLeft, _bgBoxRight, _bgBoxTop, _boxScale, _goalTextBoxColor, _goalTextBoxAlpha);
            drawThreeSliceExt(sObjectiveBar3Slice_outline, _bgBoxLeft, _bgBoxRight, _bgBoxTop, _boxScale, _goalTextBoxOutlineColor, 1);
            drawSetInterpolation(true);
            draw_set_color(c_white);
            draw_set_alpha(1);
            scribble(_nextDiscoveryText).starting_format(global.defaultFont, make_color_rgb(255, 255, 255)).blend(_goalTextColor, 1).line_height(10, 26).msdf_border(make_color_rgb(46, 50, 59), 5).transform(_goalTextSize / 2, _goalTextSize / 2, 0).fit_to_box(200, 72, locIsAsian()).align(0, 1).draw(_goalTextPosx, _bgBoxTop + 11);
            
            if (_drawDoneText)
            {
                _goalTextSize *= 2;
                scribble("[wave][cycle,32,43]" + loc("main game UI discovery imminent")).starting_format(global.defaultFont, make_color_rgb(255, 255, 255)).line_height(10, 26).msdf_border(make_color_rgb(46, 50, 59), 3).transform(_goalTextSize / 2, _goalTextSize / 2, 0).fit_to_box(140 * _goalTextSize, 32 * _goalTextSize, locIsAsian()).align(0, 0).draw(_goalTextPosx, _bgBoxTop + 12 + 8 + 4 + 2);
            }
        }
    }
}

var _levelUpTextCreate = 0;
var _drawRecipeUI = 1;

if (global.finalStretchSequence == UnknownEnum.Value_2)
    _drawRecipeUI = 0;

if (_drawRecipeUI)
    drawReadyBonusSign();

if (!abilityCheck(UnknownEnum.Value_22) && satisfactionMeter_draw)
{
    var cr = global.surfaceCompressionRate;
    var surfaceWidth = global.viewWidth * 0.85;
    var surfaceHeight = 16;
    surfaceWidth *= cr;
    surfaceHeight *= cr;
    var _sCenterx = surfaceWidth / 2;
    var _sCentery = surfaceHeight / 2;
    var _stomachMeterPosx = centerx - (surfaceWidth / cr / 2);
    var _stomachMeterPosy = (global.gameSurfaceTop + global.viewHeight) - 16 - 2 - 2 - (3 * sign(global.notchOffset));
    
    if (!surface_exists(_baseSurface))
        _baseSurface = surface_create_track(surfaceWidth, surfaceHeight);
    
    if (!surface_exists(_meterSurface))
        _meterSurface = surface_create_track(surfaceWidth, surfaceHeight);
    
    if (!surface_exists(_croppingSurface))
        _croppingSurface = surface_create_track(surfaceWidth, surfaceHeight);
    
    if (global.surfaceCompressionRateUpdate)
    {
        surface_resize_track(_baseSurface, surfaceWidth, surfaceHeight);
        surface_resize_track(_meterSurface, surfaceWidth, surfaceHeight);
        surface_resize_track(_croppingSurface, surfaceWidth, surfaceHeight);
    }
    
    var _stomachx = _sCenterx;
    var _stomachy = _sCentery + (surfaceWidth / 20);
    var _mainCircleSize = surfaceWidth / 3;
    var _outlineWidth = 1 * cr;
    var _outlineCircleSize = _mainCircleSize + _outlineWidth;
    var _subCircle1x = _stomachx + (_mainCircleSize / 1.5);
    var _subCircle1y = _stomachy + (_mainCircleSize / 1.6);
    var _subCircle1Size = surfaceWidth / 6;
    var _subOutline1Size = _subCircle1Size + _outlineWidth;
    var _subCircle2x = _stomachx - (_mainCircleSize / 2);
    var _subCircle2y = _stomachy - (_mainCircleSize / 1.1);
    var _subCircle2Size = surfaceWidth / 6;
    var _subOutline2Size = _subCircle2Size + _outlineWidth;
    surface_set_target(_croppingSurface);
    draw_clear_alpha(c_white, 0);
    draw_clear(make_color_rgb(46, 50, 59));
    gpu_set_blendmode(bm_subtract);
    draw_set_color(c_black);
    var _border = 1 * cr;
    draw_set_color(c_white);
    draw_roundrect_ext(0 + _border, 0 + _border, surfaceWidth - _border, surfaceHeight - _border, 8 * cr, 8 * cr, 0);
    gpu_set_blendmode(bm_normal);
    surface_reset_target();
    surface_set_target(_baseSurface);
    draw_clear_alpha(c_white, 0);
    _border = 0 * cr;
    draw_set_color(make_color_rgb(46, 50, 59));
    draw_roundrect_ext(0 + _border, 0 + _border, surfaceWidth - _border, surfaceHeight - _border, 10 * cr, 10 * cr, 0);
    surface_reset_target();
    surface_set_target(_meterSurface);
    draw_clear_alpha(c_white, 0);
    var _meterBottom = (_subCircle1y + _subCircle1Size) - cr;
    var _meterTop = (_subCircle2y - _subCircle2Size) + cr;
    var _stomachMeterValueMax = global.bossLevelThreshold[global.difficultyLevel + 1];
    var _stomachMeterValue = clamp(global.mainGameFruitProgress, 0, _stomachMeterValueMax);
    var _stomachMeterLengthMax = _meterBottom - _meterTop;
    var _stomachMeterRatio = _stomachMeterValue / _stomachMeterValueMax;
    var _stomachMeterLength = _stomachMeterLengthMax * _stomachMeterRatio;
    
    if (global.debugControl && keyboard_check_pressed(ord("F")))
    {
        fruitCountAdd(20, 4, 16);
        satisfactionMeterTween_dewReceived = 1;
        
        with (oPlayer)
            playerComboPayout(1);
    }
    
    var _meterRatio = global.mainGameFruitProgress / global.bossLevelThreshold[global.difficultyLevel + 1];
    var _meterLevelDifferenceToActualLevel = global.difficultyLevel - meterLevel;
    _meterRatio += _meterLevelDifferenceToActualLevel;
    
    if (satisfactionMeterTween_dewReceived)
    {
        if (!meterHeadFillSound)
        {
            playSoundHUDExperienceMoveHeadLoop();
            meterHeadFillSound = 1;
        }
        
        if (_meterRatio >= satisfactionMeterTween_main || satisfactionMeterTween_main >= 1)
        {
            if (satisfactionMeterTween_main >= 1)
            {
                satisfactionMeterTween_main = 0.04;
                satisfactionMeterTween_lateLooped = satisfactionMeterTween_late;
                satisfactionMeterTween_late = -0.1;
                meterLevel = approach(meterLevel, global.difficultyLevel + 1, 1);
                _meterRatio -= 1;
                satisfactionMeter_levelTextWobbleSequence = 1;
                satisfactionMeter_levelTextSize = 1.3;
                _levelUpTextCreate = 1;
            }
            
            satisfactionMeterTween_main += doDelta(clamp((_meterRatio - satisfactionMeterTween_main) * 0.05, 0.0015625, 0.041666666666666664));
        }
        else if (abs(satisfactionMeterTween_late - satisfactionMeterTween_main) > 0.01)
        {
            if (!meterLateFillSound)
            {
                playSoundHUDExperienceMoveTail();
                playSoundHUDExperienceFillHeadLoop();
                meterLateFillSound = 1;
            }
            
            if (satisfactionMeterTween_lateLooped < 1)
                satisfactionMeterTween_lateLooped += doDelta(clamp(((satisfactionMeterTween_main + 1) - satisfactionMeterTween_lateLooped) * 0.05, 0.003125, 0.022222222222222223));
            else
                satisfactionMeterTween_late += doDelta(clamp((satisfactionMeterTween_main - satisfactionMeterTween_late) * 0.05, 0.003125, 0.022222222222222223));
        }
        else
        {
            meterHeadFillSound = 0;
            meterLateFillSound = 0;
            playSoundHUDExperienceFillTail();
            satisfactionMeterTween_late = satisfactionMeterTween_main;
            satisfactionMeterTween_dewReceived = 0;
        }
    }
    
    var _meterColor;
    _meterColor[0] = make_color_rgb(36, 145, 249);
    _meterColor[1] = make_color_rgb(65, 231, 125);
    _meterColor[2] = make_color_rgb(225, 223, 1);
    _meterColor[3] = make_color_rgb(248, 45, 97);
    _meterColor[4] = make_color_rgb(36, 145, 249);
    _meterColor[5] = make_color_rgb(65, 231, 125);
    var _meterColorIndex = meterLevel % 4;
    _meterColorIndex += 1;
    var _a = abs(((_meterColorIndex + 4) - 1) % 4);
    var _lighterBarFillColor_prv = merge_color(_meterColor[_a], make_color_rgb(255, 255, 255), 0.8);
    var _barFlash = (global.time / 8) % 1;
    
    if (_barFlash)
        _lighterBarFillColor_prv = make_color_rgb(255, 255, 255);
    
    draw_clear(merge_color(_meterColor[_a], make_color_rgb(46, 50, 59), 0.25));
    draw_set_color(_meterColor[_meterColorIndex - 1]);
    var _meterDepthEdgeWidth = cr * 1;
    draw_roundrect_ext(_meterDepthEdgeWidth, cr * 2.5, surfaceWidth - _meterDepthEdgeWidth, surfaceHeight, 10 * cr, 10 * cr, 0);
    draw_set_color(make_color_rgb(46, 50, 59));
    draw_rectangle(0, 0, (surfaceWidth * satisfactionMeterTween_main) + (cr * 1), surfaceHeight, 0);
    draw_set_color(make_color_rgb(255, 255, 255));
    draw_rectangle(0, 0, surfaceWidth * satisfactionMeterTween_main, surfaceHeight, 0);
    var _mainMeterColor = _meterColor[_meterColorIndex];
    draw_set_color(_mainMeterColor);
    draw_rectangle(0, 0, (surfaceWidth * satisfactionMeterTween_main) - (cr * 1), surfaceHeight, 0);
    
    if (satisfactionMeterTween_dewReceived)
    {
        draw_set_color(merge_color(_mainMeterColor, make_color_rgb(255, 255, 255), 0.8));
        
        if (_barFlash)
            draw_set_color(make_color_rgb(255, 255, 255));
        
        draw_rectangle(surfaceWidth * satisfactionMeterTween_late, 0, surfaceWidth * satisfactionMeterTween_main, surfaceHeight, 0);
    }
    
    if (finalLevelOrder && meterLevel >= 20)
    {
        var _time = global.timeScaledTime * 20;
        var _rainbowScrollx = (sin(_time / 500) * 50) + (_time * 0.3);
        var _rainbowScrolly = _time * 0.15;
        draw_sprite_tiled_ext(rainbowBarSprite, 0, _rainbowScrollx, _rainbowScrolly, rainbowBarScalex / cr, rainbowBarScaley / cr, c_white, 1);
    }
    
    gpu_set_blendmode(bm_subtract);
    draw_surface_stretched(_croppingSurface, 0, 0, surfaceWidth, surfaceHeight);
    gpu_set_blendmode(bm_normal);
    surface_reset_target();
    texture_set_interpolation(false);
    draw_surface_stretched(_baseSurface, _stomachMeterPosx, _stomachMeterPosy, surfaceWidth / cr, surfaceHeight / cr);
    draw_surface_stretched(_baseSurface, _stomachMeterPosx, _stomachMeterPosy + 1, surfaceWidth / cr, surfaceHeight / cr);
    draw_surface_stretched(_meterSurface, _stomachMeterPosx, _stomachMeterPosy, surfaceWidth / cr, surfaceHeight / cr);
    draw_set_alpha(1);
    texture_set_interpolation(true);
    var _scorex = centerx;
    var _scorey = (_stomachMeterPosy + 4) - 1;
    var _scoreRecWidth = 128;
    var _scoreRecHeight = 16;
    satisfactionMeter_levelTextTween = 0;
    satisfactionMeter_levelTextAngle = approach(satisfactionMeter_levelTextAngle, 0, 1);
    
    if (satisfactionMeter_levelTextWobbleSequence)
    {
        if (satisfactionMeterTween_dewReceived <= 0)
        {
            satisfactionMeter_levelTextSize = deltaLerp(satisfactionMeter_levelTextSize, 1.2, 0.15);
            satisfactionMeter_levelTextWobbleSequence += doDelta(1);
            
            if (satisfactionMeter_levelTextWobbleSequence > 120)
                satisfactionMeter_levelTextWobbleSequence = 0;
        }
        else
        {
            satisfactionMeter_levelTextSize = deltaLerp(satisfactionMeter_levelTextSize, 1, 0.2);
        }
    }
    else
    {
        satisfactionMeter_levelTextSize = deltaLerp(satisfactionMeter_levelTextSize, 0.8, 0.1);
    }
    
    drawSetAlign(0, 2);
    var _gourmetLevelTextx = (global.windowLeft + 16) - 1;
    var _gourmetLevelTexty = _scorey - 2;
    var _gourmetLevelTextSize = satisfactionMeter_levelTextSize;
    var _gourmetLevelText = loc("main game UI level", string(meterLevel));
    _gourmetLevelTextx = global.windowCenterx;
    _gourmetLevelTexty = _stomachMeterPosy + (surfaceHeight / cr / 2);
    _gourmetLevelTextSize = satisfactionMeter_levelTextSize + 0.1;
    _gourmetLevelText = loc("main game UI level", string(meterLevel));
    _gourmetLevelText = string(meterLevel);
    
    if (global.finalStretchSequence >= UnknownEnum.Value_3)
    {
        _gourmetLevelText = "";
        var _remainingJuiceTextx, _remainingJuiceTexty, _remainingJuiceText, _remainingJuiceTextSize;
        
        if (global.finalStretchSequence >= UnknownEnum.Value_3)
        {
            var _remainNumString = string(25 - meterLevel);
            _remainingJuiceText = loc("main game UI last remain", _remainNumString);
            
            if (meterLevel >= 24)
                _remainingJuiceText = loc("main game UI last final one", _remainNumString);
            
            _remainingJuiceTextx = global.windowCenterx;
            drawSetAlign(1, 1);
            _remainingJuiceTextSize = 1;
            _remainingJuiceTexty = _gourmetLevelTexty;
        }
        
        drawTextOutlined(_remainingJuiceTextx, _remainingJuiceTexty, _remainingJuiceText, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), satisfactionMeter_levelTextAngle, _remainingJuiceTextSize);
    }
    
    drawSetAlign(0, 2);
    var _aboveMetery = _scorey - 2 - 2;
    var _aboveMeterTextSize = 0.5714285714285714;
    
    if (goalTextZoomTimer > 0)
    {
        goalTextZoomSize = deltaLerp(goalTextZoomSize, 1, 0.1);
        goalTextZoomTimer -= 1;
    }
    else
    {
        goalTextZoomSize = deltaLerp(goalTextZoomSize, 0, 0.1);
    }
    
    _aboveMeterTextSize = (1 + goalTextZoomSize) / 2.25;
    drawSetAlign(1, 1);
    
    if (global.finalStretchSequence < UnknownEnum.Value_3)
    {
        _gourmetLevelTexty += 0;
        var _levelTextScale = 0.275;
        scribble(loc("main game UI gourmet level")).starting_format(global.defaultFont, make_color_rgb(255, 255, 255)).blend(16777215, 1).line_height(10, 26).msdf_border(make_color_rgb(46, 50, 59), 4).transform(_levelTextScale, _levelTextScale, 0).align(1, 1).draw(_gourmetLevelTextx, _stomachMeterPosy + 0.5);
        _levelTextScale = _gourmetLevelTextSize * 0.8 * 0.75;
        scribble(_gourmetLevelText).starting_format(locGetNumFont(), make_color_rgb(255, 255, 255)).blend(16777215, 1).line_height(10, 22).msdf_border(make_color_rgb(46, 50, 59), 3).transform(_levelTextScale, _levelTextScale, 0).align(1, 1).draw(_gourmetLevelTextx, _gourmetLevelTexty + 1);
    }
    
    _aboveMeterTextSize = 0.6285714285714286;
    drawSetAlign(2, 2);
    drawTextOutlined(global.windowRight - 16 - 8, _aboveMetery, locGetNumFont(true) + string(global.mainGameFruitProgress_total * 1), make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _aboveMeterTextSize);
    var _satisIconSize = 7;
    drawSpriteSetSize(sSatisfactionIcon, 0, global.windowRight - 16 - 2, (_aboveMetery - 5.5) + 1 + 0.5, _satisIconSize, _satisIconSize);
    
    if (_levelUpTextCreate)
    {
        playSoundHUDLevelGain();
        var _levelUpTextString = loc("main game UI level up");
        
        if (instance_exists(levelUpTextInstance))
        {
            with (levelUpTextInstance)
                instance_destroy();
            
            multiLevelSkip += 1;
            _levelUpTextString += (locGetNumFont(true) + "[cycle,32,43] x" + string(multiLevelSkip));
        }
        else
        {
            multiLevelSkip = 1;
        }
        
        levelUpTextInstance = instance_create_depth(oPlayer.x, oPlayer.y, depth, effectText);
        
        with (levelUpTextInstance)
        {
            drawx = _gourmetLevelTextx;
            drawy = _gourmetLevelTexty;
            text = _levelUpTextString;
            drawGui = true;
            killTimer = 180;
            ysp = -6;
            yfric = 0.3;
            halign = 1;
            valign = 2;
            size = 0.9;
        }
        
        _levelUpTextCreate = 0;
    }
    
    drawSetAlign(2, 2);
    
    if (scoreIncrementalForShow > 0)
    {
        scoreIncrementalForShow_downTimer += doDelta(1);
        
        if (scoreIncrementalForShow_downTimer > 150)
            scoreIncrementalForShow = approach(scoreIncrementalForShow, 0, scoreIncrementalForShow_countdownAmount);
        
        scoreIncrementalForShow_yoffset = deltaLerp(scoreIncrementalForShow_yoffset, 0, 0.15);
        var _equationSize = _aboveMeterTextSize * 0.9;
        var _incrementalScore_y = ((_aboveMetery - 8) + (scoreIncrementalForShow_yoffset * 4)) - 8;
        var _bonusExtraText = "(" + string(sqrt(scoreIncrementalForShow_multiplier)) + ")";
        
        if (global.gameMode != UnknownEnum.Value_0)
            _bonusExtraText = "";
        
        if (scoreIncrementalForShow_multiplier >= 1)
        {
            drawTextOutlined(global.windowRight - 16 - 8, _incrementalScore_y, loc("main game UI juice bonus") + locGetNumFont(true) + _bonusExtraText + ": " + string(scoreIncrementalForShow_multiplier), make_color_rgb(245, 246, 247), make_color_rgb(46, 50, 59), 0, _equationSize);
            _incrementalScore_y -= 7;
        }
        
        drawTextOutlined(global.windowRight - 16 - 8, _incrementalScore_y, locGetNumFont(true) + string(scoreIncrementalForShow_baseScore), make_color_rgb(245, 246, 247), make_color_rgb(46, 50, 59), 0, _equationSize);
        _satisIconSize = 16;
        drawSpriteSetSize(sFruitApple, 2, global.windowRight - 16 - 2, _incrementalScore_y - 5.5, _satisIconSize, _satisIconSize);
        drawTextOutlined(global.windowRight - 16 - 8, _aboveMetery - 8, locGetNumFont(true) + "+" + string(scoreIncrementalForShow), make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _aboveMeterTextSize + (scoreIncrementalForShow_yoffset * 0.5));
    }
    else if (scoreIncrementalForShow_downTimer > 0)
    {
        scoreIncrementalForShow_downTimer = clamp(scoreIncrementalForShow_downTimer, 0, 90);
        scoreIncrementalForShow_downTimer -= doDelta(1);
        
        if (scoreIncrementalForShow_downTimer < 10)
            scoreIncrementalForShow_yoffset = deltaLerp(scoreIncrementalForShow_yoffset, -1, 0.2);
        
        drawTextOutlined(global.windowRight - 16 - 8, _aboveMetery - 8, locGetNumFont(true) + "+" + string(scoreIncrementalForShow), make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _aboveMeterTextSize);
    }
}
