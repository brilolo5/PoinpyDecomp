function putPajamasInBack()
{
    pajamaDeleteAndAdd(UnknownEnum.Value_22);
    pajamaDeleteAndAdd(UnknownEnum.Value_23);
    pajamaDeleteAndAdd(UnknownEnum.Value_24);
    pajamaDeleteAndAdd(UnknownEnum.Value_25);
    pajamaDeleteAndAdd(UnknownEnum.Value_26);
}

function pajamaDeleteAndAdd(arg0)
{
    var _pajamaIndex = ds_list_find_index(global.unlockedAbilityList, arg0);
    
    if (_pajamaIndex != -1)
    {
        ds_list_delete(global.unlockedAbilityList, _pajamaIndex);
        ds_list_add(global.unlockedAbilityList, arg0);
    }
}
