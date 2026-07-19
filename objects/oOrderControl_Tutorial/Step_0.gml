if (recipeMismatchSequence)
{
    recipeMismatchAnimcurveSpeed = 0.009523809523809525;
    recipeMismatchAnimcurvePos += doDelta(recipeMismatchAnimcurveSpeed);
    recipeMismatchAnimcurvePos = clamp(recipeMismatchAnimcurvePos, 0, 1);
    recipeMismatchSequenceTimer -= doDelta(1);
    
    if (recipeMismatchSequenceTimer <= 0 && !orderComplete)
    {
        ds_grid_set_region(recipeDataGrid, UnknownEnum.Value_3, 0, UnknownEnum.Value_3, ds_grid_height(recipeDataGrid) - 1, 0);
        orderChecklistUpdate();
        recipeMismatchSequence = 0;
        recipeMismatchSequenceTimer = recipeMismatchSequenceTimerDefault;
        recipeMismatchAnimcurvePos = 0;
    }
}

if (meterLevel >= 25)
{
    global.playerControlLock = 1;
    global.playerControlLockReleaseTimer = 30;
    timeScaleChange(0.01, 1, 0.5);
    endTransitionTimer += doDelta(1);
    
    if (endTransitionTimer >= 240)
    {
        TextureManagerGoto("ending");
        room_goto(rmEndSequence);
    }
}

if (tut_timerActive)
    angerTimer = approach(angerTimer, 0, 1 * global.deltaTimeRate);

if (angerTimer <= 0)
{
    if (!orderComplete)
        angerImminent = 1;
}
else
{
    angerImminent = 0;
}

if (angerImminent && tut_angerActive)
{
    if (oPlayer.currentState == "ground")
    {
        angerExecute();
        
        with (oTutSeq_JuiceTutorial)
        {
            initializeSequence = 1;
            currentSequence = "timer fail";
        }
        
        instance_destroy();
    }
}

if (orderComplete)
    orderCompleteSequence += doDelta(1);

if (tut_juiceSuccess == 1)
{
    tut_juiceSuccessCount += 1;
    tut_juiceSuccess = 0;
    
    switch (tut_juiceSuccessCount)
    {
        case 0:
        case 1:
        case 2:
            global.difficultyLevel = 2;
            break;
        
        case 3:
        case 4:
            global.difficultyLevel = 2;
            var _fin = 0;
            
            with (oTutSeq_JuiceTutorial)
                nextSequence("glugging before timer");
            
            with (oPlayer)
                xsp = -(x - 88) / 38;
            
            destroy = 1;
            break;
        
        case 5:
        case 6:
            global.difficultyLevel = 2;
            break;
        
        case 7:
        case 8:
            global.difficultyLevel = 3;
            break;
        
        case 9:
            with (oTutSeq_JuiceTutorial)
                nextSequence("glugging before thanks");
            
            with (oPlayer)
                xsp = -(x - 88) / 38;
            
            with (oTutFruitRespawnArea)
            {
                if (place_meeting(x, y, oTutJuiceAltar))
                    instance_destroy();
            }
            
            with (oFruit)
                instance_destroy();
            
            destroy = 1;
            break;
    }
}

if (orderCompleteSequence > 60)
{
    orderComplete = 0;
    orderFailed = 0;
    orderCompleteSequence = 0;
    angerImminent = 0;
    angerTimer = angerTimerMax;
    tut_renewRecipe();
}

if (destroy)
    instance_destroy();
