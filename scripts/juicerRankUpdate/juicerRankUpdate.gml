function juicerRankUpdate()
{
    global.juicerRankProgress = clamp(global.juicerRankProgress, 0, 99999999);
    var totalThreshold = 0;
    var foundRank = undefined;
    
    for (var i = 0; i <= global.juicerRankMax; i += 1)
    {
        totalThreshold += global.juicerRankUpThreshold[i];
        
        if (global.juicerRankProgress < totalThreshold)
        {
            foundRank = i;
            break;
        }
    }
    
    if (foundRank != undefined)
    {
        global.juicerRank = foundRank;
    }
    else
    {
        global.juicerRank = global.juicerRankMax;
        trace("Warning! Could not find a valid new juicer rank for progress = ", global.juicerRankProgress, ", setting rank to ", global.juicerRank);
    }
    
    global.equipmentUnlockedSlotNum = 1;
    global.jumpTimesMax = 1;
    
    for (var i = 0; i < global.juicerRank; i += 1)
    {
        switch (global.juicerRankReward[i])
        {
            case UnknownEnum.Value_0:
                global.jumpTimesMax += 1;
                break;
            
            case UnknownEnum.Value_1:
                global.equipmentUnlockedSlotNum += 1;
                break;
            
            case UnknownEnum.Value_2:
                global.rescueLife = 1;
                break;
        }
    }
    
    if (global.lifePoint <= 0)
        global.rescueLife = 0;
}

function checkMoneyGotFromRankingUp(arg0 = global.juicerRankProgress, arg1 = global.mainGameFruitProgress_total)
{
    var totalThreshold = 0;
    var currentRank = undefined;
    
    for (var i = 0; i <= global.juicerRankMax; i += 1)
    {
        totalThreshold += global.juicerRankUpThreshold[i];
        
        if (arg0 < totalThreshold)
        {
            currentRank = i;
            break;
        }
    }
    
    show_debug_message("current rank: " + string(currentRank));
    
    currentRank ??= global.juicerRankMax;
    
    totalThreshold = 0;
    var reachingRank = undefined;
    
    for (var i = 0; i <= global.juicerRankMax; i += 1)
    {
        totalThreshold += global.juicerRankUpThreshold[i];
        
        if ((arg0 + arg1) < totalThreshold)
        {
            reachingRank = i;
            break;
        }
    }
    
    show_debug_message("reaching rank: " + string(reachingRank));
    
    reachingRank ??= global.juicerRankMax;
    
    var _totalMoneyGainedAsReward = 0;
    
    for (var i = currentRank; i < reachingRank; i += 1)
    {
        var _moneyReward = 0;
        
        switch (global.juicerRankReward[i])
        {
            case UnknownEnum.Value_3:
                _moneyReward = 30;
                break;
            
            case UnknownEnum.Value_4:
                _moneyReward = 50;
                break;
            
            case UnknownEnum.Value_5:
                _moneyReward = 100;
                break;
            
            default:
                break;
        }
        
        if (_moneyReward > 0)
        {
            show_debug_message("rank " + string(i));
            show_debug_message("money reward: " + string(_moneyReward));
            _totalMoneyGainedAsReward += _moneyReward;
        }
    }
    
    show_debug_message("total money reward: " + string(_totalMoneyGainedAsReward));
    return _totalMoneyGainedAsReward;
}
