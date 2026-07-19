function initializeGlobals()
{
    global.debugDrawVariableTracker = false;
    global.debugDrawVariableTrackerArray[0][0] = -1;
    global.debugDrawAudioEngine = false;
    global.debugForceShorterPortraitScreen = false;
    global.debugAreaAllList = ds_list_create();
    ds_list_add(global.debugAreaAllList, 0, UnknownEnum.Value_1, UnknownEnum.Value_2, UnknownEnum.Value_3, UnknownEnum.Value_4, UnknownEnum.Value_5, UnknownEnum.Value_6);
    global.room_pack_eval_script = live_execute_string;
    global.room_pack_blank_object = obj_blankForGMRoomPack;
    global.fullscreen = false;
    global.userWindowWidth = -1;
    global.userWindowHeight = -1;
    global.userWindowPositionX = -1;
    global.userWindowPositionY = -1;
    global.wideGame = false;
    global.screenshakeEnabled = true;
    global.musicEnabled = 1;
    global.soundEnabled = 1;
    global.hapticEnabled = true;
    global.hapticAvailable = false;
    global.invertSwipe = 0;
    global.accessibilityTimeScale = 1;
    global.gameSurfaceLeft = 0;
    global.gameSurfaceTop = 0;
    global.gameSurfaceRight = 0;
    global.gameSurfaceBottom = 0;
    global.windowCenterx = 0;
    global.windowLeft = 0;
    global.windowRight = 0;
    global.windowMiddley = 0;
    global.windowTop = 0;
    global.windowBottom = 0;
    global.applicationSurfaceDrawWidth = 0;
    global.applicationSurfaceDrawHeight = 0;
    global.surfaceCompressionRate = round(window_get_width() / 160);
    global.surfaceCompressionRateUpdate = 0;
    
    if (os_type == os_ios)
        TextureManagerHighMemSet(false);
    else if (os_type == os_android)
        TextureManagerHighMemSet(false);
    else
        TextureManagerHighMemSet(false);
    
    initializeSpriteAnimationData();
    global.uiFingerEnabled = false;
    
    switch (os_type)
    {
        case os_macosx:
        case os_windows:
            global.uiFingerEnabled = true;
            break;
        
        default:
            global.uiFingerEnabled = false;
            break;
    }
    
    global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_4] = 30;
    global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_5] = 30;
    global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_6] = 30;
    global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_7] = 30;
    global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_8] = 30;
    global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_9] = 20;
    global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_10] = 20;
    global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_11] = 20;
    global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_12] = 20;
    global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_13] = 20;
    initializeAbilityUpgrades();
    global.bannedFruitList = ds_list_create();
    global.equipmentSlot = ds_list_create();
    
    repeat (6)
        ds_list_add(global.equipmentSlot, -1);
    
    global.unlockedAbilityList = ds_list_create();
    global.fruitRandomSpawnGrid = -1;
    global.areaNames[0] = "off";
    global.areaNames[UnknownEnum.Value_1] = "beginner";
    global.areaNames[UnknownEnum.Value_2] = "vines";
    global.areaNames[UnknownEnum.Value_3] = "bubble";
    global.areaNames[UnknownEnum.Value_4] = "jump pad";
    global.areaNames[UnknownEnum.Value_5] = "cannon";
    global.areaNames[UnknownEnum.Value_6] = "final mix";
    global.areaOrderList = -1;
    global.areaUnlockedList = ds_list_create();
    global.areaUnlockThreshold[0] = 3;
    global.areaUnlockThreshold[1] = 6;
    global.areaUnlockThreshold[2] = 10;
    global.areaUnlockThreshold[3] = 15;
    global.bossLevelMax = 256;
    global.baseJuiceAmountRequiredForLevelUp = 5;
    
    for (var i = 0; i <= global.bossLevelMax; i += 1)
        global.bossLevelThreshold[i] = (i - 1) * 10;
    
    global.bossLevelThreshold[2] = 10;
    global.bossLevelThreshold[3] = 20;
    global.bossLevelThreshold[4] = 30;
    global.bossLevelThreshold[5] = 40;
    global.bossLevelThreshold[6] = 50;
    global.bossLevelThreshold[7] = 60;
    global.bossLevelThreshold[8] = 70;
    global.bossLevelThreshold[9] = 80;
    global.bossLevelThreshold[10] = 90;
    global.bossLevelThreshold[11] = 100;
    global.bossLevelThreshold[12] = 110;
    global.bossLevelThreshold[13] = 120;
    global.bossLevelThreshold[14] = 130;
    global.bossLevelThreshold[15] = 140;
    global.bossLevelThreshold[16] = 150;
    global.bossLevelThreshold[17] = 200;
    global.bossLevelThreshold[18] = 200;
    global.bossLevelThreshold[19] = 400;
    global.bossLevelThreshold[20] = 500;
    global.bossLevelThreshold[global.bossLevelMax + 1] = 99999999;
    global.rewardSprite[UnknownEnum.Value_0] = sJumpCounts00;
    global.rewardSprite[UnknownEnum.Value_1] = sUIequipmentSlot;
    global.rewardSprite[UnknownEnum.Value_2] = sUIheart;
    global.rewardSprite[UnknownEnum.Value_3] = sGoldenSeed;
    global.rewardSprite[UnknownEnum.Value_4] = sGoldenSeed;
    global.rewardSprite[UnknownEnum.Value_5] = sGoldenSeed;
    global.juicerRankUpThreshold[0] = 0;
    global.juicerRankUpThreshold[1] = 50;
    global.juicerRankUpThreshold[2] = 100;
    global.juicerRankUpThreshold[3] = 150;
    global.juicerRankUpThreshold[4] = 200;
    global.juicerRankUpThreshold[5] = 400;
    global.juicerRankUpThreshold[6] = 600;
    global.juicerRankUpThreshold[7] = 1200;
    global.juicerRankUpThreshold[8] = 1500;
    global.juicerRankUpThreshold[9] = 1800;
    global.juicerRankUpThreshold[10] = 2000;
    global.juicerRankUpThreshold[11] = 2500;
    global.juicerRankUpThreshold[12] = 3000;
    global.juicerRankUpThreshold[13] = 4000;
    global.juicerRankUpThreshold[14] = 5000;
    global.juicerRankUpThreshold[15] = 6000;
    global.juicerRankUpThreshold[16] = 7000;
    global.juicerRankUpThreshold[17] = 8000;
    global.juicerRankUpThreshold[18] = 9000;
    global.juicerRankUpThreshold[19] = 10000;
    global.juicerRankUpThreshold[20] = 999999999999;
    global.juicerRankMax = 20;
    global.juicerRankReward[0] = UnknownEnum.Value_0;
    global.juicerRankReward[1] = UnknownEnum.Value_0;
    global.juicerRankReward[2] = UnknownEnum.Value_3;
    global.juicerRankReward[3] = UnknownEnum.Value_1;
    global.juicerRankReward[4] = UnknownEnum.Value_2;
    global.juicerRankReward[5] = UnknownEnum.Value_0;
    global.juicerRankReward[6] = UnknownEnum.Value_4;
    global.juicerRankReward[7] = UnknownEnum.Value_1;
    global.juicerRankReward[8] = UnknownEnum.Value_0;
    global.juicerRankReward[9] = UnknownEnum.Value_4;
    global.juicerRankReward[10] = UnknownEnum.Value_1;
    global.juicerRankReward[11] = UnknownEnum.Value_0;
    global.juicerRankReward[12] = UnknownEnum.Value_5;
    global.juicerRankReward[13] = UnknownEnum.Value_0;
    global.juicerRankReward[14] = UnknownEnum.Value_1;
    global.juicerRankReward[15] = UnknownEnum.Value_0;
    global.juicerRankReward[16] = UnknownEnum.Value_5;
    global.juicerRankReward[17] = UnknownEnum.Value_1;
    global.juicerRankReward[18] = UnknownEnum.Value_0;
    global.juicerRankReward[19] = UnknownEnum.Value_0;
    global.juicerRankReward[20] = UnknownEnum.Value_0;
    global.puzzleCurrentTheme = UnknownEnum.Value_1;
    global.puzzleCurrentIndex = 0;
    global.puzzleLevelCount = 5;
    initializePuzzleRoomIndex();
    global.areaMusicList[0] = music_tutorial;
    global.areaMusicList[UnknownEnum.Value_1] = music_tutorial;
    global.areaMusicList[UnknownEnum.Value_2] = music_jungle;
    global.areaMusicList[UnknownEnum.Value_3] = music_aqua;
    global.areaMusicList[UnknownEnum.Value_4] = music_mines;
    global.areaMusicList[UnknownEnum.Value_5] = music_temple;
    global.areaMusicList[UnknownEnum.Value_6] = music_outerSpace;
    global.puzzleMusicList[0] = music_puzzleBeginner00;
    global.puzzleMusicList[UnknownEnum.Value_1] = music_puzzleBeginner00;
    global.puzzleMusicList[UnknownEnum.Value_2] = music_puzzleJungleMain;
    global.puzzleMusicList[UnknownEnum.Value_3] = music_puzzleAquaMain;
    global.puzzleMusicList[UnknownEnum.Value_4] = music_puzzleMinesMain;
    global.puzzleMusicList[UnknownEnum.Value_5] = music_puzzleTempleMain;
    global.puzzleMusicList[UnknownEnum.Value_6] = music_puzzleSpaceMain;
    global.puzzleMusicIntroList[0] = music_puzzleIntro00;
    global.puzzleMusicIntroList[UnknownEnum.Value_1] = music_puzzleIntro00;
    global.puzzleMusicIntroList[UnknownEnum.Value_2] = music_puzzleJungleIntro;
    global.puzzleMusicIntroList[UnknownEnum.Value_3] = music_puzzleAquaIntro;
    global.puzzleMusicIntroList[UnknownEnum.Value_4] = music_puzzleMinesIntro;
    global.puzzleMusicIntroList[UnknownEnum.Value_5] = music_puzzleTempleIntro;
    global.puzzleMusicIntroList[UnknownEnum.Value_6] = music_puzzleSpaceIntro;
    global.puzzleMusicIntroPlay = 0;
}

