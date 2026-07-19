function upgradeItemList()
{
    itemElementNum = 6;
    itemNum = 3;
    var _itemList = ds_grid_create(itemElementNum, itemNum);
    _itemList[# UnknownEnum.Value_0, UnknownEnum.Value_1] = loc("ugdesc hp name");
    _itemList[# UnknownEnum.Value_1, UnknownEnum.Value_1] = 5;
    _itemList[# UnknownEnum.Value_2, UnknownEnum.Value_1] = UnknownEnum.Value_0;
    _itemList[# UnknownEnum.Value_3, UnknownEnum.Value_1] = loc("ugdesc hp desc");
    _itemList[# UnknownEnum.Value_5, UnknownEnum.Value_1] = 4;
    var _costDefault = 50;
    var _costIncrement = 30;
    var _ugIndex = UnknownEnum.Value_1;
    
    for (var i = 0; i <= 4; i += 1)
        itemCost[i][_ugIndex] = _costDefault + (_costIncrement * i);
    
    _itemList[# UnknownEnum.Value_0, UnknownEnum.Value_0] = loc("ugdesc jump name");
    _itemList[# UnknownEnum.Value_1, UnknownEnum.Value_0] = 10;
    _itemList[# UnknownEnum.Value_2, UnknownEnum.Value_0] = UnknownEnum.Value_4;
    _itemList[# UnknownEnum.Value_3, UnknownEnum.Value_0] = loc("ugdesc jump desc");
    _itemList[# UnknownEnum.Value_5, UnknownEnum.Value_0] = 4;
    _costDefault = 10;
    _costIncrement = 50;
    _ugIndex = UnknownEnum.Value_0;
    
    for (var i = 0; i <= 4; i += 1)
        itemCost[i][_ugIndex] = _costDefault + (_costIncrement * i);
    
    _itemList[# UnknownEnum.Value_0, UnknownEnum.Value_2] = loc("ugdesc wallet name");
    _itemList[# UnknownEnum.Value_1, UnknownEnum.Value_2] = 10;
    _itemList[# UnknownEnum.Value_3, UnknownEnum.Value_2] = loc("ugdesc wallet desc");
    _itemList[# UnknownEnum.Value_5, UnknownEnum.Value_2] = 4;
    _costDefault = 40;
    _costIncrement = 40;
    _ugIndex = UnknownEnum.Value_2;
    
    for (var i = 0; i <= 4; i += 1)
        itemCost[i][_ugIndex] = _costDefault + (_costIncrement * i);
    
    return _itemList;
}
