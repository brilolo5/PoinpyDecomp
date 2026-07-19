deltaTracker = 0;
puzzleEyeTimer = 0;
myAlarm3 = new makeAlarm(0, function()
{
    xDirection = 1;
    playerStateChange("beast bonk launch");
});
myAlarm4 = new makeAlarm(0, function()
{
    x = 80;
    var _myTransitionEffect = instance_create_depth(x, y, 0, oTSequence_mainEnter);
    
    if (global.tutorialOver < 2)
        _myTransitionEffect.delay = 120;
    
    audioFadeOut(global.areaMusic, 1/30);
    global.mainGamePaused = -1;
    global.gameMode = UnknownEnum.Value_0;
});
myAlarm6 = new makeAlarm(0, function()
{
    playerCannonLaunch(myCannon);
});
myAlarm7 = new makeAlarm(0, function()
{
    currentState = "spin jump";
    ysp = -8.5;
    playerControlLockTimer(60);
    myAlarm10.setTimer(30);
    myAlarm9.setTimer(myAlarm10.timerLeft() + 50);
});
myAlarm8 = new makeAlarm(0, function()
{
    instance_create_depth(x, y, 0, oPuzzleMenu);
});
myAlarm9 = new makeAlarm(0, function()
{
    global.areaMusic = playMusicUI(getMusicForArea(global.currentLevelChunkSet), true, true);
    oOrderControl.myAlarm1.setTimer(210);
    createAreaTextEffect();
});
myAlarm10 = new makeAlarm(0, function()
{
    with (oBeastMainGame)
        gameStartBeastEnterTweenStart = 1;
});
debugVarTrackListInit();

if (room == rmPlayableMainMenu)
    global.gameMode = UnknownEnum.Value_0;

initializePerGame();
cursorx = 0;
cursory = 0;
playerVisible = 1;
initialBonkPause = 1;
beastFullSequenceTimer = 180;
emptyJumpNotificationTextId = -1;
trajectoryExtend = 0;
trajecoryDashAppearTween = 0;
extraBonusTween = 0;
slamPause = 0;
slamFruitSquash = 0;
slamTargetx = -1;
entitySlamHitStop = 0;
jumpMarkerShrinkStart = 0;
global.totalStamina = global.totalStaminaMax;
global.jumpTimes = global.jumpTimesMax;
global.bossLife = global.bossLifeMax;
refillJumpTimes(global.jumpTimesMax);
jumpTimesMaxWithAbility = getMaxJump();
gamePadStickAimReset = 0;
gamePadStickLastAimAngle = 0;
controlUnlockOnRelease = 0;
noJumpLeftFeedback = 0;
noJumpLeftFeedback_triggerCount = 0;
noJumpLeftFeedback_triggerMax = 2;
stompInputCancelTime = 0;
stickInputRelease = 0;
stickInputRelease_prvState = 0;
audioVarSpin = 0;
audioVarLand = 0;
audioVarLaunched = 0;
audioVarPlayerFalling = 0;
audio_listener_orientation(0, 1, 0, 0, 0, 1);
global.mainGameFruitProgress = 0;
tankMaxSequence = 0;
xsp = 0;
ysp = 0;
xspSet = 0;
yspSet = 0;
trajectoryTweenXsp = 0;
trajectoryTweenYsp = 0;
cx = 0;
dcx = 0;
cy = 0;
dcy = 0;
slingDirection = 0;
slingLength = 0;
slingInputThreshold = 2;
slingPulled = 0;
fric = 0.5;
grv = 0.16;
launchSpeed = 6.25;

if (abilityCheck(UnknownEnum.Value_27))
    launchSpeed = 7;

tapThrustSpeed = 32;
launched = 0;
deathResetTimerDefault = 240;

if (abilityCheck(UnknownEnum.Value_22))
    deathResetTimerDefault = 30;

