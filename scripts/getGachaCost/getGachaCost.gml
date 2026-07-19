function getGachaCost()
{
    var _a = ds_list_size(global.unlockedAbilityList) + 1;
    
    if (global.endingReached >= UnknownEnum.Value_2)
        _a -= 5;
    
    _a = clamp(_a, 1, 999);
    return _a * 10;
}
