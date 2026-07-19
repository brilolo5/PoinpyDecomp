function areaDiscoveryCheck()
{
    for (var i = 0; i < discoveryListEntries; i += 1)
    {
        if (global.difficultyLevel >= discoveryList[i][UnknownEnum.Value_0])
        {
            var _discoveringAreaIndex = discoveryList[i][UnknownEnum.Value_1];
            
            if (ds_list_find_index(global.areaUnlockedList, _discoveringAreaIndex) == -1)
            {
                var _beginnerCheck = ds_list_find_index(global.areaUnlockedList, UnknownEnum.Value_1);
                
                if (_beginnerCheck != -1)
                    ds_list_delete(global.areaUnlockedList, _beginnerCheck);
                
                _beginnerCheck = ds_list_find_index(global.areaOrderList, UnknownEnum.Value_1);
                
                if (_beginnerCheck != -1)
                    ds_list_delete(global.areaOrderList, _beginnerCheck);
                
                ds_list_add(global.areaUnlockedList, _discoveringAreaIndex);
                return _discoveringAreaIndex;
            }
        }
        else
        {
            return false;
        }
    }
    
    return false;
}