function getRewardSprite(arg0)
{
    return global.rewardSprite[arg0];
}

function getRewardText(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_0:
            return loc("reward jump orb");
        
        case UnknownEnum.Value_1:
            return loc("reward equipment slot");
        
        case UnknownEnum.Value_2:
            return loc("reward rescue heart");
        
        case UnknownEnum.Value_3:
        case UnknownEnum.Value_4:
        case UnknownEnum.Value_5:
            return loc("reward money");
    }
}

function getRewardMoneyAmount(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_3:
            return 30;
        
        case UnknownEnum.Value_4:
            return 50;
        
        case UnknownEnum.Value_5:
            return 100;
    }
}

function drawReward(arg0, arg1, arg2)
{
    var _rewardSprite = getRewardSprite(arg2);
    drawSpriteSetSize(_rewardSprite, 0, arg0, arg1, 16, 16);
    
    if (arg2 != UnknownEnum.Value_1 && arg2 != UnknownEnum.Value_0 && arg2 != UnknownEnum.Value_2)
    {
        var _goldAmount = getRewardMoneyAmount(arg2);
        drawSetAlign(1, 0);
        drawTextOutlined(arg0, arg1 + 4, _goldAmount, make_color_rgb(225, 223, 1), make_color_rgb(46, 50, 59), 0, 0.8);
    }
}
