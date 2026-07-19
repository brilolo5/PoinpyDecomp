var _listHeight = ds_list_size(global.bannedFruitList);

if (_listHeight > 0)
{
    fruitType = global.bannedFruitList[| 0];
    sprIndex = getFruitSprite(fruitType);
}
