function addBannedFruit(arg0, arg1)
{
    var _fruitTempList = arg0;
    var _repeatNum = arg1;
    var _listSize = ds_list_size(_fruitTempList);
    
    repeat (_repeatNum)
    {
        while (true)
        {
            var _randPick = irandom(_listSize - 1);
            
            if (ds_list_find_index(global.bannedFruitList, _fruitTempList[| _randPick]) == -1)
            {
                ds_list_add(global.bannedFruitList, _fruitTempList[| _randPick]);
                break;
            }
            else
            {
            }
        }
    }
}
