function orderChecklistUpdate()
{
    with (oOrderControl)
    {
        var _orderList = recipeDataGrid;
        var _comboGridHeight = ds_grid_height(global.comboGrid);
        var _orderListHeight = ds_grid_height(_orderList);
        var _numOfCompletedOrder = 0;
        
        for (i = 0; i <= _comboGridHeight; i += 1)
        {
            var _comboGridFruit = global.comboGrid[# UnknownEnum.Value_0, i];
            
            if (ds_grid_value_exists(_orderList, UnknownEnum.Value_0, 0, UnknownEnum.Value_0, _orderListHeight - 1, _comboGridFruit))
            {
                var _posy = ds_grid_value_y(_orderList, UnknownEnum.Value_0, 0, UnknownEnum.Value_0, _orderListHeight - 1, _comboGridFruit);
                var _posyComboGrid = ds_grid_value_y(global.comboGrid, UnknownEnum.Value_0, 0, UnknownEnum.Value_0, ds_grid_height(global.comboGrid), _comboGridFruit);
                var _valueComboGrid = global.comboGrid[# UnknownEnum.Value_1, _posyComboGrid];
                _orderList[# UnknownEnum.Value_3, _posy] = _valueComboGrid;
            }
        }
        
        if (orderCheck(recipeDataGrid, global.comboGrid))
        {
            if (!global.orderChecklistFilled)
            {
                playSoundRecipeReady();
                global.orderChecklistFilled = 1;
                beastGameStateChange("ready");
            }
        }
        else
        {
            global.orderChecklistFilled = 0;
        }
        
        with (oPlayer)
            checkSlamFruitSquash();
    }
}
