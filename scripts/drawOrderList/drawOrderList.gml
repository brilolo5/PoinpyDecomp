function drawOrderList(arg0, arg1, arg2, arg3, arg4)
{
    var _drawx = arg0;
    var _drawy = arg1;
    var _drawList = arg2;
    var _circleTimer = arg3;
    var _circleTimerMax = arg4;
    _circleTimer = clamp(_circleTimer, 0, _circleTimerMax);
    var _angerTimerRatio = _circleTimer / _circleTimerMax;
    var _hurryUpStartRatio = 0.5;
    var cr = global.surfaceCompressionRate;
    aboutToBlow = 0;
    
    if (_angerTimerRatio <= 0 && !orderComplete)
    {
        aboutToBlow = 1;
        var _hurryRatio = _angerTimerRatio / _hurryUpStartRatio;
    }
    
    cloudBgColor = make_color_rgb(255, 255, 255);
    cloudOutlineColor = make_color_rgb(46, 50, 59);
    cloudCountdownColor = make_color_rgb(46, 50, 59);
    cloudAlpha = 0.85;
    cloudOutlineWidth = 1;
    var _breatheTempo = 0.02;
    var _breatheScale = 0.02;
    thoughtCloudBreatheTracker += _breatheTempo;
    cloudBreatheScale = 1 + (sin(thoughtCloudBreatheTracker) * _breatheScale);
    thoughtCloudDangerShakeAmount = 0;
    
    if (instance_exists(oBeastMainGame))
        beastGameState = oBeastMainGame.beastGameState;
    
    switch (recipeListState)
    {
        case "normal":
            cloudScale = 1;
            cloudBgColor = make_color_rgb(255, 255, 255);
            cloudOutlineColor = make_color_rgb(46, 50, 59);
            cloudCountdownColor = make_color_rgb(46, 50, 59);
            
            if (_angerTimerRatio <= 0.25)
                recipeStateChange("warning");
            
            break;
        
        case "warning":
            if (recipeStateInitialize())
            {
                warningFlash = 0;
                warningFlashCount = 0;
                warningFlashTimeCounter = 0;
                warningFlashAlarmTimerCounter = 0;
                warningFlashSound = -1;
                warningFlashSoundCount = 0;
                playSfxUI(hud_timer_firstWarning, false, true);
            }
            
            warningFlashTimeCounter += doDeltaWithAccessibility(1);
            warningFlashAlarmTimerCounter += doDeltaWithAccessibility(1);
            var _warningFlashTimeCounterRounded = floor(warningFlashTimeCounter);
            cloudScale = lerp(cloudScale, 1.2, 0.03);
            cloudOutlineWidth = cloudScale * 3;
            cloudBgColor = make_color_rgb(255, 255, 255);
            cloudOutlineColor = make_color_rgb(46, 50, 59);
            cloudCountdownColor = make_color_rgb(248, 45, 97);
            thoughtCloudDangerShake = 1;
            thoughtCloudDangerShakeAmount = 0.25;
            beastShake(1, 0.25);
            warningFlashSound -= doDeltaWithAccessibility(1);
            
            if (warningFlashCount < 9 && (warningFlashTimeCounter / 2) > 2)
            {
                warningFlashTimeCounter = 0;
                warningFlash = !warningFlash;
                warningFlashCount += 1;
                
                if (warningFlashSound <= 0)
                {
                    warningFlashSound = 60;
                    var _flashSound = -1;
                    
                    switch (warningFlashSoundCount)
                    {
                        case 0:
                            _flashSound = -1;
                            break;
                        
                        case 1:
                            _flashSound = hud_timer_warningFlash_01;
                            break;
                        
                        case 2:
                            _flashSound = hud_timer_warningFlash_02;
                            break;
                        
                        case 3:
                            _flashSound = hud_timer_warningFlash_03;
                            break;
                        
                        case 4:
                            _flashSound = hud_timer_warningFlash_04;
                            break;
                        
                        case 5:
                            _flashSound = hud_timer_warningFlash_05;
                            break;
                        
                        default:
                            break;
                    }
                    
                    if (_flashSound != -1)
                        playSfxUI(_flashSound, false, true);
                    
                    warningFlashSoundCount += 1;
                    
                    if (angerTimerMax != angerTimerMax_default)
                        warningFlashSoundCount += 1;
                }
            }
            
            if ((warningFlashAlarmTimerCounter / 8) > 10)
            {
                warningFlashAlarmTimerCounter = 0;
                warningFlashCount = 5;
            }
            
            if (warningFlash)
                cloudCountdownColor = make_color_rgb(46, 50, 59);
            
            if (_angerTimerRatio <= 0)
                recipeStateChange("critical");
            
            if (_angerTimerRatio > 0.25)
                recipeStateChange("normal");
            
            break;
        
        case "critical":
            if (recipeStateInitialize())
            {
                warningFlash = 10;
                cloudScale = 1.75;
                thoughtCloudDangerShake = 10;
                warningOutlineWidth = 5;
                warningFlashTimeCounter = 0;
                beastShake(10, 2);
                criticalWarningSound = -1;
                criticalWarningSoundCount = 0;
                criticalWarningSoundCountMax = 4;
                criticalWarningSoundVolumeDownGoal = 0.9;
                playSfxUI(hud_timer_burstReady, false, true);
            }
            
            warningFlashTimeCounter += 1;
            cloudBreatheScale = 1;
            cloudScale = lerp(cloudScale, 1.1, 0.2);
            cloudBgColor = make_color_rgb(255, 255, 255);
            cloudOutlineColor = make_color_rgb(248, 45, 97);
            cloudCountdownColor = make_color_rgb(46, 50, 59);
            cloudAlpha = 0.95;
            thoughtCloudDangerShakeAmount = 1.5 * cloudScale;
            cloudOutlineWidth = warningOutlineWidth;
            warningOutlineWidth = lerp(warningOutlineWidth, 2, 0.05);
            cloudBreatheScale = 1 + (sin(thoughtCloudBreatheTracker) * _breatheScale);
            
            if (((warningFlashTimeCounter / 35) % 2) == 0)
            {
                thoughtCloudDangerShake = 6;
                beastShake(6, 2);
                criticalWarningSound = playSfxUI(hud_timer_burstPulse, false, true);
                var _warningVolumeRatio = 1 - ((criticalWarningSoundCountMax - criticalWarningSoundCount) / criticalWarningSoundCountMax);
                var _warningVolume = lerp(1, criticalWarningSoundVolumeDownGoal, _warningVolumeRatio);
                audioSetVolume(criticalWarningSound, _warningVolume);
                show_debug_message(_warningVolume);
                criticalWarningSoundCount = approach(criticalWarningSoundCount, criticalWarningSoundCountMax, 1);
            }
            
            if (warningFlash)
            {
                warningFlash -= 1;
                cloudOutlineColor = make_color_rgb(255, 255, 255);
                thoughtCloudDangerShake = 6;
                thoughtCloudDangerShakeAmount = 6;
            }
            
            if (thoughtCloudDangerShake > 0)
            {
                cloudOutlineColor = make_color_rgb(255, 255, 255);
                warningOutlineWidth = 5;
            }
            
            if (_angerTimerRatio > 0)
                recipeStateChange("normal");
            
            break;
        
        case "ready":
            if (recipeStateInitialize())
            {
            }
            
            cloudBgColor = make_color_rgb(255, 255, 255);
            cloudOutlineColor = make_color_rgb(46, 50, 59);
            cloudCountdownColor = make_color_rgb(65, 231, 125);
            break;
        
        case "success":
            if (recipeStateInitialize())
            {
            }
            
            cloudBgColor = make_color_rgb(225, 223, 1);
            cloudOutlineColor = make_color_rgb(46, 50, 59);
            cloudCountdownColor = make_color_rgb(225, 223, 1);
            break;
        
        case "failure":
            if (recipeStateInitialize())
                playSfxUI(hud_timer_end, false, true);
            
            cloudBgColor = make_color_rgb(248, 45, 97);
            cloudOutlineColor = make_color_rgb(46, 50, 59);
            cloudCountdownColor = make_color_rgb(248, 45, 97);
            cloudAlpha = 0.95;
            cloudScale = 1.1;
            break;
    }
    
    if (1 && recipeRiseSequence != 1)
    {
        var _pieSurfDrawx = _drawx;
        var _pieSurfDrawy = _drawy;
        var _pieSize = 68;
        var _pieCloudSurfW = _pieSize * cr;
        var _pieCloudSurfH = _pieSize * cr;
        var _surfCenterx = _pieCloudSurfW / 2;
        var _surfMiddley = _pieCloudSurfH / 2;
        
        if (!surface_exists(thoughtCloudSurface_pie))
            thoughtCloudSurface_pie = surface_create_track(_pieCloudSurfW, _pieCloudSurfH);
        
        if (!surface_exists(thoughtCloudSurface_bg))
            thoughtCloudSurface_bg = surface_create_track(_pieCloudSurfW, _pieCloudSurfH);
        
        if (!surface_exists(thoughtCloudSurface_crop))
            thoughtCloudSurface_crop = surface_create_track(_pieCloudSurfW, _pieCloudSurfH);
        
        if (global.surfaceCompressionRateUpdate)
        {
            surface_resize_track(thoughtCloudSurface_pie, _pieCloudSurfW, _pieCloudSurfH);
            surface_resize_track(thoughtCloudSurface_bg, _pieCloudSurfW, _pieCloudSurfH);
            surface_resize_track(thoughtCloudSurface_crop, _pieCloudSurfW, _pieCloudSurfH);
        }
        
        surface_set_target(thoughtCloudSurface_crop);
        draw_clear(c_black);
        gpu_set_blendmode(bm_subtract);
        var _sequenceValue = 1 - recipeRiseSequence;
        var _cloudDrawSize = (60 / sprite_get_width(sUItestThoughtCloud)) * cr;
        var _cloudScalex = _cloudDrawSize * _sequenceValue * cloudBreatheScale;
        var _cloudScaley = _cloudDrawSize * _sequenceValue * cloudBreatheScale;
        draw_sprite_ext(sUItestThoughtCloud, 0, _surfCenterx, _surfMiddley, _cloudScalex, _cloudScaley, 0, c_white, 1);
        gpu_set_blendmode(bm_normal);
        surface_reset_target();
        surface_set_target(thoughtCloudSurface_bg);
        var _backColor = cloudCountdownColor;
        var _meterColor = cloudBgColor;
        draw_clear(_backColor);
        drawPie(_surfCenterx, _surfMiddley, _circleTimer, _circleTimerMax, _meterColor, _pieCloudSurfW, 1, 90);
        surface_reset_target();
        surface_set_target(thoughtCloudSurface_pie);
        draw_clear_alpha(c_white, 0);
        var _alpha = cloudAlpha;
        draw_set_alpha(_alpha);
        draw_surface(thoughtCloudSurface_bg, 0, 0);
        draw_set_alpha(1);
        gpu_set_blendmode(bm_subtract);
        draw_surface_ext(thoughtCloudSurface_crop, 0, 0, 1, 1, 0, c_white, 1);
        gpu_set_blendmode(bm_normal);
        surface_reset_target();
        cr *= 1.1;
        var _surfScale = cloudScale * (1 / cr);
        _pieSurfDrawx -= ((_pieCloudSurfW / 2) * _surfScale);
        _pieSurfDrawy -= ((_pieCloudSurfH / 2) * _surfScale);
        
        if (thoughtCloudDangerShake)
            thoughtCloudDangerShake -= 1;
        else
            thoughtCloudDangerShakeAmount = 0;
        
        var shakeOffsetx = random_range(-thoughtCloudDangerShakeAmount, thoughtCloudDangerShakeAmount);
        var shakeOffsety = random_range(-thoughtCloudDangerShakeAmount, thoughtCloudDangerShakeAmount);
        _pieSurfDrawx += shakeOffsetx;
        _pieSurfDrawy += shakeOffsety;
        var _outlineWidth = cloudOutlineWidth * cr;
        draw_surface_ext(thoughtCloudSurface_pie, _pieSurfDrawx, _pieSurfDrawy, _surfScale, _surfScale, 0, c_white, 1);
        draw_sprite_ext(sUIRecipeCloudOutline, cloudOutlineWidth, _drawx + shakeOffsetx, _drawy + shakeOffsety, (_cloudScalex / cr) * cloudScale, (_cloudScaley / cr) * cloudScale, 0, cloudOutlineColor, 1);
        drawRecipeList(_drawList, _drawx, _drawy, orderComplete, 0.8 * (0.5 + (0.5 * cloudScale)));
    }
    
    recipeRiseSequence = lerp(recipeRiseSequence, 0, 0.3);
}

