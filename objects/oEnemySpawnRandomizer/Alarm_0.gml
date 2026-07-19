instance_activate_object(parentEnemy);
instance_activate_object(oPot);
instance_activate_object(oTouchTimerSpawner);
var enemyRandomizerList = ds_list_create();
var _isPot = 0;
var _isFruitHandler = 0;

while (true)
{
    var _enemyId = instance_place(x, y, parentEnemy);
    
    if (!_enemyId)
    {
        _enemyId = instance_place(x, y, oPot);
        
        if (_enemyId != -4)
        {
            if (abilityCheck(UnknownEnum.Value_18))
                _isPot = 1;
        }
        else if (!_enemyId)
        {
            break;
        }
    }
    
    var _enemyObjIndex = _enemyId.object_index;
    
    if (_enemyObjIndex == 208 && abilityCheck(UnknownEnum.Value_21))
        _isFruitHandler = 1;
    
    ds_list_add(enemyRandomizerList, ds_map_create());
    var _listSize = ds_list_size(enemyRandomizerList) - 1;
    ds_list_mark_as_map(enemyRandomizerList, _listSize);
    ds_map_add(enemyRandomizerList[| _listSize], "enemyIndex", _enemyObjIndex);
    ds_map_add(enemyRandomizerList[| _listSize], "x", _enemyId.x);
    ds_map_add(enemyRandomizerList[| _listSize], "y", _enemyId.y);
    
    if (_isPot || _isFruitHandler)
    {
        repeat (10)
        {
            ds_list_add(enemyRandomizerList, ds_map_create());
            _listSize = ds_list_size(enemyRandomizerList) - 1;
            ds_list_mark_as_map(enemyRandomizerList, _listSize);
            ds_map_add(enemyRandomizerList[| _listSize], "enemyIndex", _enemyObjIndex);
            ds_map_add(enemyRandomizerList[| _listSize], "x", _enemyId.x);
            ds_map_add(enemyRandomizerList[| _listSize], "y", _enemyId.y);
            show_debug_message("randomizer: added " + string(object_get_name(_enemyObjIndex)));
        }
        
        _isPot = 0;
        _isFruitHandler = 0;
    }
    
    with (_enemyId)
        instance_destroy();
}

if (ds_list_size(enemyRandomizerList))
{
    ds_list_shuffle(enemyRandomizerList);
    var _randomEnemy = enemyRandomizerList[| 0];
    var _spawnx = _randomEnemy[? "x"];
    var _spawny = _randomEnemy[? "y"];
    var _spawnIndex = _randomEnemy[? "enemyIndex"];
    instance_create_depth(_spawnx, _spawny, depth, _spawnIndex);
}

ds_list_destroy(enemyRandomizerList);
instance_destroy();
