var _count = 0;

repeat (100)
{
    var _points = irandom_range(0, 999);
    var _abilityArray = array_create(6, -1);
    var _i = 0;
    
    repeat (6)
    {
        array_set(_abilityArray, _i, irandom_range(-1, 31));
        _i++;
    }
    
    var _packed = scoreSquishPackSingle(_points, _abilityArray);
    var _unpackedStruct = scoreSquishUnpackSingle(_packed);
    
    if (_unpackedStruct.points != _points || !array_equals(_abilityArray, _unpackedStruct.abilityArray))
        trace("Failure! ", _points, " ", _abilityArray, "  !=  ", _unpackedStruct.points, " ", _unpackedStruct.abilityArray);
    
    if ((_count % 1000) == 0)
        trace(_count);
    
    _count++;
}

_count = 0;

repeat (100)
{
    var _historicList = ds_list_create();
    var _historicString = "";
    
    repeat (4)
    {
        var _score = irandom_range(0, 999);
        _historicString += (string(_score) + ", ");
        ds_list_add(_historicList, _score);
    }
    
    var _packed = scoreSquishPackAverage(_historicList);
    var _unpackedStruct = scoreSquishUnpackAverage(_packed);
    
    if (_unpackedStruct.historicArray[0] != _historicList[| 0] || _unpackedStruct.historicArray[1] != _historicList[| 1] || _unpackedStruct.historicArray[2] != _historicList[| 2] || _unpackedStruct.historicArray[3] != _historicList[| 3])
        trace("Failure! ", _historicString, "  !=  ", _unpackedStruct.historicArray);
    
    if ((_count % 1000) == 0)
        trace(_count);
    
    ds_list_destroy(_historicList);
    _count++;
}
