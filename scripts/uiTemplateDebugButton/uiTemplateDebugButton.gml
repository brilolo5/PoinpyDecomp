function uiTemplateDebugButton(arg0, arg1, arg2)
{
    buttonIndex = arg0;
    uiTemplateRectangle(make_color_rgb(218, 221, 226), 0.6);
    eventAddFunction(UnknownEnum.Value_4, function()
    {
        visBlend = make_color_rgb(255, 255, 255);
        callEventInChildren();
    });
    eventAddFunction(UnknownEnum.Value_6, function()
    {
        visBlend = make_color_rgb(218, 221, 226);
        callEventInChildren();
    });
    eventAddFunction(UnknownEnum.Value_8, function()
    {
        callEventInChildren();
    });
    eventAddFunction(UnknownEnum.Value_10, function()
    {
        callEventInChildren();
        
        switch (buttonIndex)
        {
            case UnknownEnum.Value_1:
                global.difficultyLevel = approach(global.difficultyLevel, global.bossLevelMax - 1, 1);
                var _child_tag = children[0];
                var _child = uiGet(_child_tag);
                _child.text = concat("recipe level: ", global.difficultyLevel);
                instance_activate_object(oOrderControl);
                
                with (oOrderControl)
                {
                    orderComplete = 1;
                    fruitCountAdd(0, 0, 0);
                    satisfactionMeterTween_dewReceived = 1;
                    beast_dewReceiveWobbleTween += 0.05;
                    beast_sequenceTimer = 0;
                }
                
                instance_deactivate_object(oOrderControl);
                break;
            
            case UnknownEnum.Value_2:
                global.difficultyLevel = 20;
                instance_activate_object(oOrderControl);
                
                with (oOrderControl)
                {
                    orderComplete = 1;
                    fruitCountAdd(0, 0, 0);
                    satisfactionMeterTween_dewReceived = 1;
                    beast_dewReceiveWobbleTween += 0.05;
                    beast_sequenceTimer = 0;
                    meterLevel = 19;
                }
                
                instance_deactivate_object(oOrderControl);
                instance_destroy(rootInstance);
                break;
            
            case UnknownEnum.Value_3:
                global.debugAreaLock += 1;
                var _allListSize = ds_list_size(global.debugAreaAllList);
                
                if (global.debugAreaLock >= _allListSize)
                    global.debugAreaLock = 0;
                
                global.currentLevelChunkSet = global.debugAreaLock;
                _child_tag = children[0];
                _child = uiGet(_child_tag);
                _child.text = concat("area lock: ", global.areaNames[global.debugAreaLock]);
                break;
            
            case UnknownEnum.Value_5:
                global.debugNoDamage = !global.debugNoDamage;
                _child_tag = children[0];
                _child = uiGet(_child_tag);
                _child.text = concat("no damage mode: ", global.debugNoDamage);
                break;
            
            case UnknownEnum.Value_10:
                global.toggleObjectiveUI = !global.toggleObjectiveUI;
                _child_tag = children[0];
                _child = uiGet(_child_tag);
                _child.text = concat("toggleObjectiveUI: ", global.toggleObjectiveUI);
                break;
            
            case UnknownEnum.Value_11:
                global.debugControl = !global.debugControl;
                _child_tag = children[0];
                _child = uiGet(_child_tag);
                _child.text = concat("toggleDebugControl: ", global.debugControl);
                break;
            
            case UnknownEnum.Value_8:
                global.debugDrawVariableTracker = !global.debugDrawVariableTracker;
                _child_tag = children[0];
                _child = uiGet(_child_tag);
                _child.text = concat("variable tracker: ", global.debugDrawVariableTracker);
                break;
            
            case UnknownEnum.Value_9:
                global.debugDrawAudioEngine = !global.debugDrawAudioEngine;
                _child_tag = children[0];
                _child = uiGet(_child_tag);
                _child.text = concat("audio engine debug: ", global.debugDrawAudioEngine);
                break;
            
            case UnknownEnum.Value_12:
                global.mainGameFruitProgress_total += 50;
                _child_tag = children[0];
                _child = uiGet(_child_tag);
                _child.text = concat("get exp : ", global.mainGameFruitProgress_total);
                break;
            
            case UnknownEnum.Value_13:
                global.lifePoint = 0;
                instance_activate_object(oPlayer);
                oPlayer.currentState = "dead";
                oPlayer.deathResetTimer = 30;
                instance_destroy(rootInstance);
                break;
            
            case UnknownEnum.Value_15:
                leaderboardsLogIn();
                break;
            
            case UnknownEnum.Value_16:
                if (leaderboardsLoginState() >= 1)
                {
                    if (os_type == os_ios)
                    {
                        extension_stubfunc_real();
                    }
                    else
                    {
                    }
                }
                else
                {
                    trace("Leaderboards: Please log in first");
                }
                
                break;
            
            case UnknownEnum.Value_17:
                leaderboardsPostRaw(UnknownEnum.Value_2, scoreSquishPackSingle(50, [irandom(UnknownEnum.Value_29), irandom(UnknownEnum.Value_29), irandom(UnknownEnum.Value_29), irandom(UnknownEnum.Value_29), irandom(UnknownEnum.Value_29), irandom(UnknownEnum.Value_29)]));
                break;
            
            case UnknownEnum.Value_18:
                leaderboardsPull(UnknownEnum.Value_0);
                break;
            
            case UnknownEnum.Value_19:
                leaderboardsDebugFill();
                break;
            
            case UnknownEnum.Value_20:
                global.debugEnableLeaderboard = !global.debugEnableLeaderboard;
                _child_tag = children[0];
                _child = uiGet(_child_tag);
                _child.text = concat("leaderboardEnable: ", global.debugEnableLeaderboard);
                break;
            
            case UnknownEnum.Value_22:
                roomTransitionTo(rmMainGame, "main game normal");
                global.tutorialOver = max(1, global.tutorialOver);
                global.mainGamePaused = -1;
                instance_destroy(rootInstance);
                break;
            
            case UnknownEnum.Value_23:
                roomTransitionTo(rmPlayableMainMenu, "lobby normal");
                global.tutorialOver = max(1, global.tutorialOver);
                global.mainGamePaused = -1;
                instance_destroy(rootInstance);
                break;
            
            case UnknownEnum.Value_25:
                saveDebugReset();
                roomTransitionTo(rmTutorialMovement2, "lobby normal");
                global.mainGamePaused = -1;
                instance_destroy(rootInstance);
                break;
            
            case UnknownEnum.Value_27:
                roomTransitionTo(rmDebugRoom00, "lobby normal");
                global.mainGamePaused = -1;
                instance_destroy(rootInstance);
                break;
            
            case UnknownEnum.Value_28:
                roomTransitionTo(rmEnding, "lobby normal");
                global.mainGamePaused = -1;
                instance_destroy(rootInstance);
                break;
            
            case UnknownEnum.Value_29:
                roomTransitionTo(rmDebugRoom02_textBox, "lobby normal");
                global.mainGamePaused = -1;
                instance_destroy(rootInstance);
                break;
            
            case UnknownEnum.Value_26:
                roomTransitionTo(rmDebugEndingSequence, "lobby normal");
                global.mainGamePaused = -1;
                instance_destroy(rootInstance);
                break;
            
            case UnknownEnum.Value_24:
                roomTransitionTo(rmDebugRoom01_enemy, "lobby normal");
                global.mainGamePaused = -1;
                instance_destroy(rootInstance);
                break;
            
            case UnknownEnum.Value_30:
                instance_destroy(rootInstance);
                instance_create_depth(0, 0, 0, oDebugMenu_puzzleSelect);
                break;
            
            case UnknownEnum.Value_31:
                instance_destroy(rootInstance);
                puzzleDataDebugReset();
                break;
            
            case UnknownEnum.Value_38:
                instance_destroy(rootInstance);
                debugTrophyUnlockAll();
                break;
            
            case UnknownEnum.Value_4:
                global.jumpTimesMax += 1;
                
                if (global.jumpTimesMax >= 12)
                    global.jumpTimesMax = 2;
                
                _child_tag = children[0];
                _child = uiGet(_child_tag);
                _child.text = concat("jump times: ", global.jumpTimesMax);
                break;
            
            case UnknownEnum.Value_45:
                global.wideGame = !global.wideGame;
                trace("Toggling wideGame = ", global.wideGame);
                saveGame(true);
                instance_destroy(rootInstance);
                debugGameRestart();
                break;
            
            case UnknownEnum.Value_33:
                global.debugForceShorterPortraitScreen = !global.debugForceShorterPortraitScreen;
                saveGame(true);
                instance_destroy(rootInstance);
                debugGameRestart();
                break;
            
            case UnknownEnum.Value_34:
                locSetLanguage(locNextLanguage());
                _child_tag = children[0];
                _child = uiGet(_child_tag);
                _child.text = locNextLanguage();
                instance_destroy(rootInstance);
                room_restart();
                global.mainGamePaused = -1;
                break;
            
            case UnknownEnum.Value_35:
                locOutputCharsetFiles("0123456789,.-;:_+-*/\\'\"!?~^°<>|(){[]}%&=#@$ 　abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");
                
                if (show_question("Exported charset files to " + game_save_id + "\n \n \nWould you like to copy the path to your clipboard?"))
                    clipboard_set_text(game_save_id);
                
                break;
            
            case UnknownEnum.Value_36:
                global.moneyJar += 100;
                shownMoneyAmountUpdate();
                break;
            
            case UnknownEnum.Value_6:
                global.debugFps *= -1;
                show_debug_overlay(global.debugFps);
                _child_tag = children[0];
                _child = uiGet(_child_tag);
                _child.text = concat("show fps ", global.debugFps);
                break;
            
            case UnknownEnum.Value_7:
                global.debugHitbox *= -1;
                _child_tag = children[0];
                _child = uiGet(_child_tag);
                _child.text = concat("show hitbox ", global.debugHitbox);
                break;
            
            case UnknownEnum.Value_37:
                gameRestart();
                instance_destroy(rootInstance);
                break;
            
            case UnknownEnum.Value_41:
                saveDebugReset();
                instance_destroy(rootInstance);
                debugGameRestart();
                break;
            
            case UnknownEnum.Value_39:
                ds_list_clear(global.unlockedAbilityList);
                
                for (var i = 0; i < UnknownEnum.Value_29; i += 1)
                    ds_list_add(global.unlockedAbilityList, i);
                
                saveGame(true);
                instance_destroy(rootInstance);
                debugGameRestart();
                break;
            
            case UnknownEnum.Value_40:
                ds_list_clear(global.unlockedAbilityList);
                
                for (var i = 0; i < UnknownEnum.Value_29; i += 1)
                    ds_list_add(global.unlockedAbilityList, i);
                
                ds_list_shuffle(global.unlockedAbilityList);
                global.juicerRankProgress = 99999;
                global.moneyJar = 1000;
                shownMoneyAmountUpdate();
                ds_list_clear(global.areaUnlockedList);
                ds_list_add(global.areaUnlockedList, UnknownEnum.Value_2);
                ds_list_add(global.areaUnlockedList, UnknownEnum.Value_3);
                ds_list_add(global.areaUnlockedList, UnknownEnum.Value_4);
                ds_list_add(global.areaUnlockedList, UnknownEnum.Value_5);
                
                if (ds_exists(global.areaOrderList, ds_type_list))
                    ds_list_clear(global.areaOrderList);
                
                global.tutorialOver = max(2, global.tutorialOver);
                global.arcadeUnlock = 1;
                global.puzzleModeUnlocked = 1;
                global.finalMixReached = 1;
                global.endingReached = UnknownEnum.Value_2;
                puzzleDataUnlockSetsForUnlockedAreas();
                saveGame(true);
                instance_destroy(rootInstance);
                debugGameRestart();
                break;
            
            case UnknownEnum.Value_43:
            case UnknownEnum.Value_0:
                saveGame();
                instance_destroy(rootInstance);
                break;
        }
    });
    
    with (newChild())
    {
        setActive(false);
        setLeft(4);
        uiTemplateTextScaled(arg1, arg2);
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            drawTextOutlined(getDrawLeft(), getDrawTop(), text, visBlend, make_color_rgb(46, 50, 59), 0, textSize);
        });
        eventAddFunction(UnknownEnum.Value_4, function()
        {
            visBlend = make_color_rgb(255, 238, 96);
        });
        eventAddFunction(UnknownEnum.Value_6, function()
        {
            visBlend = make_color_rgb(255, 255, 255);
            visXOffset = 0;
            visYOffset = 0;
        });
        eventAddFunction(UnknownEnum.Value_8, function()
        {
            visBlend = make_color_rgb(248, 45, 97);
            visXOffset = -2;
            visYOffset = -2;
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            visBlend = make_color_rgb(255, 238, 96);
            visXOffset = 0;
            visYOffset = 0;
        });
    }
}
