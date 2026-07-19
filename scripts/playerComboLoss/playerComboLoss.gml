function playerComboLoss()
{
    if (instance_exists(oBeastMainGame) && oBeastMainGame.beastGameState == "ready")
        beastGameStateChange("waiting");
    
    var _totalTypes = ds_grid_height(global.comboGrid);
    var comboElementRecordDrawSpaceInbetween = 8;
    var comboElementMultipleSpaceInbetween = 8;
    var _drawx = lerp(comboUI_x, x + dcx, 0.3 * global.timeScale);
    var _drawy = lerp(comboUI_y, y + dcy, 0.5 * global.timeScale);
    var _playerPosXDifference = ((x + cx) - _drawx) / 2;
    var _playerPosYDifference = ((y + cy) - _drawy) / 4;
    
    if (_totalTypes > 0)
        playSfxWorld(sfx_player_fruit_drop, false, true);
    
    for (var i = 0; i < _totalTypes; i += 1)
    {
        var _typeOfFruit = global.comboGrid[# UnknownEnum.Value_0, i];
        var _fruitSprite = getFruitSprite(_typeOfFruit);
        var _numOfFruitsInType = global.comboGrid[# UnknownEnum.Value_1, i];
        
        for (var t = 0; t < _numOfFruitsInType; t += 1)
        {
            var _effectSpawnx = (_drawx - ((_numOfFruitsInType - 1) * (comboElementRecordDrawSpaceInbetween / 2))) + (t * comboElementRecordDrawSpaceInbetween) + (_playerPosXDifference * (i - 1));
            var _effectSpawny = ((_drawy + 12 + (_totalTypes * comboElementMultipleSpaceInbetween)) - (i * comboElementMultipleSpaceInbetween)) + (_playerPosYDifference * (i - 1));
            
            with (instance_create_depth(_effectSpawnx, _effectSpawny, depth, effectScatterFailFruit))
                sprite_index = _fruitSprite;
        }
    }
    
    ds_grid_resize(global.comboGrid, comboGridWidth, 0);
    ds_grid_clear(global.comboGrid, -1);
    
    with (oOrderControl)
    {
        recipeMismatchSequence = 1;
        global.orderChecklistFilled = 0;
    }
}
