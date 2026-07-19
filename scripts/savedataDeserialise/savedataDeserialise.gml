function savedataDeserialise(arg0)
{
    var _map = json_decode(arg0);
    
    if (ds_map_empty(_map) || (ds_map_size(_map) == 1 && _map[? "default"] == ""))
    {
        trace("Load: No savedata found, skipping deserialisation");
        ds_map_destroy(_map);
        exit;
    }
    
    if (_map < 0)
    {
        traceLoud("Could not deserialise savedata, it may be corrupted");
        ds_map_destroy(_map);
        exit;
    }
    
    if (ds_map_exists(_map, "ROOT"))
        _map = _map[? "ROOT"];
    
    var _foundVersion = _map[? "gameVersion"];
    trace("Load: Savedata is version ", _foundVersion);
    var _loadVersion = undefined;
    
    switch (_foundVersion)
    {
        case 100:
            _loadVersion = 100;
            break;
        
        default:
            _loadVersion = _foundVersion;
            break;
    }
    
    trace("Load: Deserialising using version ", _loadVersion);
    
    switch (_loadVersion)
    {
        case 102:
            ds_list_destroy(global.endlessAverageList_best[UnknownEnum.Value_0]);
            global.endlessAverageList_best[UnknownEnum.Value_0] = mapReadListCopy(_map, "endless average 10 best");
            ds_list_destroy(global.endlessAverageList_best[UnknownEnum.Value_1]);
            global.endlessAverageList_best[UnknownEnum.Value_1] = mapReadListCopy(_map, "endless average 8 best");
            ds_list_destroy(global.endlessAverageList_best[UnknownEnum.Value_2]);
            global.endlessAverageList_best[UnknownEnum.Value_2] = mapReadListCopy(_map, "endless average 6 best");
            ds_list_destroy(global.endlessAverageList_best[UnknownEnum.Value_3]);
            global.endlessAverageList_best[UnknownEnum.Value_3] = mapReadListCopy(_map, "endless average 4 best");
            ds_list_destroy(global.endlessAverageList_best[UnknownEnum.Value_4]);
            global.endlessAverageList_best[UnknownEnum.Value_4] = mapReadListCopy(_map, "endless average 2 best");
        
        case 101:
            ds_list_destroy(global.endlessAverageList_current[UnknownEnum.Value_0]);
            global.endlessAverageList_current[UnknownEnum.Value_0] = mapReadListCopy(_map, "endless average 10 current");
            ds_list_destroy(global.endlessAverageList_current[UnknownEnum.Value_1]);
            global.endlessAverageList_current[UnknownEnum.Value_1] = mapReadListCopy(_map, "endless average 8 current");
            ds_list_destroy(global.endlessAverageList_current[UnknownEnum.Value_2]);
            global.endlessAverageList_current[UnknownEnum.Value_2] = mapReadListCopy(_map, "endless average 6 current");
            ds_list_destroy(global.endlessAverageList_current[UnknownEnum.Value_3]);
            global.endlessAverageList_current[UnknownEnum.Value_3] = mapReadListCopy(_map, "endless average 4 current");
            ds_list_destroy(global.endlessAverageList_current[UnknownEnum.Value_4]);
            global.endlessAverageList_current[UnknownEnum.Value_4] = mapReadListCopy(_map, "endless average 2 current");
        
        case 100:
            global.moneyJar = mapReadSafe(_map, "moneyJar", 0);
            global.tutorialOver = mapReadSafe(_map, "tutorialOver", global.tutorialOver);
            global.juicerRankProgress = mapReadSafe(_map, "juicerRankProgress", 0);
            global.wideGame = mapReadSafe(_map, "wideGame", 0);
            global.fullscreen = mapReadSafe(_map, "fullscreen", false);
            global.userWindowWidth = mapReadSafe(_map, "userWindowWidth", -1);
            global.userWindowHeight = mapReadSafe(_map, "userWindowHeight", -1);
            global.userWindowPositionX = mapReadSafe(_map, "userWindowPositionX", -1);
            global.userWindowPositionY = mapReadSafe(_map, "userWindowPositionY", -1);
            global.screenshakeEnabled = mapReadSafe(_map, "screenshakeEnabled", true);
            global.musicEnabled = mapReadSafe(_map, "musicEnabled", 1);
            global.soundEnabled = mapReadSafe(_map, "soundEnabled", 1);
            global.invertSwipe = mapReadSafe(_map, "invertSwipe", 0);
            global.accessibilityTimeScale = mapReadSafe(_map, "slowerTimeScale", 1);
            global.hapticEnabled = mapReadSafe(_map, "hapticEnabled", os_type == os_ios || os_type == os_android);
            global.notif_equipment = mapReadSafe(_map, "notif_equipment", 0);
            global.notif_gacha = mapReadSafe(_map, "notif_gacha", 0);
            global.puzzleAreaUnlockNotification = mapReadSafe(_map, "puzzleAreaUnlockNotification", 0);
            global.arcadeUnlock = mapReadSafe(_map, "arcadeUnlock", 0);
            global.puzzleModeUnlocked = mapReadSafe(_map, "puzzleUnlock", 0);
            global.endingReached = mapReadSafe(_map, "endingReached", 0);
            global.finalMixReached = mapReadSafe(_map, "finalMixReached", 0);
            global.languageSetByUser = mapReadSafe(_map, "languageSetByUser", -1);
            global.debugForceShorterPortraitScreen = mapReadSafe(_map, "force short screen", -1);
            global.debugDrawVariableTracker = mapReadSafe(_map, "debug variable tracker", false);
            global.debugDrawAudioEngine = mapReadSafe(_map, "debug audio engine", false);
            global.endlessHighScore[UnknownEnum.Value_0] = mapReadSafe(_map, "endless score 10", 0);
            global.endlessHighScore[UnknownEnum.Value_1] = mapReadSafe(_map, "endless score 8", 0);
            global.endlessHighScore[UnknownEnum.Value_2] = mapReadSafe(_map, "endless score 6", 0);
            global.endlessHighScore[UnknownEnum.Value_3] = mapReadSafe(_map, "endless score 4", 0);
            global.endlessHighScore[UnknownEnum.Value_4] = mapReadSafe(_map, "endless score 2", 0);
            puzzleDataImport(mapReadSafe(_map, "puzzle data", ""));
            ds_list_destroy(global.areaUnlockedList);
            global.areaUnlockedList = mapReadListCopy(_map, "areaUnlockedList");
            ds_list_destroy(global.upgrade);
            global.upgrade = mapReadListCopy(_map, "upgrade");
            ds_list_destroy(global.equipmentSlot);
            global.equipmentSlot = mapReadListCopy(_map, "equipment");
            ds_list_destroy(global.unlockedAbilityList);
            global.unlockedAbilityList = mapReadListCopy(_map, "unlocked ability");
            ds_list_destroy(global.endlessPackedScoreList);
            global.endlessPackedScoreList = mapReadListCopy(_map, "leaderboard scores");
            ds_list_destroy(global.achievementTrophyGotList);
            global.achievementTrophyGotList = mapReadListCopy(_map, "trophy list");
            
            if (ds_list_size(global.endlessPackedScoreList) != UnknownEnum.Value_20)
            {
                trace("Warning! endlessPackedScoreList has incorrect size (", ds_list_size(global.endlessPackedScoreList), ")");
                
                repeat (UnknownEnum.Value_20 - ds_list_size(global.endlessPackedScoreList))
                    ds_list_add(global.endlessPackedScoreList, undefined);
            }
            
            trace("Load: Deserialised successfully!");
            break;
        
        default:
            traceLoud("Savedata version unsupported");
            break;
    }
    
    ds_map_destroy(_map);
}
