function abilityEquippedIndex(arg0)
{
    var _i = 0;
    
    repeat (global.equipmentUnlockedSlotNum)
    {
        if (global.equipmentSlot[| _i] == arg0)
        {
            return _i;
        }
        
        _i++;
    }
    
    return -1;
}
