myAlarm0.tick();
myAlarm1.tick();
myAlarm2.tick();
myAlarm3.tick();
myAlarm4.tick();
var _areaMusic = getMusicForPuzzleArea(global.puzzleCurrentTheme);
var _introMusic = getIntroMusicForPuzzleArea(global.puzzleCurrentTheme);

if (global.puzzleMusicIntroPlay == UnknownEnum.Value_4)
{
    introSkipTapCount += input_check_pressed("jump");
    
    if (!audio_is_playing(_introMusic))
    {
        oCamera.scrollButtonActive = 1;
        global.puzzleMusicIntroPlay = UnknownEnum.Value_0;
        global.areaMusic = playMusicUI(_areaMusic, true, true);
        timeScaleChange(1, 1, 1);
    }
    else if (introSkipTapCount >= 3)
    {
        oCamera.scrollButtonActive = 1;
        noIntroTimeStop = 1;
        timeScaleChange(1, 1, 1);
        
        with (effectText)
            instance_destroy();
        
        with (oScreenDimEffect_puzzle)
            instance_destroy();
    }
}

if (global.puzzleMusicIntroPlay > UnknownEnum.Value_0 && !noIntroTimeStop)
{
    playerControlLockTimer(4);
    timeScaleChange(0, 1, 1);
}

if ((orderMiss || global.lifePoint <= 0) && !puzzleComplete)
{
    if (!puzzleFailState)
    {
        puzzleFailState = 1;
        global.timeScale = 0.25;
    }
}

if (recipeMismatchSequence)
{
    recipeMismatchAnimcurveSpeed = 0.009523809523809525;
    recipeMismatchAnimcurvePos += recipeMismatchAnimcurveSpeed;
    recipeMismatchAnimcurvePos = clamp(recipeMismatchAnimcurvePos, 0, 1);
    recipeMismatchSequenceTimer -= 1;
    
    if (recipeMismatchSequenceTimer <= 0 && !orderComplete)
    {
        ds_grid_set_region(recipeDataGrid, UnknownEnum.Value_3, 0, UnknownEnum.Value_3, ds_grid_height(recipeDataGrid) - 1, 0);
        orderChecklistUpdate();
        recipeMismatchSequence = 0;
        recipeMismatchSequenceTimer = recipeMismatchSequenceTimerDefault;
        recipeMismatchAnimcurvePos = 0;
    }
}

if (puzzleFailState)
{
    playerControlLock();
    
    if (puzzleFailState == 1)
    {
        with (oPlayer)
        {
            hitStop = 0;
            playerStateChange("puzzle failed");
        }
    }
    
    var _targetTimescale = 0.01;
    var _shift = (global.timeScale - _targetTimescale) * 0.05;
    timeScaleChange(_targetTimescale, 1, _shift);
    var _puzzleFailStateTimerThreshold = 90;
    puzzleFailState += 1;
    
    if (input_check_released("jump"))
        puzzleFailState = _puzzleFailStateTimerThreshold;
    
    if (puzzleFailState == _puzzleFailStateTimerThreshold)
    {
        global.lifePoint = 1;
        orderMiss = 0;
        roomTransitionTo(room, "puzzle");
    }
}

if (orderComplete)
{
    puzzleComplete = 1;
    orderCompleteSequence = 1;
    playerControlLock();
    puzzleResultAppearTimer -= doDelta(0.011111111111111112);
    
    if (puzzleResultAppearTimer <= 0)
    {
        instance_destroy();
        instance_create_depth(0, 0, 0, oPuzzleCompleteMenu);
    }
}
