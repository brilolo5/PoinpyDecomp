function initializePerGame()
{
    global.lifePoint = global.lifePointMax;
    global.finalStretchSequence = UnknownEnum.Value_0;
    
    if (!ds_exists(global.areaOrderList, ds_type_list))
    {
        global.areaOrderList = ds_list_create();
        ds_list_copy(global.areaOrderList, global.areaUnlockedList);
        ds_list_shuffle(global.areaOrderList);
    }
    
    if (global.gameReinitializeState != "puzzle")
        global.currentLevelChunkSet = global.areaOrderList[| 0];
    
    global.rescueLife = 0;
    global.unloadLevelArea_y = 16000;
    global.currency = 0;
    global.currencyOverLimit = 0;
    global.juicerRank = 1;
    audioStop(global.equipmentMusic);
    audioStop(global.puzzleMenuMusic);
    
    switch (room)
    {
        case rmMainGame:
            audioStop(global.areaMusic);
            break;
        
        case rmTutorialMovement2:
            global.currentLevelChunkSet = UnknownEnum.Value_1;
            break;
        
        case rmPlayableMainMenu:
            audioStop(global.areaMusic);
            
            if (global.tutorialOver && !instance_exists(oTE_thoughtBubbleOpen))
                playLobbyMusic();
            
            break;
        
        default:
            if (global.gameReinitializeState == "puzzle")
            {
            }
            else
            {
                audioStop(global.areaMusic);
            }
            
            break;
    }
    
    global.defaultFont = locGetFontFromLanguage(locGetLanguage());
    global.difficultyLevel = 1;
    global.mainGameFruitProgress = 0;
    global.mainGameFruitProgress_total = 0;
    global.oneGameTime = 0;
    disableAllAbility();
    oDraw.wallGlow = 0;
    global.timeScaleDefault = 0.9;
    
    switch (room)
    {
        case rmPlayableMainMenu:
        case rmMainGame:
        case rmDebugRoom01_enemy:
            toggleEquippedAbility();
            global.lifePointMax = 2;
            break;
        
        case rmPuzzle_finalMix00:
        case rmPuzzle_finalMix01:
        case rmPuzzle_finalMix02:
        case rmPuzzle_finalMix03:
        case rmPuzzle_finalMix04:
            oDraw.wallGlow = 1;
            break;
        
        default:
            break;
    }
    
    global.endlessMode = getEndlessMode();
    
    if (abilityCheck(UnknownEnum.Value_22))
        global.lifePoint = 1;
}
