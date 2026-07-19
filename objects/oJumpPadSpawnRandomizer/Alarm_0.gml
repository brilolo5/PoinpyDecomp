instance_activate_object(oGimJumpPad);
var enemyRandomizerList = ds_list_create();

while (true)
{
    var _enemyId = instance_place(x, y, oGimJumpPad);
    
    if (!_enemyId)
        break;
    
    var _enemyObjIndex = _enemyId.object_index;
    ds_list_add(enemyRandomizerList, ds_map_create());
    var _listSize = ds_list_size(enemyRandomizerList) - 1;
    ds_list_mark_as_map(enemyRandomizerList, _listSize);
    ds_map_add(enemyRandomizerList[| _listSize], "enemyIndex", _enemyObjIndex);
    ds_map_add(enemyRandomizerList[| _listSize], "x", _enemyId.x);
    ds_map_add(enemyRandomizerList[| _listSize], "y", _enemyId.y);
    
    with (_enemyId)
        instance_destroy();
}

if (ds_list_size(enemyRandomizerList))
{
    ds_list_shuffle(enemyRandomizerList);
    
    for (var i = 0; i < jumpPadsToSpawn; i += 1)
    {
        var _randomEnemy = enemyRandomizerList[| i];
        var _spawnx = _randomEnemy[? "x"];
        var _spawny = _randomEnemy[? "y"];
        var _spawnIndex = _randomEnemy[? "enemyIndex"];
        
        with (instance_create_depth(_spawnx, _spawny, depth, _spawnIndex))
        {
            padAngle = i;
            
            if (padAngle == 2)
                padAngle = choose(0, 1);
            
            switch (padAngle)
            {
                case 0:
                    padSpriteIndex = sJumpPadHigh;
                    break;
                
                case 1:
                    padSpriteIndex = sJumpPadLow;
                    break;
            }
        }
    }
}

ds_list_destroy(enemyRandomizerList);
instance_destroy();
