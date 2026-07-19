event_inherited();
tut_timerActive = 0;
tut_angerActive = 0;
tut_juiceSuccess = 0;
tut_juiceSuccessCount = 0;
destroy = 0;

function tut_orderRandomize(arg0)
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
        tut_setRecipeFormat(_difficulty);
        orderRandomizeMap = ds_map_create();
        var orListSize = ds_list_size(orderRatioList) - 1;
        
        if (orListSize >= 0)
        {
            var orListRandomIndex = irandom(orListSize);
            var orListRandomList = orderRatioList[| orListRandomIndex];
            
            if (ds_list_size(global.bannedFruitList) > 0)
            {
                var _fruitListSize = ds_grid_height(global.fruitRandomSpawnGrid) - 1;
                var _orderRatioSize = ds_list_size(orListRandomList) - 1;
                
                while (_fruitListSize == _orderRatioSize)
                {
                    orListSize = ds_list_size(orderRatioList) - 1;
                    orListRandomIndex = irandom(orListSize);
                    orListRandomList = orderRatioList[| orListRandomIndex];
                    _orderRatioSize = ds_list_size(orListRandomList) - 1;
                }
            }
            
            var _fruitCycleGridSize = ds_grid_height(global.fruitRandomSpawnGrid);
            var _fruitCycleGridBannedAmount = ds_grid_get_sum(global.fruitRandomSpawnGrid, UnknownEnum.Value_2, 0, UnknownEnum.Value_2, _fruitCycleGridSize - 1);
            var _fruitCycleRandomTo = _fruitCycleGridSize - 1 - _fruitCycleGridBannedAmount;
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
            
            if (_orderSpecification == UnknownEnum.Value_4)
                _tempGrid[# UnknownEnum.Value_0, _gridIndex] = UnknownEnum.Value_38;
            
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
        
        for (var i = 0; i < _sc_nextGridHeight; i += 1)
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

function tut_renewRecipe()
{
    angerTimer = angerTimerMax;
    recipeRiseSequence = 1;
    var listId = recipeDataGrid;
    tut_orderRandomize(listId);
    ds_grid_sort(listId, UnknownEnum.Value_1, -1);
    orderChecklistUpdate();
}

function tut_setRecipeFormat(arg0)
{
    var _difficulty = arg0;
    var _orderSpecification = UnknownEnum.Value_0;
    var _fruitTempList = ds_list_create();
    var _baseFruitNum = 1;
    
    switch (_difficulty)
    {
        case 0:
            getFruitList(_fruitTempList, "apples_2");
            _baseFruitNum = 1;
            generateFruitList(_fruitTempList);
            orderRatioGetListOf(_baseFruitNum);
            break;
        
        case 1:
            getFruitList(_fruitTempList, "apples_2");
            _baseFruitNum = 1;
            generateFruitList(_fruitTempList);
            orderRatioGetListOf(_baseFruitNum);
            break;
        
        case 2:
            getFruitList(_fruitTempList, "apples_2");
            _baseFruitNum = 2;
            orderRatioGetListOf(_baseFruitNum);
            generateFruitList(_fruitTempList);
            break;
        
        case 3:
            getFruitList(_fruitTempList, "apples_2");
            _baseFruitNum = 3;
            orderRatioAdd(1, 2);
            generateFruitList(_fruitTempList);
            break;
        
        case 4:
            getFruitList(_fruitTempList, "apples_3");
            _baseFruitNum = _difficulty;
            
            switch (choose(0, 1))
            {
                case 0:
                    orderRatioGetListOf(_baseFruitNum);
                    break;
                
                case 1:
                    fillerAmount = 5;
                    break;
            }
            
            generateFruitList(_fruitTempList);
            break;
        
        case 5:
            getFruitList(_fruitTempList, "apples_3");
            _baseFruitNum = _difficulty;
            
            switch (choose(0, 1))
            {
                case 0:
                    orderRatioAdd(1, 1, 1, 2);
                    orderRatioAdd(3);
                    orderRatioAdd(2, 2, 1);
                    break;
                
                case 1:
                    fillerAmount = _baseFruitNum + 1;
                    break;
            }
            
            generateFruitList(_fruitTempList);
            break;
        
        default:
            getFruitList(_fruitTempList, "apples_9");
            _baseFruitNum = _difficulty;
            
            switch (choose(0, 1, 2))
            {
                case 0:
                    orderRatioAdd(3, 3, 3);
                    orderRatioAdd(4, 4);
                    fillerAmount = 20;
                    break;
                
                case 1:
                    fillerAmount = 40;
                    addBannedFruit(_fruitTempList, 2);
                    break;
                
                case 2:
                    orderRatioAdd(3, 3, 3);
                    orderRatioAdd(3, 4);
                    fillerAmount = 15;
                    addBannedFruit(_fruitTempList, 3);
                    break;
            }
            
            generateFruitList(_fruitTempList);
            break;
    }
    
    ds_list_destroy(_fruitTempList);
}

global.difficultyLevel = 2;
tut_renewRecipe();
