function get3RandomizedAbility()
{
    var _randomPickedList = ds_list_create();
    
    for (var i = 0; i < UnknownEnum.Value_29; i += 1)
        ds_list_add(_randomPickedList, i);
    
    var _unlockedListSize = ds_list_size(global.unlockedAbilityList);
    
    for (var i = 0; i < _unlockedListSize; i += 1)
    {
        var _unlockedAbilityIndex = global.unlockedAbilityList[| i];
        var _unlockedAbilityInRandomList = ds_list_find_index(_randomPickedList, _unlockedAbilityIndex);
        ds_list_delete(_randomPickedList, _unlockedAbilityInRandomList);
    }
    
    lockItemFromGacha(_randomPickedList, UnknownEnum.Value_22);
    lockItemFromGacha(_randomPickedList, UnknownEnum.Value_23);
    lockItemFromGacha(_randomPickedList, UnknownEnum.Value_24);
    lockItemFromGacha(_randomPickedList, UnknownEnum.Value_25);
    lockItemFromGacha(_randomPickedList, UnknownEnum.Value_26);
    var _randomListSize = ds_list_size(_randomPickedList);
    _randomListSize = clamp(_randomListSize, 0, 3);
    ds_list_shuffle(_randomPickedList);
    var _returnArray;
    
    for (var i = 0; i < _randomListSize; i += 1)
        _returnArray[i] = _randomPickedList[| i];
    
    var _duplicateAbilityCheck = 1;
    
    switch (_unlockedListSize)
    {
        case 0:
            _returnArray[0] = UnknownEnum.Value_1;
            _returnArray[1] = UnknownEnum.Value_4;
            _returnArray[2] = UnknownEnum.Value_27;
            break;
        
        case 1:
            _returnArray[0] = UnknownEnum.Value_14;
            _returnArray[1] = UnknownEnum.Value_20;
            _returnArray[2] = UnknownEnum.Value_17;
            break;
        
        case 2:
            _returnArray[0] = UnknownEnum.Value_0;
            _returnArray[1] = UnknownEnum.Value_15;
            _returnArray[2] = UnknownEnum.Value_16;
            break;
        
        case 3:
            _returnArray[0] = UnknownEnum.Value_5;
            _returnArray[1] = UnknownEnum.Value_7;
            _returnArray[2] = UnknownEnum.Value_9;
            break;
        
        case 4:
            _returnArray[0] = UnknownEnum.Value_13;
            _returnArray[1] = UnknownEnum.Value_19;
            _returnArray[2] = UnknownEnum.Value_8;
            break;
        
        case 5:
            _returnArray[0] = UnknownEnum.Value_2;
            _returnArray[1] = UnknownEnum.Value_6;
            _returnArray[2] = UnknownEnum.Value_11;
            break;
        
        default:
            _duplicateAbilityCheck = 0;
            break;
    }
    
    if (_duplicateAbilityCheck)
    {
        for (var i = 0; i < _randomListSize; i += 1)
        {
            _unlockedListSize = ds_list_size(global.unlockedAbilityList);
            
            for (var t = 0; t < _unlockedListSize; t += 1)
            {
                var _unlockedAbilityIndex = global.unlockedAbilityList[| t];
                
                if (_returnArray[i] == _unlockedAbilityIndex)
                {
                    _returnArray[i] = -1;
                    break;
                }
            }
        }
        
        for (var i = 0; i < _randomListSize; i += 1)
        {
            if (_returnArray[i] == -1)
            {
                array_delete(_returnArray, i, 1);
                _randomListSize -= 1;
                i -= 1;
            }
        }
    }
    
    ds_list_destroy(_randomPickedList);
    
    if (_randomListSize <= 0)
        _returnArray[0] = -1;
    
    return _returnArray;
}

function lockItemFromGacha(arg0, arg1)
{
    var _unlockedAbilityInRandomList = ds_list_find_index(arg0, arg1);
    
    if (_unlockedAbilityInRandomList != -1)
        ds_list_delete(arg0, _unlockedAbilityInRandomList);
}
