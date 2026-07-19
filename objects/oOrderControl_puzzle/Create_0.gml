myAlarm0 = new makeAlarm(0, function()
{
    for (var i = 0; i < UnknownEnum.Value_29; i += 1)
        global.upgrade[| i] = 0;
    
    global.jumpTimesMax = jumpLimit;
    refillJumpTimes();
    global.lifePoint = 1;
});
myAlarm1 = new makeAlarm(0, function()
{
    var _introMusic = getIntroMusicForPuzzleArea(global.puzzleCurrentTheme);
    global.areaMusic = playMusicUI(_introMusic, false, true);
    global.puzzleMusicIntroPlay = UnknownEnum.Value_4;
});
myAlarm2 = new makeAlarm(0, function()
{
    with (effectText)
        instance_destroy();
    
    myText = instance_create_depth(0, 0, depth, effectText);
    
    with (myText)
    {
        text = loc("puzzle start make juice");
        drawx = global.windowCenterx;
        drawy = global.viewHeight / 3;
        drawGui = true;
        mainColor = make_color_rgb(255, 255, 255);
        shadeColor = make_color_rgb(46, 50, 59);
        angle = 0;
        size = 1;
        halign = 1;
        valign = 1;
        killTimer = 180;
    }
});
myAlarm3 = new makeAlarm(0, function()
{
    var _parse = dimAlarmTime;
    
    with (instance_create_depth(x, y, 0, oScreenDimEffect_puzzle))
        killTimer = 240 - _parse;
});
myAlarm4 = new makeAlarm(0, function()
{
    oCamera.scrollButtonActive = 1;
});

with (oControl)
    walletUIappearTime = 0;

introSkipTapCount = 0;
global.bannedFruitActive = 1;

if (!creationCodeSet)
{
    jumpLimit = 2;
    puzzleRecipeInit();
    puzzleRecipeAdd(UnknownEnum.Value_0, UnknownEnum.Value_0, 2);
    puzzleRecipeAdd(UnknownEnum.Value_12, UnknownEnum.Value_0, 3);
    puzzleRecipeAdd(-1, UnknownEnum.Value_4, 2);
    puzzleRecipeBan(UnknownEnum.Value_1);
    sortRecipe();
    creationCodeSet = 1;
}

noIntroTimeStop = 0;

if (global.puzzleMusicIntroPlay == UnknownEnum.Value_1)
{
    audioStop(global.areaMusic);
    myAlarm1.setTimer(78);
    global.puzzleMusicIntroPlay = UnknownEnum.Value_3;
    myAlarm2.setTimer(78);
    dimAlarmTime = 72;
    myAlarm3.setTimer(dimAlarmTime);
    playerControlLockTimer(30);
}
else if (global.puzzleMusicIntroPlay == UnknownEnum.Value_2)
{
    noIntroTimeStop = 1;
    audioStop(global.areaMusic);
    myAlarm1.setTimer(12);
    global.puzzleMusicIntroPlay = UnknownEnum.Value_3;
    playerControlLockTimer(30);
    myAlarm4.setTimer(1);
}
else
{
    myAlarm4.setTimer(1);
}

