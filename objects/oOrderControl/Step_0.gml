if (live_call())
    return global.live_result;

myAlarm1.tick();

if (recipeMismatchSequence)
{
    recipeMismatchAnimcurveSpeed = 0.005555555555555556 * global.deltaTimeRate;
    recipeMismatchAnimcurvePos += recipeMismatchAnimcurveSpeed;
    recipeMismatchAnimcurvePos = clamp(recipeMismatchAnimcurvePos, 0, 1);
    recipeMismatchSequenceTimer -= (1 * global.deltaTimeRate);
    
    if (recipeMismatchSequenceTimer <= 0 && !orderComplete)
    {
        ds_grid_set_region(recipeDataGrid, UnknownEnum.Value_3, 0, UnknownEnum.Value_3, ds_grid_height(recipeDataGrid) - 1, 0);
        orderChecklistUpdate();
        recipeMismatchSequence = 0;
        recipeMismatchSequenceTimer = recipeMismatchSequenceTimerDefault;
        recipeMismatchAnimcurvePos = 0;
    }
}

if (banPreActive > 0 && !recipeRiseSequence)
{
    global.bannedFruitActive = 0;
    banPreActive -= ((1/120) * global.deltaTimeRate);
    
    if (banPreActive <= 0)
        global.bannedFruitActive = 1;
}

if (orderMiss)
    orderMiss = 0;

if (!abilityCheck(UnknownEnum.Value_22) && !orderComplete && oPlayer.currentState != "dead" && !recipeRiseSequence && beastAngerTick)
{
    var _accessibilityTimescaleMinimum = 0.8;
    var _accessibilityTimescale = lerp(_accessibilityTimescaleMinimum, 1, global.accessibilityTimeScale);
    var _angerTimerDecrementValue = 1;
    
    if ((angerTimer / angerTimerMax) < 0.25)
    {
        var _reduceBy = 0.21052631578947367;
        
        if (angerTimerMax != angerTimerMax_default)
            _reduceBy = 0.2222222222222222;
        
        angerTimer -= doDelta(clamp(angerTimer / 100, _reduceBy, 1) * _accessibilityTimescale);
    }
    else
    {
        angerTimer = approach(angerTimer, 0, doDelta(1 * _accessibilityTimescale));
    }
}

if (angerTimer <= 0)
{
    if (!orderComplete)
        angerImminent = 1;
}
else
{
    angerImminent = 0;
}

if (angerImminent)
{
    if (oPlayer.currentState == "ground")
        angerExecute();
}

if (orderComplete)
{
    global.bannedFruitActive = 0;
    orderCompleteSequence += (1 * global.deltaTimeRate);
}

if (orderCompleteSequence > 75)
{
    orderComplete = 0;
    orderFailed = 0;
    orderCompleteSequence = 0;
    angerImminent = 0;
    
    if (global.gameMode != UnknownEnum.Value_0)
        angerTimerMax = approach(angerTimerMax, 120, 12);
    
    renewRecipe();
}

if (!finalLevelOrder)
{
    if (global.mainGameFruitProgress >= global.bossLevelThreshold[global.difficultyLevel + 1])
    {
        var i = global.difficultyLevel + 1;
        
        while (i < global.bossLevelMax)
        {
            if (global.mainGameFruitProgress >= global.bossLevelThreshold[i])
            {
                global.difficultyLevel = i;
                global.mainGameFruitProgress -= global.bossLevelThreshold[i];
                break;
            }
            
            i += 1;
        }
    }
    
    if (!abilityCheck(UnknownEnum.Value_22) && global.difficultyLevel >= 20)
    {
        finalLevelOrder = 1;
        global.difficultyLevel = 20;
        global.mainGameFruitProgress = 0;
        global.finalStretchSequence = UnknownEnum.Value_1;
        audioStop(global.areaMusic);
    }
}

if (global.finalStretchSequence != UnknownEnum.Value_0)
{
    if (global.finalStretchSequence <= UnknownEnum.Value_2)
    {
        recipeRiseSequence = 1;
        angerTimer = angerTimerMax + 60;
        
        if (meterLevel == 20)
            global.finalStretchSequence = UnknownEnum.Value_2;
        
        with (oFruit)
            instance_destroy();
    }
    
    if (meterLevel >= 25)
        global.playerControlLock = 1;
}
