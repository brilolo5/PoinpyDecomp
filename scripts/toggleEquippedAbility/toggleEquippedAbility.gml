function toggleEquippedAbility()
{
    juicerRankUpdate();
    
    for (var i = 0; i < UnknownEnum.Value_29; i += 1)
        global.upgrade[| i] = 0;
    
    for (var i = 0; i < global.equipmentUnlockedSlotNum; i += 1)
    {
        var _abilityInSlot = global.equipmentSlot[| i];
        
        if (_abilityInSlot >= 0)
            global.upgrade[| _abilityInSlot] = 1;
    }
    
    global.upgradeIcon[| UnknownEnum.Value_6] = sItem_juice_resurrection;
    
    if (abilityCheck(UnknownEnum.Value_22))
    {
        global.upgrade[| UnknownEnum.Value_7] = 0;
        global.upgradeIcon[| UnknownEnum.Value_7] = sAbilityExtraJump_asleep;
        global.endlessMode = getEndlessMode();
        global.lifePoint = 1;
        global.rescueLife = 0;
    }
    else
    {
        global.upgradeIcon[| UnknownEnum.Value_7] = sItem_extra_jump_orb;
        global.lifePoint = global.lifePointMax;
    }
    
    global.jumpTimes = 0;
    refillJumpTimes(global.jumpTimesMax);
    global.staticHoldChargeMax = 360;
    
    if (abilityCheck(UnknownEnum.Value_4))
        global.staticHoldChargeMax = 59940;
    
    if (abilityCheck(UnknownEnum.Value_27))
    {
        with (oPlayer)
            launchSpeed = 7;
    }
    else
    {
        with (oPlayer)
            launchSpeed = 6.25;
    }
}