function drawRecipeList(arg0, arg1, arg2, arg3, arg4)
{
    var comboElementRecordDrawSpaceInbetween;
    var _blendColor = 16777215;
    var _alphaValue = 1;
    var _alphaReverse = 0;
    var _angleShakeValue = 0;
    var _zoomValue = 1;
    
    if (recipeMismatchSequence)
    {
        var _alphaAnimCurve = animcurve_get(acNoJumpsLeftAlpha);
        var _alphaAnimChannel = animcurve_get_channel(_alphaAnimCurve, "alpha");
        _alphaValue = animcurve_channel_evaluate(_alphaAnimChannel, recipeMismatchAnimcurvePos);
        _blendColor = merge_color(_blendColor, make_color_rgb(254, 66, 113), _alphaValue / 255 / 2);
        _alphaReverse = _alphaValue / 255;
        _alphaValue = 1 - (_alphaValue / 255);
        var _shakeRate = 0.2;
        var _xposAnimCurve = animcurve_get(acNoJumpsPos);
        var _xposAnimChannel = animcurve_get_channel(_xposAnimCurve, "x");
        _angleShakeValue = animcurve_channel_evaluate(_xposAnimChannel, recipeMismatchAnimcurvePos) * _shakeRate;
        _zoomValue += (_alphaReverse * 0.4);
        _angleShakeValue = _angleShakeValue * 20;
    }
    
    var _bannedListSize = ds_list_size(global.bannedFruitList);
    var _bannedPresent = _bannedListSize > 0;
    var _totalTypes = ds_grid_height(arg0);
    var _cr = arg4;
    var _fruitScale = 0.1 * _cr;
    var comboElementMultipleSpaceInbetween;
    
    if (_totalTypes > 0)
    {
        var t = _totalTypes - 1;
        var _totalFruitsGotInInclude = 0;
        comboElementMultipleSpaceInbetween = 12 * _cr;
        
        if ((_totalTypes + _bannedPresent) >= 4)
        {
            var _dif = (_totalTypes + _bannedPresent) - 3;
            comboElementMultipleSpaceInbetween -= (_dif * 2 * _cr);
        }
        
        repeat (_totalTypes)
        {
            var _fruitsInType = arg0[# UnknownEnum.Value_1, t];
            var comboElementSprite = getFruitSprite(arg0[# UnknownEnum.Value_0, t]);
            comboElementRecordDrawSpaceInbetween = 12 * _cr;
            
            if (_fruitsInType >= 5)
            {
                var _dif = _fruitsInType - 4;
                comboElementRecordDrawSpaceInbetween -= (_dif * 2 * _cr);
            }
            
            if (_fruitsInType > 0)
            {
                var _orderSpecification = arg0[# UnknownEnum.Value_4, t];
                
                switch (_orderSpecification)
                {
                    case UnknownEnum.Value_0:
                        var i = 0;
                        
                        repeat (_fruitsInType)
                        {
                            var comboElementRecordDrawPosx = (arg1 - ((_fruitsInType - 1) * (comboElementRecordDrawSpaceInbetween / 2))) + (i * comboElementRecordDrawSpaceInbetween);
                            var comboElementRecordDrawPosy = (arg2 + (((_totalTypes - 1 - _bannedPresent) * comboElementMultipleSpaceInbetween) / 2)) - (t * comboElementMultipleSpaceInbetween);
                            
                            if (!recipeMismatchSequence)
                                draw_sprite_ext(comboElementSprite, 0, comboElementRecordDrawPosx, comboElementRecordDrawPosy, _fruitScale, _fruitScale, 0, make_color_rgb(255, 255, 255), 1);
                            
                            if (i < arg0[# UnknownEnum.Value_3, t] && !(orderComplete && !orderFailed))
                            {
                                draw_sprite_ext(comboElementSprite, 1, comboElementRecordDrawPosx, comboElementRecordDrawPosy, _fruitScale, _fruitScale, 0, make_color_rgb(255, 255, 255), 1);
                                _totalFruitsGotInInclude += 1;
                            }
                            else if (recipeMismatchSequence)
                            {
                                draw_sprite_ext(comboElementSprite, 0, comboElementRecordDrawPosx, comboElementRecordDrawPosy, _fruitScale * _zoomValue, _fruitScale * _zoomValue, _angleShakeValue, _blendColor, 1);
                            }
                            
                            i += 1;
                        }
                        
                        break;
                    
                    case UnknownEnum.Value_4:
                        var comboElementRecordDrawPosx = arg1 - (8 * _cr);
                        var comboElementRecordDrawPosy = ((arg2 + (((_totalTypes - 1 - _bannedPresent) * comboElementMultipleSpaceInbetween) / 2)) - (t * comboElementMultipleSpaceInbetween)) + (sign(_totalTypes) * 2);
                        var _fruitUISpritePosx = comboElementRecordDrawPosx + (2 * _cr);
                        var _fruitUISpritePosy = comboElementRecordDrawPosy;
                        var _fruitUITextMainPosx = _fruitUISpritePosx + (14 * _cr);
                        var _fruitUITextMainPosy = _fruitUISpritePosy;
                        var _fruitShrinkRate = _fruitScale;
                        var _fruitHorizontalSpace = 3 * _cr;
                        var _fruitVerticalSpace = 0;
                        var _comboHeight = ds_grid_height(global.comboGrid);
                        var _restFromList = ds_grid_get_sum(global.comboGrid, UnknownEnum.Value_1, 0, UnknownEnum.Value_1, _comboHeight - 1);
                        var _bunchTotalAmount = _fruitsInType - (_restFromList - _totalFruitsGotInInclude);
                        _bunchTotalAmount = clamp(_bunchTotalAmount, 0, _fruitsInType);
                        var _textColor = make_color_rgb(255, 255, 255);
                        var _textAngle = 0;
                        var _textScale = 1;
                        var _textOutlineColor = make_color_rgb(46, 50, 59);
                        
                        if (!recipeMismatchSequence)
                        {
                            bunchHeldAmountRecord = _bunchTotalAmount;
                        }
                        else if (bunchHeldAmountRecord != 0)
                        {
                            _textColor = _blendColor;
                            _textAngle = _angleShakeValue;
                            _textScale *= _zoomValue;
                        }
                        
                        if (orderComplete && !orderFailed)
                            bunchHeldAmountRecord = _fruitsInType;
                        
                        if (bunchHeldAmountRecord <= 0)
                            _textOutlineColor = make_color_rgb(122, 131, 146);
                        
                        var _bunchFruitSpriteIndex = (_bunchTotalAmount <= 0) ? 1 : 0;
                        draw_sprite_ext(sFruitRed, _bunchFruitSpriteIndex, _fruitUISpritePosx, _fruitUISpritePosy - _fruitVerticalSpace, _fruitShrinkRate, _fruitShrinkRate, 0, c_white, 1);
                        draw_sprite_ext(sFruitBlue, _bunchFruitSpriteIndex, _fruitUISpritePosx - _fruitHorizontalSpace, _fruitUISpritePosy + _fruitVerticalSpace, _fruitShrinkRate, _fruitShrinkRate, 0, c_white, 1);
                        draw_sprite_ext(sFruitYellow, _bunchFruitSpriteIndex, _fruitUISpritePosx - (_fruitHorizontalSpace * 2), _fruitUISpritePosy + _fruitVerticalSpace, _fruitShrinkRate, _fruitShrinkRate, 0, c_white, 1);
                        var _text = locGetNumFont(true) + string(bunchHeldAmountRecord);
                        var _textSize = _textScale * _cr;
                        drawSetAlign(1, 1);
                        drawTextOutlined(_fruitUITextMainPosx, _fruitUITextMainPosy, _text, _textColor, _textOutlineColor, _textAngle, _textSize);
                        break;
                }
            }
            
            t -= 1;
        }
    }
    
    comboElementRecordDrawSpaceInbetween = 12 * _cr;
    _bannedListSize = ds_list_size(global.bannedFruitList);
    
    if (_bannedListSize > 0)
    {
        for (var i = 0; i < _bannedListSize; i += 1)
        {
            var _bannedFruit = global.bannedFruitList[| i];
            var _bannedFruitSprite = getFruitSprite(_bannedFruit);
            var _bannedDrawy = (arg2 - ((_totalTypes * comboElementMultipleSpaceInbetween) / 2)) + (_totalTypes * comboElementMultipleSpaceInbetween) + (4 * _cr);
            var _bannedDrawx = (arg1 - ((_bannedListSize - 1) * (comboElementRecordDrawSpaceInbetween / 2))) + (i * comboElementRecordDrawSpaceInbetween);
            
            if (!global.orderChecklistFilled)
            {
                draw_sprite_ext(_bannedFruitSprite, 0, _bannedDrawx, _bannedDrawy, _fruitScale, _fruitScale, 0, make_color_rgb(255, 255, 255), 1);
                draw_sprite_ext(sOrderExcludeSign, 0, _bannedDrawx, _bannedDrawy, 0.1 * _cr, 0.1 * _cr, 0, make_color_rgb(255, 255, 255), 1);
            }
            else
            {
                draw_sprite_ext(_bannedFruitSprite, 1, _bannedDrawx, _bannedDrawy, _fruitScale, _fruitScale, 0, make_color_rgb(255, 255, 255), 1);
                draw_sprite_ext(sOrderExcludeSign, 1, _bannedDrawx, _bannedDrawy, 0.1 * _cr, 0.1 * _cr, 0, make_color_rgb(255, 255, 255), 1);
            }
        }
    }
}

function renewRecipe()
{
    if (reduceTimer)
    {
        angerTimerMax = angerTimerMax_default / 2.5;
        playSfxUI(hud_timer_appear, false, true);
    }
    else
    {
        angerTimerMax = angerTimerMax_default;
    }
    
    ds_grid_set_region(recipeDataGrid, UnknownEnum.Value_3, 0, UnknownEnum.Value_3, ds_grid_height(recipeDataGrid) - 1, 0);
    angerTimer = angerTimerMax + 60;
    recipeRiseSequence = 1;
    var listId = recipeDataGrid;
    
    if (!(reduceTimer && abilityCheck(UnknownEnum.Value_0)))
        orderRandomize(listId);
    
    ds_grid_sort(listId, UnknownEnum.Value_1, -1);
    sortRecipe();
    orderChecklistUpdate();
    recipeStateChange("normal");
    playSoundRecipeNew();
    global.bannedFruitActive = 0;
    banPreActive = 1;
    bonusCountTween = 0;
    reduceTimer = 0;
}
