frameLengthMin = 60;
frameLengthMax = 120;
frameHorizontalSpaceFromText = 26;
fontHeightScaleFromFrameHeight = 0.5;
rankFrameLengthMin = 450;
rankFrameLengthMax = 770;
rankFrameHeight = 75;
rankFrameSpacing = 70;
rewardFrameLengthMin = 200;
rewardFrameLengthMax = 500;
rewardFrameHeight = 75;
rewardFrameSpacing = 70;
fontHeight = 0.1 * fontHeightScaleFromFrameHeight * sprite_get_height(sResultsSignA_3slice);
var _puzzleUnlockedIndex = puzzleDataUnlockSetsForUnlockedAreas();

if (global.puzzleAreaUnlockedUpTo != _puzzleUnlockedIndex)
{
    global.puzzleAreaUnlockedUpTo = _puzzleUnlockedIndex;
    global.puzzleAreaUnlockNotification = 1;
}

TexanFetch("ResultsScreen");
TexanCommit();
overlayTextureSurface = -1;

with (oDiscoveryLine)
{
    if (areaIndex != -1)
    {
        var _newAreaPos = ds_list_find_index(global.areaUnlockedList, areaIndex);
        
        if (_newAreaPos != -1)
        {
            show_debug_message("unlocked area deleted: " + global.areaNames[areaIndex]);
            ds_list_delete(global.areaUnlockedList, _newAreaPos);
            ds_list_destroy(global.areaOrderList);
        }
        
        if (areaIndex == UnknownEnum.Value_2)
        {
            if (ds_list_find_index(global.areaUnlockedList, UnknownEnum.Value_1) == -1)
                ds_list_add(global.areaUnlockedList, UnknownEnum.Value_1);
        }
    }
    
    instance_destroy();
}

endingResult = global.difficultyLevel >= 25;
var _endingResult = endingResult;

if (endingResult)
{
    var _totalExpNeededForMaxRank = 0;
    
    for (var _i = 0; _i < 20; _i += 1)
        _totalExpNeededForMaxRank += global.juicerRankUpThreshold[_i];
    
    _totalExpNeededForMaxRank -= (global.juicerRankProgress + global.mainGameFruitProgress_total);
    _totalExpNeededForMaxRank = clamp(_totalExpNeededForMaxRank, 0, 999999);
    global.mainGameFruitProgress_total += _totalExpNeededForMaxRank;
    ds_list_clear(global.areaUnlockedList);
    ds_list_add(global.areaUnlockedList, UnknownEnum.Value_2);
    ds_list_add(global.areaUnlockedList, UnknownEnum.Value_3);
    ds_list_add(global.areaUnlockedList, UnknownEnum.Value_4);
    ds_list_add(global.areaUnlockedList, UnknownEnum.Value_5);
    
    if (ds_exists(global.areaOrderList, ds_type_list))
        ds_list_clear(global.areaOrderList);
    
    ds_list_copy(global.areaOrderList, global.areaUnlockedList);
    global.currentLevelChunkSet = global.areaOrderList[| 0];
}

audioFadeOut(global.areaMusic, 0.009523809523809525);
var _oldRankProgress = global.juicerRankProgress;
var _oldRank = global.juicerRank;
global.moneyJar += checkMoneyGotFromRankingUp();
global.juicerRankProgress += global.mainGameFruitProgress_total;
juicerRankUpdate();
global.tutorialOver = max(1, global.tutorialOver);
saveGame();
var _initialDelay = 58;
var _padlockDelay = 65;
var _restartDelay = 25;
var _ignoreClicksDelay = 15;
var _timePerRank = 70;
var _juiceAccel = 0.02;
var _juiceDecel = 0.004;