var _fruitTempList = ds_list_create();
ds_list_add(_fruitTempList, UnknownEnum.Value_0, UnknownEnum.Value_12);
generateFruitList(_fruitTempList);
ds_list_destroy(_fruitTempList);
bonusCountTween = 0;
bonusCountRecord = 0;
bonusCountDelay = 0;
bonusAnimationTween = 0;
recipeMismatchSequence = 0;
recipeMismatchSequenceTimerDefault = 60;
recipeMismatchSequenceTimer = recipeMismatchSequenceTimerDefault;
recipeMismatchAnimcurve = 22;
recipeMismatchAnimcurvePos = 0;
recipeMismatchAnimcurveSpeed = 0.029166666666666667;
myAlarm0.setTimer(1);
global.timeScale = 1;
playerControlLockTimer(10);
global.lifePoint = 1;
initializePerGame();
outline_init();
beastSprite = -1;
beastBreatheCounter = 0;
beastAngerLayerRatioTween = 0;
beast_baseSurface = -1;
beast_croppingSurface = -1;
beastAnger_baseSurface = -1;
beastAnger_croppingSurface = -1;
previousViewy = getViewy(global.cam);
var centerx = global.viewWidth / 2;
endTransitionTimer = 0;
scoreIncrementalForShow = 0;
scoreIncrementalForShow_countdownAmount = 0;
scoreIncrementalForShow_downTimer = 0;
scoreIncrementalForShow_yoffset = 0;
scoreIncrementalForShow_baseScore = 0;
scoreIncrementalForShow_multiplier = 0;
satisfactionMeterTween_main = 0;
satisfactionMeterTween_late = 0;
satisfactionMeterTween_lateLooped = 1;
satisfactionMeterTween_dewReceived = 0;
satisfactionMeter_levelTextWobbleSequence = 0;
satisfactionMeter_levelTextTween = 0;
satisfactionMeter_levelTextSize = 1;
satisfactionMeter_levelTextAngle = 0;
satisfactionMeter_levelTextInitialWobble = 0;
beast_dewReceiveWobbleTween = 1;
beast_sequenceTimer = 0;
thoughtCloudSurface_bg = -1;
thoughtCloudSurface_pie = -1;
thoughtCloudSurface_crop = -1;
thoughtCloudBreatheTracker = 0;
thoughtCloudDangerShake = 0;
thoughtCloudDangerShakeAmount = 1;
thoughtCloudDangerShakeTracker = 0;
cloudBreatheScale = 1;
cloudScale = 1;
aboutToBlow = 0;
recipeListState = "normal";
recipeListStateInitialize = 0;
recipeListTimer = 0;
finalLevelOrder = 0;
depth = 999;
comboCheckGrid = ds_grid_create(0, 0);
comboCheck = -1;
global.orderChecklistFilled = 0;
orderComplete = 0;
orderCompleteSequence = 0;
angerImminent = 0;
orderFailed = 0;
prvBossLevel = 0;
pieValueTween = 0;
orderListWidth = 6;
orderListNumber = 2;
recipeRiseSequence = 0;
angerTimerMax_default = 960;
angerTimerMax = angerTimerMax_default;

if (global.gameMode != UnknownEnum.Value_0)
    angerTimerMax = 480;

angerSequence = 0;
angerFired = 0;
angerFlash = 0;
reduceTimer = 0;
flash = 0;
flashCount = 0;
beastState = "wait normal";
smileSequence = 0;
angerTimer = angerTimerMax + 120;
orderMiss = 0;
puzzleFailState = 0;
puzzleComplete = 0;
puzzleResultAppearTimer = 1;
comboGridWidth = 5;
levelUpSequence = 0;
levelUpSequenceTimerMax = 180;
levelUpSequenceTimer = 0;
debug_prvDifficultyLevel = global.difficultyLevel;
recipePreviousRandomPick = -1;
bossBarLengthMax = 152;
bossBarLengthTween = bossBarLengthMax;
bossBarDamageBarDelayTimer = 0;
previous_bossLife = global.bossLife;
beastyTween = 0;
stomachMeterLength_white = 0;
stomachMeterLength_main = 0;
stomachMeterLength_nextLevelWhite = 0;
stomachMeterFocusZoomRatio = 0;
stomachMeterFocusSequence = 0;
meterLevel = global.difficultyLevel;
dewReceive = 0;
dewLast = 0;
meterFillSequence = 0;
cr = round(window_get_width() / 160);
var surfaceWidth = 32 * cr;
var surfaceHeight = 34 * cr;
_baseSurface = -1;
_meterSurface = -1;
_croppingSurface = -1;
beastShrinkx = 1;
beastShrinky = 1;
beastShrinkSpeedx = 0;
beastShrinkSpeedy = 0;
beastScalex = 0.1 * beastShrinkx;
beastScaley = 0.1 * beastShrinky;
