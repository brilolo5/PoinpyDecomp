function orderRandomize(arg0)
{
    var _orderRandomizeIndex = arg0;
    var _tempGrid;
    
    while (true)
    {
        orderRatioList = ds_list_create();
        ds_list_clear(global.bannedFruitList);
        var _difficulty = global.difficultyLevel;
        fillerAmount = 0;
        var _orderSpecification = UnknownEnum.Value_0;
        var orListRandomList = setRecipeFormat(_difficulty);
        orderRandomizeMap = ds_map_create();
        var _fruitCycleGridSize = ds_grid_height(global.fruitRandomSpawnGrid);
        var _fruitCycleGridBannedAmount = ds_grid_get_sum(global.fruitRandomSpawnGrid, UnknownEnum.Value_2, 0, UnknownEnum.Value_2, _fruitCycleGridSize - 1);
        var _fruitCycleRandomTo = _fruitCycleGridSize - _fruitCycleGridBannedAmount - 1;
        ds_grid_sort(global.fruitRandomSpawnGrid, UnknownEnum.Value_2, true);
        var orderRatioSize = ds_list_size(orListRandomList);
        var i = 0;
        
        repeat (orderRatioSize)
        {
            var randomFruit = global.fruitRandomSpawnGrid[# UnknownEnum.Value_0, irandom(_fruitCycleRandomTo)];
            
            while (ds_map_exists(orderRandomizeMap, randomFruit))
            {
                randomFruit = global.fruitRandomSpawnGrid[# UnknownEnum.Value_0, irandom(_fruitCycleRandomTo)];
                
                if (orderRatioSize > ds_grid_height(global.fruitRandomSpawnGrid))
                    break;
            }
            
            orderRandomizeMap[? randomFruit] = orListRandomList[| i];
            i += 1;
        }
        
        ds_list_destroy(orderRatioList);
        var ormSize = ds_map_size(orderRandomizeMap);
        var ormIndex = ds_map_find_first(orderRandomizeMap);
        
        if (fillerAmount > 0)
            ormSize += 1;
        
        _tempGrid = ds_grid_create(comboGridWidth, ormSize);
        var _gridIndex = 0;
        
        repeat (ormSize)
        {
            _tempGrid[# UnknownEnum.Value_0, _gridIndex] = ormIndex;
            _tempGrid[# UnknownEnum.Value_1, _gridIndex] = orderRandomizeMap[? ormIndex];
            _tempGrid[# UnknownEnum.Value_3, _gridIndex] = 0;
            _tempGrid[# UnknownEnum.Value_4, _gridIndex] = _orderSpecification;
            ormIndex = ds_map_find_next(orderRandomizeMap, ormIndex);
            _gridIndex += 1;
        }
        
        if (fillerAmount > 0)
        {
            _gridIndex -= 1;
            _tempGrid[# UnknownEnum.Value_0, _gridIndex] = UnknownEnum.Value_38;
            _tempGrid[# UnknownEnum.Value_1, _gridIndex] = fillerAmount;
            _tempGrid[# UnknownEnum.Value_3, _gridIndex] = 0;
            _tempGrid[# UnknownEnum.Value_4, _gridIndex] = UnknownEnum.Value_4;
        }
        
        ds_map_destroy(orderRandomizeMap);
        var _notSame = 0;
        var _sc_prvGridHeight = ds_grid_height(_orderRandomizeIndex);
        var _sc_nextGridHeight = ds_grid_height(_tempGrid);
        var _sc_gridWidth = comboGridWidth;
        ds_grid_sort(_tempGrid, UnknownEnum.Value_1, false);
        ds_grid_sort(_tempGrid, UnknownEnum.Value_4, false);
        ds_grid_sort(_orderRandomizeIndex, UnknownEnum.Value_1, false);
        ds_grid_sort(_orderRandomizeIndex, UnknownEnum.Value_4, false);
        
        for (i = 0; i < _sc_nextGridHeight; i += 1)
        {
            for (var t = 0; t < _sc_gridWidth; t += 1)
            {
                if (_orderRandomizeIndex[# i, t] != _tempGrid[# i, t])
                {
                    _notSame = 1;
                    break;
                }
            }
            
            if (_notSame)
                break;
        }
        
        if (_notSame)
            break;
        
        break;
    }
    
    ds_grid_copy(_orderRandomizeIndex, _tempGrid);
    ds_grid_destroy(_tempGrid);
    global.orderChecklistFilled = 0;
}