with (uiCreate("results root"))
{
    uiTemplateRectangle(make_color_rgb(46, 50, 59), 0);
    inTweenTime = 0;
    darkenAlpha = 0;
    audioVarRankFill = 0;
    eventAddFunction(UnknownEnum.Value_0, function()
    {
        setLTRBToWindow();
    });
    eventAddFunction(UnknownEnum.Value_1, function()
    {
        if (inTweenTime < 1)
        {
            inTweenTime = min(1, inTweenTime + doDelta(1/120));
            
            if (inTweenTime >= 1)
            {
                playSoundGameOverAppear();
                uiGet("results text").setVisible(true);
            }
        }
        
        darkenAlpha = min(1, darkenAlpha + doDelta(0.016666666666666666));
        visAlpha = 0.7 * darkenAlpha;
    });
    updateShape();
    
    with (newChild("results body"))
    {
        setVisible(false);
        setX(getParent().getShapeWidth() / 2);
        setY((getParent().getShapeHeight() / 2) - 10);
        setWidth(150);
        setHeight(getRawWidth());
        setChildrenActive(false);
        startJuice = _oldRankProgress;
        currentJuice = startJuice;
        currentRank = _oldRank;
        pointsStart = global.mainGameFruitProgress_total;
        pointsDisplay = pointsStart;
        decrementSize = 0;
        decrementAccel = _juiceAccel;
        decrementDecel = _juiceDecel;
        goFaster = false;
        lockImage = 0;
        lockTime = _padlockDelay;
        delayTime = _initialDelay;
        drawScoreTime = 11;
        drawScore = false;
        inTweenTime = 0;
        padlockDelayTime = _padlockDelay;
        restartDelayTime = _restartDelay;
        timePerRank = _timePerRank;
        meterStart = 0;
        audioVarRankFill = 0;
        matrix = matrix_build(0, 0, 0, 0, 0, 0, 0, 0, 0);
        eventAddFunction(UnknownEnum.Value_5, function()
        {
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            goFaster = true;
        });
        eventAddFunction(UnknownEnum.Value_1, function()
        {
            if (getVisible())
            {
                if (mouse_check_button_pressed(mb_left))
                    goFaster = true;
                
                if (inTweenTime < 1)
                {
                    inTweenTime = min(inTweenTime + doDelta(0.04), 1);
                    
                    if (inTweenTime == 1)
                        setChildrenActive(true);
                }
                
                if (getChildrenActive())
                {
                    if (drawScoreTime > 0)
                    {
                        drawScoreTime -= doDelta(1);
                        
                        if (drawScoreTime <= 0)
                            drawScore = true;
                    }
                    
                    if (delayTime > 0)
                    {
                        delayTime -= doDelta(1);
                    }
                    else if (pointsDisplay > 0)
                    {
                        if (!meterStart)
                        {
                            meterStart = 1;
                            playSoundGameOverRankFillHeadLoop();
                        }
                        
                        var _decrementTarget = ((goFaster ? 12 : 1) * global.juicerRankUpThreshold[currentRank]) / timePerRank;
                        
                        if (((_decrementTarget * sqr(decrementSize)) / decrementDecel) > pointsDisplay)
                            decrementSize = max(0.01, decrementSize - decrementDecel);
                        else
                            decrementSize = min(1, decrementSize + decrementAccel);
                        
                        var _decrement = _decrementTarget * decrementSize;
                        _decrement = doDelta(min(pointsDisplay, _decrement));
                        pointsDisplay = max(0, pointsDisplay - _decrement);
                        currentJuice += _decrement;
                        
                        if (currentRank < global.juicerRankMax)
                        {
                            if (currentJuice >= juicerRankTotal(currentRank + 1))
                            {
                                playSoundGameOverRankFillTail();
                                playSoundGameOverRankUnlock();
                                lockImage = 1;
                                lockTime = (goFaster ? 0.5 : 1) * padlockDelayTime;
                                setChildrenActive(false);
                                meterStart = 0;
                            }
                        }
                    }
                }
                
                if (lockImage == 1 && lockTime > 0)
                {
                    lockTime -= doDelta(1);
                    
                    if (lockTime <= 0)
                    {
                        with (uiGet("results reward"))
                        {
                            playSoundReward();
                            setVisible(true);
                            setActive(true);
                            setChildrenVisible(true);
                            setChildrenActive(true);
                            inTweenTime = 0;
                            delayTime = ignoreClicksDelayTime;
                        }
                        
                        uiFocusForce("results reward");
                        var _reward = global.juicerRankReward[currentRank];
                        
                        if (_reward == UnknownEnum.Value_1)
                            global.notif_equipment = 1;
                        
                        if (getRewardMoneyAmount(_reward) != undefined)
                        {
                            var _rewardAmount = getRewardMoneyAmount(_reward);
                            shownMoneyAmountUpdate(_rewardAmount);
                            
                            with (oControl)
                            {
                                moneyAmountCountUpDelay = 60;
                                walletUIappearTime = 240;
                                walletWobble = 1;
                                walletChange(_rewardAmount);
                            }
                        }
                    }
                }
                
                if (pointsDisplay <= 0 && lockImage == 0)
                {
                    if (audioVarRankFill == 0)
                    {
                        playSoundGameOverRankFillTail();
                        audioVarRankFill = 1;
                    }
                    
                    setActive(false);
                    
                    with (uiGet("results juice button"))
                    {
                        setActive(false);
                        setVisible(false);
                    }
                    
                    with (uiGet("results lobby button"))
                    {
                        setActive(true);
                        setVisible(true);
                    }
                }
                
                var _spriteWidth = sprite_get_width(sResultsBody) * 2;
                var _spriteHeight = sprite_get_height(sResultsBody) * 2;
                var _targetScale = getShapeWidth() / _spriteWidth;
                var _scale = animcurve_tween(_targetScale * 0.5, _targetScale, curveBackInv, inTweenTime);
                matrix = matrix_build(-_spriteWidth / 2, -_spriteHeight / 2, 0, 0, 0, 0, 1, 1, 1);
                matrix = matrix_multiply(matrix, matrix_build(0, 0, 0, 0, 0, 0, _scale, _scale, 1));
                matrix = matrix_multiply(matrix, matrix_build(getShapeX(), getShapeY(), 0, 0, 0, 0, 1, 1, 1));
            }
        });
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            var _overlayTextureSurface = rootInstance.overlayTextureSurface;
            var _width = sprite_get_width(sResultsBody) * 2;
            var _height = sprite_get_height(sResultsBody) * 2;
            
            if (surface_exists(_overlayTextureSurface) && (surface_get_width(_overlayTextureSurface) != _width || surface_get_height(_overlayTextureSurface) != _height))
                surface_free(_overlayTextureSurface);
            
            if (!surface_exists(_overlayTextureSurface))
            {
                _overlayTextureSurface = surface_create_track(_width, _height);
                rootInstance.overlayTextureSurface = _overlayTextureSurface;
            }
            
            var _juiceRankMin = juicerRankTotal(currentRank);
            var _juiceRankThreshold = global.juicerRankUpThreshold[currentRank];
            var _oldT = (startJuice - _juiceRankMin) / _juiceRankThreshold;
            var _newT = (currentJuice - _juiceRankMin) / _juiceRankThreshold;
            var _targetDisplayOldT = lerp(0.03, 0.98, _oldT);
            
            if (_oldT < 0)
                _targetDisplayOldT = 0;
            
            if (_oldT >= 1)
                _targetDisplayOldT = 1;
            
            var _targetDisplayNewT = lerp(0.03, 0.98, _newT);
            
            if (_newT < 0)
                _targetDisplayNewT = 0;
            
            if (_newT >= 1)
                _targetDisplayNewT = 1;
            
            surface_set_target(_overlayTextureSurface);
            draw_clear_alpha(c_black, 0);
            
            if (currentRank < global.juicerRankMax)
            {
                juicebarDrawCurve(752, 810, 740, 490, _targetDisplayNewT, true, 20, make_color_rgb(65, 231, 125), 1);
                juicebarDrawCurve(752, 810, 740, 490, _targetDisplayOldT, true, 30, make_color_rgb(248, 45, 97), 1);
            }
            else
            {
                juicebarDrawCurve(752, 810, 740, 490, 1, false, 20, make_color_rgb(255, 233, 1), 1);
            }
            
            gpu_set_colorwriteenable(true, true, true, false);
            var _old_tex_filter = gpu_get_tex_filter();
            gpu_set_tex_filter(false);
            draw_sprite_tiled_ext(sResultsMeterBubblesTexture, 0, 0, -((0.07 * current_time) % 600), 1, 1, c_white, 0.15);
            draw_sprite_tiled_ext(sResultsMeterWavesTexture, 0, (0.04 * current_time) % 600, -((0.03 * current_time) % 600), 1, 1, c_white, 0.05);
            gpu_set_colorwriteenable(true, true, true, true);
            gpu_set_tex_filter(_old_tex_filter);
            surface_reset_target();
            matrix_set(2, matrix);
            draw_sprite_ext(sResultsBody, 0, 0, 0, 2, 2, 0, c_white, 1);
            draw_surface(_overlayTextureSurface, 0, 0);
            draw_sprite_ext(sResultsBody, 1, 0, 0, 2, 2, 0, c_white, 1);
            var _scale = lerp(0.95, 1.05, 0.5 + (0.5 * dsin(current_time / 13)));
            draw_sprite_ext(sResultsMeterCloud, 0, 752, 810, _scale, _scale, -current_time / 54, c_white, 1);
            draw_sprite_ext(sResultsBody, 2, 0, 0, 2, 2, 0, c_white, 1);
            var _t = (pointsStart == 0) ? 1 : clamp((pointsStart - pointsDisplay) / pointsStart, 0, 1);
            juicebarDrawStraight(105, 922, 674, 1158, 1 - _t, false, 0, make_color_rgb(65, 231, 125), 1);
            
            if (drawScore)
                scribble(floor(pointsStart)).starting_format("sResultsScoreText", make_color_rgb(255, 255, 255)).transform(1, 1, 0).align(1, 1).typewriter_in(0.5, 40).typewriter_ease(UnknownEnum.Value_7, 0, 0, 1, 0.8, 0, 0.03).draw(380, 1042);
            
            draw_sprite_ext(sResultsBody, 3, 0, 0, 2, 2, 0, c_white, 1);
            draw_sprite_ext(sResultsBody, 4, 0, 0, 2, 2, 0, c_white, 1);
            
            if (currentRank < global.juicerRankMax)
                draw_sprite_ext(sResultsMeter, currentRank, 272, 850, 2, 2, 0, c_white, 1);
            else
                scribble("[scale,9]" + loc("result rank max")).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 233, 1)).align(1, 2).msdf_border(make_color_rgb(46, 50, 59), 3).draw(752, 700);
            
            if (currentRank < global.juicerRankMax)
            {
                draw_sprite(sResultsPadlock, lockImage, 1432, 940);
                draw_sprite(sResultsReward, global.juicerRankReward[currentRank], 1128, 1024);
            }
            else
            {
            }
            
            var _text = scribble("[scale,4]" + loc("result juicer rank")).align(1, 1).scale_to_box(rootInstance.rankFrameLengthMax - (2 * rootInstance.rankFrameSpacing), rootInstance.rankFrameHeight).starting_format(locGetFontFromLanguage(), make_color_rgb(46, 50, 59));
            var _textWidth = clamp(_text.get_width() + (2 * rootInstance.rankFrameSpacing), rootInstance.rankFrameLengthMin, rootInstance.rankFrameLengthMax);
            drawThreeSlice(sResults3SliceGrey, 750 - (_textWidth / 2), 750 + (_textWidth / 2), 736);
            _text.draw(750, 792);
            _text = scribble("[scale,4]" + loc("result reward")).align(1, 1).scale_to_box(rootInstance.rewardFrameLengthMax - (2 * rootInstance.rewardFrameSpacing), rootInstance.rewardFrameHeight).starting_format(locGetFontFromLanguage(), make_color_rgb(46, 50, 59));
            _textWidth = clamp(_text.get_width() + (2 * rootInstance.rewardFrameSpacing), rootInstance.rewardFrameLengthMin, rootInstance.rewardFrameLengthMax);
            drawThreeSlice(sResults3SliceYellow, 1128 - (_textWidth / 2), 1128 + (_textWidth / 2), 1146);
            _text.draw(1128, 1202);
            matrix_set(2, matrix_build_identity());
        });
        updateShape();
    }
    
    with (newChild("results text"))
    {
        setVisible(false);
        setX(getParent().getShapeWidth() / 2);
        setBottom(uiGet("results body").getShapeTop() - 1);
        setWidth(0.1 * sprite_get_width(sResultsSignA));
        setHeight(0.1 * sprite_get_height(sResultsSignA));
        var _headerTextString = loc("result game over");
        delayTimeThreshold = 20;
        
        if (_endingResult)
        {
            _headerTextString = "[cycle,32,43]" + loc("game complete header");
            delayTimeThreshold = 120;
        }
        
        textElement = scribble("[fa_center][fa_middle]" + _headerTextString, rootInstance).scale_to_box(rootInstance.frameLengthMax - (2 * rootInstance.frameHorizontalSpaceFromText), rootInstance.fontHeight).starting_format(locGetFontFromLanguage(), make_color_rgb(36, 145, 249));
        delayTime = 0;
        inTweenTime = 0;
        eventAddFunction(UnknownEnum.Value_1, function()
        {
            if (getVisible())
            {
                if (inTweenTime < 1)
                {
                    inTweenTime = min(1, inTweenTime + doDelta(0.04));
                }
                else if (delayTime < delayTimeThreshold)
                {
                    delayTime += doDelta(1);
                    
                    if (delayTime >= delayTimeThreshold)
                    {
                        playSoundGameOverAppear();
                        uiGet("results body").setVisible(true);
                    }
                }
            }
        });
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            var _scale = animcurve_tween(0.5, 1, curveBackInv, inTweenTime);
            matrix_set(2, matrix_build(getDrawX(), getDrawY(), 0, 0, 0, 0, _scale, _scale, 1));
            var _bbox = textElement.get_bbox(0, 0, rootInstance.frameHorizontalSpaceFromText, 0, rootInstance.frameHorizontalSpaceFromText, 0);
            var _left = min(-((0.5 * rootInstance.frameLengthMin) + rootInstance.frameHorizontalSpaceFromText), _bbox.left);
            var _right = max((0.5 * rootInstance.frameLengthMin) + rootInstance.frameHorizontalSpaceFromText, _bbox.right);
            drawThreeSliceExt(sResultsSignA_3slice, _left, _right, 0, 0.1, 16777215, 1);
            textElement.draw(0, 0);
            matrix_set(2, matrix_build_identity());
        });
    }
    
    with (newChild("results lobby button"))
    {
        uiTemplateSpriteScaled(sResultsLobbyButton, 0, 0.1);
        musicPlaying = 0;
        setActive(false);
        setVisible(false);
        setX(getParent().getShapeWidth() / 2);
        setTop(uiGet("results body").getShapeBottom() + 2);
        delayTime = _ignoreClicksDelay;
        inTweenTime = 0;
        visYOffset = 30;
        visAlpha = 0;
        eventAddFunction(UnknownEnum.Value_5, function()
        {
        });
        eventAddFunction(UnknownEnum.Value_1, function()
        {
            if (getVisible())
            {
                if (!musicPlaying && !rootInstance.endingResult)
                {
                    playMusicUI(music_gameOver, true, true);
                    musicPlaying = 1;
                }
                
                inTweenTime = min(1, inTweenTime + doDelta(0.027777777777777776));
                visYOffset = animcurve_tween(30, 0, curveExpoInv, inTweenTime);
                visAlpha = inTweenTime;
            }
        });
        eventAddFunction(UnknownEnum.Value_9, function()
        {
            if (delayTime <= 0)
                imageIndex = 1;
        });
        eventAddFunction(UnknownEnum.Value_11, function()
        {
            if (inTweenTime >= 1 && getActive())
                delayTime -= doDelta(1);
            
            imageIndex = 0;
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            if (imageIndex == 1 && inTweenTime >= 1)
            {
                playSoundBackButton();
                
                if (audioAssetIsPlaying(music_gameOver))
                    audioStop(audioGetByAsset(music_gameOver));
                
                roomTransitionTo(rmPlayableMainMenu, "lobby normal");
            }
        });
    }
    
    with (newChild("results reward"))
    {
        uiTemplateRectangle(make_color_rgb(46, 50, 59), 0);
        setLeft(0);
        setTop(0);
        setRight(getParent().getShapeWidth());
        setBottom(getParent().getShapeHeight());
        setVisible(false);
        setActive(false);
        setChildrenVisible(false);
        setChildrenActive(false);
        
        killReward = function()
        {
            setVisible(false);
            setActive(false);
            setChildrenVisible(false);
            setChildrenActive(false);
            var _rewardSoundLoopID = audioGetByAsset(sfx_rankup_reward_lp);
            audioFadeOut(_rewardSoundLoopID, 1/30);
            
            with (uiGet("results body"))
            {
                currentRank = min(currentRank + 1, global.juicerRankMax);
                setChildrenActive(true);
                delayTime = goFaster ? 5 : restartDelayTime;
                lockImage = 0;
                decrementSize = 0;
            }
        };
        
        inTweenTime = 0;
        delayTime = 0;
        ignoreClicksDelayTime = _ignoreClicksDelay;
        eventAddFunction(UnknownEnum.Value_1, function()
        {
            if (getVisible())
            {
                if (delayTime > 0)
                    delayTime -= doDelta();
                
                if (inTweenTime < 1)
                {
                    inTweenTime = min(inTweenTime + doDelta(0.08), 1);
                    visAlpha = 0.7 * inTweenTime;
                }
                
                if (mouse_check_button_released(mb_left) && (inTweenTime >= 1 && delayTime <= 0))
                    killReward();
            }
        });
        eventAddFunction(UnknownEnum.Value_5, function()
        {
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
        });
        updateShape();
        
        with (newChild())
        {
            setActive(false);
            setChildrenActive(false);
            setX(getParent().getShapeWidth() / 2);
            setY((getParent().getShapeHeight() / 2) - 10);
            setWidth(min(getParent().getShapeWidth(), getParent().getShapeHeight()));
            setHeight(getRawWidth());
            eventAddFunction(UnknownEnum.Value_2, function()
            {
                var _tweenTime = getParent().inTweenTime;
                var _rank = uiGet("results body").currentRank;
                var _reward = global.juicerRankReward[_rank];
                var _scale = (animcurve_tween(0, 1, curveBackInv, _tweenTime) * (getDrawWidth() + 20)) / (sprite_get_width(sResultsBody) * 2);
                drawRainbowSplash(getDrawX(), getDrawY(), _scale, current_time);
                drawSetInterpolation(false);
                draw_sprite_ext(sResultsReward, _reward, getDrawX(), getDrawY(), 0.25 * _tweenTime, 0.25 * _tweenTime, 0, c_white, 1);
                drawSetInterpolation(true);
                var _rewardText = getRewardText(_reward);
                var _textElement = scribble(_rewardText).starting_format(locGetFontFromLanguage(), make_color_rgb(46, 50, 59)).align(1, 0);
                var _width = _textElement.get_width();
                _scale = (getDrawWidth() - 50) / _width;
                _scale = min(0.5, _scale);
                _textElement.transform(_scale, _scale, 0);
                var _bbox = _textElement.get_bbox(getDrawX(), getDrawY() + 38, 14, 2, 14, 2);
                drawPillWithOutline(_bbox.left, _bbox.top, _bbox.right, _bbox.bottom, make_color_rgb(255, 233, 1), make_color_rgb(46, 50, 59), _tweenTime);
                _textElement.blend(16777215, _tweenTime).draw(getDrawX(), getDrawY() + 38);
                scribble("[scale,0.66][wave][pin_center][fa_middle]" + loc("result rank up reward")).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).bezier(getDrawX() - 90, getDrawY() + 45, getDrawX() - 30, getDrawY() - 15, getDrawX() + 30, getDrawY() - 15, getDrawX() + 90, getDrawY() + 45).msdf_border(make_color_rgb(46, 50, 59), 3).draw(getDrawX() - 90, getDrawY() - 15);
            });
        }
    }
}
