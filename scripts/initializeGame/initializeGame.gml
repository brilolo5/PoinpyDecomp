function initializeGame()
{
    scribble_anim_wave(1.5, 0.5, -0.2);
    global.logoSprite = sLogo_Default;
    global.goldSeedAppearCount = 0;
    global.ingamePause = false;
    global.languageSetByUser = -1;
    global.debugControl = os_type == os_windows || os_type == os_macosx || os_type == os_linux;
    global.debugHitbox = -1;
    global.debugNoDamage = -1;
    global.debugFps = -1;
    global.debugForceShorterPortraitScreen = -1;
    global.debugAreaLock = 0;
    global.toggleObjectiveUI = 1;
    global.debugEnableLeaderboard = -1;
    vertex_format_begin();
    vertex_format_add_colour();
    vertex_format_add_position();
    vertex_format_add_normal();
    global.format_perspective = vertex_format_end();
    global.areaMusic = -1;
    global.equipmentMusic = -1;
    global.puzzleMenuMusic = -1;
    global.highscore = array_create(UnknownEnum.Value_3, undefined);
    global.arcadeAverageList_current = array_create(UnknownEnum.Value_3, undefined);
    global.arcadeAverageList_highest = array_create(UnknownEnum.Value_3, undefined);
    global.arcadeAreaLock = array_create(UnknownEnum.Value_3, undefined);
    global.arcadeAreaLock_highest = array_create(UnknownEnum.Value_3, undefined);
    
    for (var _mode = 0; _mode < UnknownEnum.Value_3; _mode++)
    {
        var _current_list = ds_list_create();
        var _highest_list = ds_list_create();
        array_set(global.arcadeAverageList_current, _mode, _current_list);
        array_set(global.arcadeAverageList_highest, _mode, _highest_list);
    }
    
    clearLocalHighscores();
    puzzleDataReset(UnknownEnum.Value_7);
    puzzleDataUnlockedSet(UnknownEnum.Value_1, -3, true);
    global.puzzleAreaUnlockNotification = 0;
    global.puzzleAreaUnlockedUpTo = -1;
    global.playerControlLock = 0;
    global.playerControlLockReleaseTimer = 0;
    global.staticHoldChargeMax = 120;
    global.allowPauseMenu = 1;
    global.gameMode = UnknownEnum.Value_0;
    clearLocalHighscores();
    global.arcadeUnlock = false;
    global.puzzleModeUnlocked = false;
    global.endingReached = UnknownEnum.Value_0;
    global.savedataFingerprintFailed = false;
    global.endlessPackedScoreList = ds_list_create();
    
    repeat (UnknownEnum.Value_20)
        ds_list_add(global.endlessPackedScoreList, undefined);
    
    global.endlessHighScore[UnknownEnum.Value_0] = 0;
    global.endlessHighScore[UnknownEnum.Value_1] = 0;
    global.endlessHighScore[UnknownEnum.Value_2] = 0;
    global.endlessHighScore[UnknownEnum.Value_3] = 0;
    global.endlessHighScore[UnknownEnum.Value_4] = 0;
    global.endlessMode = -1;
    
    for (var _ii = 0; _ii < UnknownEnum.Value_5; _ii += 1)
    {
        global.endlessAverageList_current[_ii] = ds_list_create();
        global.endlessAverageList_best[_ii] = ds_list_create();
        
        repeat (4)
        {
            ds_list_add(global.endlessAverageList_current[_ii], 0);
            ds_list_add(global.endlessAverageList_best[_ii], 0);
        }
    }
    
    global.cam = -1;
    global.cannonTempSlingAngle = -1;
    global.cannonAngleGoal = 0;
    global.showLogo = 1;
    global.timeScale = 1;
    global.timeScale_noDelta = 1;
    global.timeScaleDefault = 0.9;
    global.deltaTimeRate = 1;
    global.gameReturnedTo = 0;
    global.wallSwitch = "red";
    global.jumpReleaseInput = 0;
    global.tutorialOver = false;
    global.firstMainGameDone = false;
    global.orderChecklistFilled = false;
    global.oneGameTime = 0;
    global.timeScaledTime = 0;
    global.time = 0;
    global.mainGamePaused = -1;
    global.gameLevel = 0;
    global.portalCam = -1;
    global.juiceQuotaCount = 0;
    global.juiceQuota = 12;
    global.lifePointMax = 2;
    global.lifePoint = global.lifePointMax;
    global.rescueLife = 0;
    global.customerQueue = 1;
    global.levelUnlockProgress = 0;
    global.difficultyLevel = 0;
    global.juicerRank = 1;
    global.juicerRankProgress = 0;
    global.finalMixReached = 0;
    global.previousLevelChunkSet = UnknownEnum.Value_1;
    global.currentLevelChunkSet = UnknownEnum.Value_1;
    
    if (ds_exists(global.areaOrderList, ds_type_list))
        ds_list_destroy(global.areaOrderList);
    
    global.areaOrderList = -1;
    ds_list_clear(global.areaUnlockedList);
    ds_list_add(global.areaUnlockedList, UnknownEnum.Value_1);
    global.areaChangeTracker = 0;
    global.bannedFruitActive = 0;
    ds_list_clear(global.bannedFruitList);
    global.equipmentUnlockedSlotNum = 1;
    ds_list_clear(global.equipmentSlot);
    
    repeat (6)
        ds_list_add(global.equipmentSlot, -1);
    
    ds_list_clear(global.unlockedAbilityList);
    global.achievementTrophyGotList = ds_list_create();
    
    for (var i = 0; i < UnknownEnum.Value_15; i += 1)
    {
        global.achievementTrophyGotList[| i] = 0;
        global.medalSprite[i] = sMedal_clearBy10;
    }
    
    global.medalSprite[UnknownEnum.Value_0] = sMedal_clearBy10;
    global.medalSprite[UnknownEnum.Value_1] = sMedal_clearBy8;
    global.medalSprite[UnknownEnum.Value_2] = sMedal_clearBy6;
    global.medalSprite[UnknownEnum.Value_3] = sMedal_clearBy4;
    global.medalSprite[UnknownEnum.Value_4] = sMedal_endlessHighScore10;
    global.medalSprite[UnknownEnum.Value_5] = sMedal_endlessHighScore8;
    global.medalSprite[UnknownEnum.Value_6] = sMedal_endlessHighScore6;
    global.medalSprite[UnknownEnum.Value_7] = sMedal_endlessHighScore4;
    global.medalSprite[UnknownEnum.Value_8] = sMedal_endlessHighScore2;
    global.medalSprite[UnknownEnum.Value_9] = sMedal_endlessAverage10;
    global.medalSprite[UnknownEnum.Value_10] = sMedal_endlessAverage8;
    global.medalSprite[UnknownEnum.Value_11] = sMedal_endlessAverage6;
    global.medalSprite[UnknownEnum.Value_12] = sMedal_endlessAverage4;
    global.medalSprite[UnknownEnum.Value_13] = sMedal_endlessAverage2;
    global.medalSprite[UnknownEnum.Value_14] = sMedal_puzzleAllClear;
    global.notif_equipment = 0;
    global.notif_gacha = 0;
    global.mainGameFruitProgress = 0;
    global.mainGameFruitProgress_total = 0;
    global.moneyJar = 0;
    global.currency = 0;
    global.currencyOverLimit = 0;
    global.fruitSeed[UnknownEnum.Value_0] = 0;
    global.fruitSeed[UnknownEnum.Value_4] = 0;
    global.fruitSeed[UnknownEnum.Value_21] = 0;
    global.fruitSeedTemp[UnknownEnum.Value_0] = 0;
    global.fruitSeedTemp[UnknownEnum.Value_4] = 0;
    global.fruitSeedTemp[UnknownEnum.Value_21] = 0;
    global.walletMax = 10;
    global.totalStaminaMax = 20;
    global.totalStamina = global.totalStaminaMax;
    global.jumpTimesMax = 4;
    global.jumpTimes = global.jumpTimesMax;
    global.gameReinitializeState = "lobby normal";
    global.bossLifeMax = 200;
    global.bossLife = global.bossLifeMax;
    
    if (ds_exists(global.fruitRandomSpawnGrid, ds_type_grid))
        ds_grid_destroy(global.fruitRandomSpawnGrid);
    
    global.fruitRandomSpawnGrid = -1;
    var _fruitTempList = ds_list_create();
    ds_list_add(_fruitTempList, UnknownEnum.Value_0, UnknownEnum.Value_12);
    generateFruitList(_fruitTempList);
    ds_list_destroy(_fruitTempList);
    global.upgrade_spinner = 0;
    global.upgrade_cogwheel = 1;
    global.difficultyLevel = 0;
    global.mainGameFruitProgress = 0;
    
    for (var i = global.difficultyLevel; i < global.bossLevelMax; i += 1)
    {
        if (global.mainGameFruitProgress >= global.bossLevelThreshold[i])
            global.difficultyLevel = i;
    }
}
