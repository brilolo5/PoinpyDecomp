function abilityEquipFirstEmpty()
{
    var _i = 0;
    
    repeat (global.equipmentUnlockedSlotNum)
    {
        if (global.equipmentSlot[| _i] < 0)
            return _i;
        
        _i++;
    }
    
    return -1;
}
