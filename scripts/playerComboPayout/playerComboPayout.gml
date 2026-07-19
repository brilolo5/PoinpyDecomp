function playerComboPayout()
{
    var _success = 0;
    var _forceComplete = 0;
    
    if (argument_count > 0)
    {
        _forceComplete = argument[0];
        gainComboElement(getFruitSprite(UnknownEnum.Value_0), UnknownEnum.Value_0, 0);
    }
    
    if (instance_exists(oOrderControl))
    {
        var _checkIsGood;
        
        with (oOrderControl)
        {
            _checkIsGood = orderCheck(recipeDataGrid, global.comboGrid);
            
            if (_checkIsGood || _forceComplete)
            {
                _success = 1;
                global.bannedFruitActive = 0;
                beastGameStateChange("success");
                gameStartBeastAngry = 0;
                haptic("pop");
                playSfxWorld(sfx_player_fruit_press_head);
                orderComplete = 1;
                angerImminent = 0;
                var _totalTypesInOrder = ds_grid_height(recipeDataGrid);
                var _totalFruitsInOrder = ds_grid_get_sum(recipeDataGrid, UnknownEnum.Value_1, 0, UnknownEnum.Value_1, _totalTypesInOrder);
                var _totalTypes = ds_grid_height(global.comboGrid);
                var _totalFruits = ds_grid_get_sum(global.comboGrid, UnknownEnum.Value_1, 0, UnknownEnum.Value_1, _totalTypes);
                var _totalGolden = ds_grid_get_sum(global.comboGrid, UnknownEnum.Value_2, 0, UnknownEnum.Value_2, _totalTypes);
                var _excessFruits = _totalFruits - _totalFruitsInOrder;
                _excessFruits = clamp(_excessFruits, 0, 999);
                
                if (global.gameMode == UnknownEnum.Value_0)
                {
                    gameScore = _excessFruits;
                    gameScore = clamp(gameScore, 0, 999);
                    var _excessBonus = _excessFruits;
                    _excessBonus *= _excessBonus;
                    var _baseScore = round(global.difficultyLevel);
                    _baseScore = round(global.bossLevelThreshold[global.difficultyLevel + 1] / global.baseJuiceAmountRequiredForLevelUp);
                    
                    if (abilityCheck(UnknownEnum.Value_22))
                    {
                        gameScore = _excessFruits + oOrderControl.endlessModeMinimumFruitAmount;
                        gameScore = clamp(gameScore, 0, 999);
                        _baseScore = 0;
                        _excessBonus = 0;
                        oControl.averageListScrollScaler = 1;
                        ds_list_delete(global.endlessAverageList_current[global.endlessMode], 4);
                        ds_list_insert(global.endlessAverageList_current[global.endlessMode], 0, gameScore);
                        var _averageList = global.endlessAverageList_current[global.endlessMode];
                        var _averageValue = meanFromList(_averageList, 4);
                        _averageValue = clamp(_averageValue, 0, 999);
                        var _averageNA = 0;
                        
                        function checkFor0inList(arg0)
                        {
                            var i = 0;
                            var total = 1;
                            
                            repeat (4)
                            {
                                total *= arg0[| i];
                                i += 1;
                            }
                            
                            return (total == 0) ? true : false;
                        }
                        
                        if (checkFor0inList(_averageList))
                        {
                            _averageNA = 1;
                            _averageValue = 0;
                        }
                        else
                        {
                            oControl.averageScoreTweenPrevious = oControl.averageScoreTween;
                            oControl.averageScoreTweenScaler = 1;
                        }
                        
                        var _averageList_best = global.endlessAverageList_best[global.endlessMode];
                        var _averageValue_best = meanFromList(_averageList_best, 4);
                        
                        if (_averageValue > _averageValue_best && !_averageNA)
                        {
                            ds_list_copy(global.endlessAverageList_best[global.endlessMode], global.endlessAverageList_current[global.endlessMode]);
                            
                            with (instance_create_depth(getViewx(global.cam), getViewy(global.cam), depth, effectText))
                            {
                                text = loc("main game UI best average notification");
                                drawx = global.windowCenterx;
                                drawy = (global.viewHeight / 4) + 16;
                                drawGui = true;
                                mainColor = make_color_rgb(255, 255, 255);
                                shadeColor = make_color_rgb(46, 50, 59);
                                angle = 0;
                                size = 1;
                                halign = 1;
                                valign = 0;
                                killTimer = 180;
                            }
                            
                            var _leaderboardID = leaderboardsFindID(global.endlessMode, true);
                            var _packedScore = scoreSquishPackAverage(global.endlessAverageList_best[global.endlessMode], _averageValue);
                            global.endlessPackedScoreList[| _leaderboardID] = _packedScore;
                            leaderboardsPostRaw(_leaderboardID, _packedScore);
                        }
                        
                        modeIndex = getEndlessMode();
                        bestScore = global.endlessHighScore[modeIndex];
                        newHighScore = false;
                        modeName = "???";
                        
                        switch (modeIndex)
                        {
                            case UnknownEnum.Value_4:
                                modeName = "2 jumps";
                                break;
                            
                            case UnknownEnum.Value_3:
                                modeName = "4 jumps";
                                break;
                            
                            case UnknownEnum.Value_2:
                                modeName = "6 jumps";
                                break;
                            
                            case UnknownEnum.Value_1:
                                modeName = "8 jumps";
                                break;
                            
                            case UnknownEnum.Value_0:
                                modeName = "10 jumps";
                                break;
                        }
                        
                        if (modeIndex > -1)
                        {
                            if (gameScore > bestScore)
                            {
                                newHighScore = true;
                                array_set(global.endlessHighScore, modeIndex, gameScore);
                                
                                with (instance_create_depth(getViewx(global.cam), getViewy(global.cam), depth, effectText))
                                {
                                    text = loc("main game UI highscore notification");
                                    drawx = global.windowCenterx;
                                    drawy = global.viewHeight / 4;
                                    drawGui = true;
                                    mainColor = make_color_rgb(255, 255, 255);
                                    shadeColor = make_color_rgb(46, 50, 59);
                                    angle = 0;
                                    size = 1;
                                    halign = 1;
                                    valign = 2;
                                    killTimer = 180;
                                }
                                
                                var _leaderboardID = leaderboardsFindID(global.endlessMode, false);
                                var _packedScore = scoreSquishPackSingle(global.endlessHighScore[global.endlessMode]);
                                global.endlessPackedScoreList[| _leaderboardID] = _packedScore;
                                leaderboardsPostRaw(_leaderboardID, _packedScore);
                            }
                        }
                        
                        var _maxJump = getMaxJump();
                        
                        switch (_maxJump)
                        {
                            case 10:
                                checkForEndlessTrophy(UnknownEnum.Value_4, gameScore);
                                checkForEndlessTrophy(UnknownEnum.Value_9, _averageValue);
                                break;
                            
                            case 8:
                                checkForEndlessTrophy(UnknownEnum.Value_5, gameScore);
                                checkForEndlessTrophy(UnknownEnum.Value_10, _averageValue);
                                break;
                            
                            case 6:
                                checkForEndlessTrophy(UnknownEnum.Value_6, gameScore);
                                checkForEndlessTrophy(UnknownEnum.Value_11, _averageValue);
                                break;
                            
                            case 4:
                                checkForEndlessTrophy(UnknownEnum.Value_7, gameScore);
                                checkForEndlessTrophy(UnknownEnum.Value_12, _averageValue);
                                break;
                            
                            case 2:
                                checkForEndlessTrophy(UnknownEnum.Value_8, gameScore);
                                checkForEndlessTrophy(UnknownEnum.Value_13, _averageValue);
                                break;
                            
                            default:
                                break;
                        }
                        
                        saveGame();
                        
                        switch (modeIndex)
                        {
                            case UnknownEnum.Value_4:
                                modeName = "2 jumps";
                                break;
                            
                            case UnknownEnum.Value_3:
                                modeName = "4 jumps";
                                break;
                            
                            case UnknownEnum.Value_2:
                                modeName = "6 jumps";
                                break;
                            
                            case UnknownEnum.Value_1:
                                modeName = "8 jumps";
                                break;
                            
                            case UnknownEnum.Value_0:
                                modeName = "10 jumps";
                                break;
                        }
                    }
                    
                    var _totalScore = _baseScore + _excessBonus;
                    
                    if (!_forceComplete)
                        fruitCountAdd(_totalScore, _baseScore, _excessBonus);
                }
                else
                {
                    var _arcadeIncrement = 10 + _excessFruits;
                    fruitCountAdd(_arcadeIncrement, 10, _excessFruits);
                }
                
                var myJuiceEffect = instance_create_depth(oPlayer.x, oPlayer.y, oPlayer.depth, oJuiceHomingParticleEmitter);
                ds_grid_copy(myJuiceEffect.receivedComboGrid, global.comboGrid);
                
                with (oPlayer)
                {
                    if (xsp == 0)
                        addHitStop(16);
                    else
                        addHitStop(4);
                    
                    damageInvincibility = 30;
                    screenShake(4, 4);
                    
                    if (abilityCheck(UnknownEnum.Value_6) && currentState == "dead" && deathCount == 0 && !abilityCheck(UnknownEnum.Value_22))
                    {
                        resurrectionEffect(sItem_juice_resurrection);
                        global.lifePoint = 1;
                        addHitStop(16);
                        screenShake(3, 3);
                        global.upgradeIcon[| UnknownEnum.Value_6] = sItem_juice_resurrection_used;
                        currentState = "slam bounce";
                        slamImageIndex = 0;
                        slamBounceTimer = slamBounceTimerMax;
                        playerEntityBounce();
                        deathResetTimer = deathResetTimerDefault;
                        deathCount += 1;
                    }
                    else
                    {
                        xsp = clamp(xsp, -0.2, 0.2);
                        ysp = -3;
                        
                        if (abilityCheck(UnknownEnum.Value_9))
                        {
                            playSoundAbilityBouncySpring();
                            ysp = -4.5;
                        }
                        
                        addHitStop(10);
                        screenShake(4, 3);
                        
                        if (currentState != "dead")
                            playerStateChange("slam bounce");
                        
                        slamImageIndex = 0;
                        slamBounceTimer = slamBounceTimerMax;
                    }
                }
                
                if (finalLevelOrder)
                {
                    global.difficultyLevel = approach(global.difficultyLevel, 25, 1);
                    
                    if (global.difficultyLevel >= 25)
                    {
                        if (global.endingReached == UnknownEnum.Value_0)
                        {
                            global.endingReached = UnknownEnum.Value_1;
                            abilityUnlock(UnknownEnum.Value_22);
                            abilityUnlock(UnknownEnum.Value_23);
                            abilityUnlock(UnknownEnum.Value_24);
                            abilityUnlock(UnknownEnum.Value_25);
                            abilityUnlock(UnknownEnum.Value_26);
                        }
                        
                        var _maxJump = getMaxJump();
                        
                        if (_maxJump <= 10)
                            trophyUnlock(UnknownEnum.Value_0);
                        
                        if (_maxJump <= 8)
                            trophyUnlock(UnknownEnum.Value_1);
                        
                        if (_maxJump <= 6)
                            trophyUnlock(UnknownEnum.Value_2);
                        
                        if (_maxJump <= 4)
                            trophyUnlock(UnknownEnum.Value_3);
                        
                        global.difficultyLevel = 25;
                        instance_create_depth(x, y, 0, oEndingSequence);
                        
                        with (oJuiceHomingParticleEmitter)
                            bezierSpeed *= 0.5;
                    }
                    
                    global.mainGameFruitProgress = 0;
                }
                
                with (oOrderControl_Tutorial)
                    tut_juiceSuccess = 1;
            }
            else if (angerImminent)
            {
                angerExecute();
            }
            else if (!global.playerControlLock)
            {
                orderMiss = 1;
            }
        }
        
        if (ds_grid_height(global.comboGrid) > 0)
        {
            if (_checkIsGood)
            {
                ds_grid_resize(global.comboGrid, comboGridWidth, 0);
                ds_grid_clear(global.comboGrid, -1);
            }
            else
            {
                playerComboLoss();
            }
        }
        
        if (ysp > -2)
            ysp = -2;
    }
    else
    {
        playerComboLoss();
    }
    
    with (oOrderControl)
    {
    }
    
    if (abilityCheck(UnknownEnum.Value_22))
        global.lifePoint = 1;
    
    comboElementGetRecordIndex = 0;
    launched = 0;
    
    with (oTutFruitRespawnArea)
        growTutFruit();
    
    return _success;
}

function checkForEndlessTrophy(arg0, arg1)
{
    if (arg1 >= global.achievementTrophyEndlessScoreThreshold[arg0])
        trophyUnlock(arg0);
}