deathResetTimer = deathResetTimerDefault;
intentionalSlide = 0;
slideChargeTimer = 0;
myBubble = -4;
bubbleIgnoreTimerMax = 30;
bubbleIgnoreTimer = 0;
myCannon = -1;
global.comboGrid = ds_grid_create(0, 0);
comboGridWidth = 3;
comboLimit = 999;
ds_grid_resize(global.comboGrid, comboGridWidth, 0);
ds_grid_clear(global.comboGrid, -1);
timeLimitMax = 3600;
timeLimit = timeLimitMax;
longCombo = 0;
tank = 0;
tankMax = 60;
launchNoGravityTime = 0;
launchNoGravityTimeMax = 20;
wallClingDirection = 0;
currentState = "free";
playerStateChange("free");
slamBounceTimerMax = 8;
slamBounceTimer = slamBounceTimerMax;
fruitSuckInRadiusDefault = 12;
fruitSuckInRadiusScoop = 28;
fruitSuckInRadiusSlam = 66;
fruitSuckInRadiusWalljump = 50;
fruitSuckInRadiusSlamStart = 50;
fruitSuckInRadiusJumpStart = 50;
fruitSuckInRadius = fruitSuckInRadiusDefault;
fruitVicinityList = ds_list_create();
onewayBoostRecovery = 0;
jumpPadFatigueTimer = 0;
jumpPadFatigueTime = 10;
deathCount = 0;
spinnerTimer = 0;
spinnerTimerMax = 180;
slamHeightRecord = 10000;
damageInvincibilityTime = 120;
damageInvincibility = 0;
damageInvincibilityFlash = 0;
damageKnock = 0;
damageKnockTime = 60;
jumpThrust = -1;
juiceQuota = 60;
juiceQuotaDone = 0;
quotaBarTween = 0;
hitStop = 0;
global.playerControlLock = 1;
global.playerControlLockReleaseTimer = 10;
grounded = 1;
readyToJump = 0;
emptyNotification = 0;
spin = 0;
staticHoldCharge = global.staticHoldChargeMax;
spinSpeed = 0;
mbPress_x = 0;
mbPress_y = 0;
tempScore = 0;
slam = 0;
itemColorIndexMax = 2;
itemGetColor[0] = 0;
itemGetColor[1] = 0;
itemGetColor[2] = 0;
tapTimer = 0;
tapThresholdFrames = 10;
deathTimer = 60;
stateBeforeBubble = "free";
bubbleVisualScaler = 0;
comboUI_x = x;
comboUI_y = y;
slamImpactGameStopInterval = 0;
previousImageIndex = image_index;
slamImageIndex = 0;
jumpTimesOrbDrawPosyTween = 16;
jumpTimesOrbDrawPosxLeftTween = 0;
bonusTextTween = 0;
selfShake = 0;
selfShakeAmount = 0;
jumpRefillSequence = 0;
jumpRefillOrbEffect = 1;
xDirection = 1;
trailSize = 200;
trail_x = array_create(trailSize, x);
trail_y = array_create(trailSize, y);
whiteFlash = 0;
slamVisualTimer = 0;
depth = -10000;
spinStart = 4;
spinAccel = 25;
xscale = 1;
yscale = 1;
imgAngle = 0;
sprite_index = sPlayerSpin16;
mask_index = sPlayerBox;
spriteSize = 28;
spriteBaseSize = sprite_get_width(sPlayerSpin16);
showJumpNum = 1;
thumbCircleRadius = 0;
comboElementGetRecordIndex = 0;
comboElementGetRecord[0] = 0;
comboElementMultipleIndex = 0;
comboElementMultiple[0] = 0;
comboElementTypeIndex = 0;
comboElementType[0] = -1;
selfAlpha = 1;
spriteFlash = -1;
swipeJumporbx = x;
swipeJumporby = y;

if (global.gameReinitializeState == "puzzle")
{
    playerStateChange("init on ground");
    currentState = "init asleep on ground";
    playerControlLock();
}

if (room == rmMainGame)
{
    playSoundSpinEntrance();
    currentState = "main game intro freeze";
    myAlarm7.setTimer(1);
    playerControlLockTimer(10);
    
    if (global.tutorialOver < 2)
    {
        global.tutorialOver = max(2, global.tutorialOver);
        myAlarm7.setTimer(0);
        playerControlLock();
        instance_create_depth(x, y, 0, oFirstMainGameIntroSequence);
    }
    
    global.jumpTimes = 0;
}

if (room == rmPlayableMainMenu)
{
    currentState = "free - asleep";
    
    switch (global.gameReinitializeState)
    {
        case "lobby normal":
            x = 80;
            y = 0;
            currentState = "init asleep on beast";
            break;
        
        case "return from puzzle":
            x = 248;
            y = 5;
            currentState = "init asleep on ground";
            
            with (oCamera)
            {
                camPosy = oPlayer.y - 64 - 64 - 64;
                camGoalPosy = oPlayer.y - 64 - 64 - 64;
                camPosx = 240;
                camGoalPosx = camPosx;
            }
            
            break;
        
        case "after tutorial":
            x = 80;
            y = 896;
            global.jumpTimes = 0;
            currentState = "spin jump";
            ysp = -6;
            
            if (instance_exists(oCamera))
            {
                with (oCamera)
                {
                    camPosy = oPlayer.y - 64 - 64 - 64;
                    camGoalPosy = oPlayer.y - 64 - 64 - 64;
                }
            }
            
            break;
        
        case "arcade room 4":
        case "arcade room 2":
        case "lobby shop":
        default:
            x = 80;
            y = 0;
            break;
    }
}
