function getAreaDiscoveryThreshold(arg0 = 0)
{
    var _areaUnlockThreshold = -1;
    
    if (ds_list_size(global.areaUnlockedList) <= 3)
    {
        _areaUnlockThreshold = global.areaUnlockThreshold[ds_list_size(global.areaUnlockedList)];
        
        if (ds_list_find_index(global.areaUnlockedList, UnknownEnum.Value_1) != -1)
            _areaUnlockThreshold = global.areaUnlockThreshold[0];
    }
    
    if (arg0)
        _areaUnlockThreshold = global.areaUnlockThreshold[ds_list_size(global.areaUnlockedList) - 1];
    
    return _areaUnlockThreshold;
}
