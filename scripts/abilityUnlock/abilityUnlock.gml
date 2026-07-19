function abilityUnlock(arg0)
{
    if (ds_list_find_index(global.unlockedAbilityList, arg0) == -1)
        ds_list_add(global.unlockedAbilityList, arg0);
}
