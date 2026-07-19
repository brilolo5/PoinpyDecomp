function generateFruitList(arg0)
{
    var fruitRandomSpawnList = arg0;
    var _fruitListSize = ds_list_size(fruitRandomSpawnList);
    var _cycleElementNum = UnknownEnum.Value_3;
    
    if (!ds_exists(global.fruitRandomSpawnGrid, ds_type_grid))
    {
        global.fruitRandomSpawnGrid = ds_grid_create(_cycleElementNum, _fruitListSize);
    }
    else
    {
        ds_grid_resize(global.fruitRandomSpawnGrid, _cycleElementNum, _fruitListSize);
        ds_grid_clear(global.fruitRandomSpawnGrid, -1);
    }
    
    var _index = 0;
    var _bannedFruitList = ds_list_size(global.bannedFruitList);
    
    repeat (ds_list_size(fruitRandomSpawnList))
    {
        global.fruitRandomSpawnGrid[# UnknownEnum.Value_0, _index] = fruitRandomSpawnList[| _index];
        global.fruitRandomSpawnGrid[# UnknownEnum.Value_1, _index] = 0;
        global.fruitRandomSpawnGrid[# UnknownEnum.Value_2, _index] = 0;
        
        if (_bannedFruitList)
        {
            for (var i = 0; i < _bannedFruitList; i += 1)
            {
                if (fruitRandomSpawnList[| _index] == global.bannedFruitList[| i])
                    global.fruitRandomSpawnGrid[# UnknownEnum.Value_2, _index] = 1;
            }
        }
        
        _index += 1;
    }
    
    ds_grid_set_region(global.fruitRandomSpawnGrid, UnknownEnum.Value_1, 0, UnknownEnum.Value_1, ds_grid_height(global.fruitRandomSpawnGrid) - 1, 0);
}
