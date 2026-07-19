function orderCheck(arg0, arg1)
{
    var _orderIndex = arg0;
    var _checkingGridIndex = arg1;
    var _orderHeight = ds_grid_height(_orderIndex);
    var _orderCheckIndex = 0;
    var _orderCheckApproveAmount = 0;
    
    repeat (_orderHeight)
    {
        switch (_orderIndex[# UnknownEnum.Value_4, _orderCheckIndex])
        {
            case UnknownEnum.Value_0:
                var _orderInclude_fruitType = _orderIndex[# UnknownEnum.Value_0, _orderCheckIndex];
                var _orderInclude_amount = _orderIndex[# UnknownEnum.Value_1, _orderCheckIndex];
                var _comboHeight = ds_grid_height(_checkingGridIndex);
                
                if (ds_grid_value_exists(_checkingGridIndex, UnknownEnum.Value_0, 0, UnknownEnum.Value_0, _comboHeight - 1, _orderInclude_fruitType))
                {
                    var _comboCheck_ypos = ds_grid_value_y(_checkingGridIndex, UnknownEnum.Value_0, 0, UnknownEnum.Value_0, _comboHeight - 1, _orderInclude_fruitType);
                    
                    if (_checkingGridIndex[# UnknownEnum.Value_1, _comboCheck_ypos] >= _orderInclude_amount)
                        _orderCheckApproveAmount += 1;
                }
                
                break;
            
            case UnknownEnum.Value_1:
                break;
            
            case UnknownEnum.Value_2:
                _orderInclude_fruitType = _orderIndex[# UnknownEnum.Value_0, _orderCheckIndex];
                _orderInclude_amount = _orderIndex[# UnknownEnum.Value_1, _orderCheckIndex];
                _comboHeight = ds_grid_height(_checkingGridIndex);
                
                if (ds_grid_value_exists(_checkingGridIndex, UnknownEnum.Value_0, 0, UnknownEnum.Value_0, _comboHeight - 1, _orderInclude_fruitType))
                {
                    var _comboCheck_ypos = ds_grid_value_y(_checkingGridIndex, UnknownEnum.Value_0, 0, UnknownEnum.Value_0, _comboHeight - 1, _orderInclude_fruitType);
                    
                    if (_checkingGridIndex[# UnknownEnum.Value_1, _comboCheck_ypos] == _orderInclude_amount)
                    {
                        if (_comboHeight == _orderHeight)
                            _orderCheckApproveAmount += 1;
                    }
                }
                
                break;
            
            case UnknownEnum.Value_3:
                _orderInclude_fruitType = _orderIndex[# UnknownEnum.Value_0, _orderCheckIndex];
                _orderInclude_amount = _orderIndex[# UnknownEnum.Value_1, _orderCheckIndex];
                _comboHeight = ds_grid_height(_checkingGridIndex);
                
                if (ds_grid_value_exists(_checkingGridIndex, UnknownEnum.Value_0, 0, UnknownEnum.Value_0, _comboHeight - 1, _orderInclude_fruitType))
                {
                    var _comboCheck_ypos = ds_grid_value_y(_checkingGridIndex, UnknownEnum.Value_0, 0, UnknownEnum.Value_0, _comboHeight - 1, _orderInclude_fruitType);
                    
                    if (_checkingGridIndex[# UnknownEnum.Value_1, _comboCheck_ypos] >= _orderInclude_amount)
                    {
                        if (_comboHeight == _orderHeight)
                            _orderCheckApproveAmount += 1;
                    }
                }
                
                break;
            
            case UnknownEnum.Value_4:
                var _orderBunch_amount = _orderIndex[# UnknownEnum.Value_1, _orderCheckIndex];
                _comboHeight = ds_grid_height(_checkingGridIndex);
                var _comboTotalFruit = ds_grid_get_sum(_checkingGridIndex, UnknownEnum.Value_1, 0, UnknownEnum.Value_1, _comboHeight - 1);
                _orderHeight = ds_grid_height(_orderIndex);
                var _totalFruitInOrderList = ds_grid_get_sum(_orderIndex, UnknownEnum.Value_1, 0, UnknownEnum.Value_1, _orderHeight - 1) - _orderBunch_amount;
                _comboTotalFruit -= _totalFruitInOrderList;
                
                if (_comboTotalFruit >= _orderBunch_amount)
                    _orderCheckApproveAmount += 1;
                
                break;
        }
        
        _orderCheckIndex += 1;
    }
    
    if (_orderCheckApproveAmount >= _orderHeight)
        return true;
}

function orderDebugGetAllFruit(arg0, arg1)
{
    var _orderIndex = arg0;
    var _checkingGridIndex = arg1;
    var _orderHeight = ds_grid_height(_orderIndex);
    var _orderCheckIndex = 0;
    var _orderCheckApproveAmount = 0;
    
    repeat (_orderHeight)
    {
        switch (_orderIndex[# UnknownEnum.Value_4, _orderCheckIndex])
        {
            case UnknownEnum.Value_0:
                var _orderInclude_fruitType = _orderIndex[# UnknownEnum.Value_0, _orderCheckIndex];
                var _orderInclude_amount = _orderIndex[# UnknownEnum.Value_1, _orderCheckIndex];
                
                with (oPlayer)
                {
                    repeat (_orderInclude_amount)
                        gainComboElement(getFruitSprite(_orderInclude_fruitType), _orderInclude_fruitType, 0);
                }
                
                break;
            
            case UnknownEnum.Value_4:
                var _orderBunch_amount = _orderIndex[# UnknownEnum.Value_1, _orderCheckIndex];
                
                with (oPlayer)
                {
                    repeat (_orderBunch_amount)
                        gainComboElement(getFruitSprite(UnknownEnum.Value_24), UnknownEnum.Value_24, 0);
                }
                
                break;
        }
        
        _orderCheckIndex += 1;
    }
    
    if (_orderCheckApproveAmount >= _orderHeight)
        return true;
}
