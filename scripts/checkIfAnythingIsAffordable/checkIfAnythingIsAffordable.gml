function checkIfAnythingIsAffordable()
{
    var _itemList = upgradeItemList();
    var affordCheck = 0;
    i = 0;
    
    repeat (ds_grid_height(_itemList))
    {
        var _itemLevel = 0;
        var _itemLevelMax = _itemList[# UnknownEnum.Value_5, i];
        draw_set_color(make_color_rgb(46, 50, 59));
        var _itemCost;
        
        if (_itemLevel < _itemLevelMax)
            _itemCost = itemCost[_itemLevel][i];
        else
            _itemCost = 99999;
        
        var _canAfford = (global.moneyJar >= _itemCost) ? true : false;
        
        if (_canAfford)
        {
            affordCheck = 1;
        }
        else
        {
        }
        
        i += 1;
    }
    
    ds_grid_destroy(_itemList);
    
    if (affordCheck > 0)
        return 1;
    else
        return -1;
}
