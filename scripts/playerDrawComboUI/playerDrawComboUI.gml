function playerDrawComboUI(arg0, arg1)
{
    var _drawx = arg0;
    var _drawy = arg1;
    var _totalTypes = ds_grid_height(global.comboGrid);
    
    if (_totalTypes > 0)
    {
        var _totalFruits = ds_grid_get_sum(global.comboGrid, UnknownEnum.Value_1, 0, UnknownEnum.Value_1, _totalTypes);
        var comboElementRecordDrawSpaceInbetween = 8;
        var comboElementMultipleSpaceInbetween = 8;
        var comboElementScale = 0.1;
        var _playerPosXDifference = ((oPlayer.x + cx) - _drawx) / (_totalTypes / 2);
        var _playerPosYDifference = ((oPlayer.y + cy) - _drawy) / 4;
        
        if (currentState == "slamming" && hitStop <= 0)
        {
            _playerPosYDifference = 6;
            _drawy = (y - (_totalTypes * comboElementMultipleSpaceInbetween)) + 8;
        }
        
        var _totalGold = 0;
        var i = 0;
        var t = 0;
        
        repeat (_totalTypes)
        {
            var _fruitsInType = global.comboGrid[# UnknownEnum.Value_1, t];
            var _goldenInType = global.comboGrid[# UnknownEnum.Value_2, t];
            _totalGold += _goldenInType;
            t += 1;
        }
        
        var _fruitOffsetForGold = sign(_totalGold) * comboElementMultipleSpaceInbetween;
        i = 0;
        t = 0;
        
        repeat (_totalTypes)
        {
            var _fruitsInType = global.comboGrid[# UnknownEnum.Value_1, t];
            var comboElementSprite = getFruitSprite(global.comboGrid[# UnknownEnum.Value_0, t]);
            i = 0;
            
            repeat (_fruitsInType)
            {
                var comboElementRecordDrawPosx = (_drawx - ((_fruitsInType - 1) * (comboElementRecordDrawSpaceInbetween / 2))) + (i * comboElementRecordDrawSpaceInbetween) + (_playerPosXDifference * (t - (_totalTypes / 2)));
                var comboElementRecordDrawPosy = ((_drawy + 12 + _fruitOffsetForGold + (_totalTypes * comboElementMultipleSpaceInbetween)) - (t * comboElementMultipleSpaceInbetween)) + (_playerPosYDifference * (t - 1));
                draw_sprite_ext(comboElementSprite, 2, comboElementRecordDrawPosx, comboElementRecordDrawPosy, comboElementScale, comboElementScale, 0, c_white, 1);
                i += 1;
            }
            
            t += 1;
        }
        
        if (_totalFruits < comboLimit)
            var comboElementTotalTextColor = 16777215;
        else
            comboElementTotalTextColor = make_color_rgb(232, 134, 170);
        
        var comboElementTotalDrawPosy = _drawy + 16 + ((_totalTypes + 1) * comboElementMultipleSpaceInbetween);
        drawSetAlign(1, 1);
        
        if (_totalGold > 0)
        {
            var _goldTextSize = 0.4;
            var _goldDrawx = _drawx + 2 + (_playerPosXDifference * (_totalTypes - (_totalTypes / 2)));
            var _goldDrawy = _drawy + 16 + 2 + (_playerPosYDifference * (_totalTypes - 1));
            var _str = "[scale,0.125][sGoldenSeedUI,1]    [/scale][cycle,32,42]" + string(_totalGold);
            _str = "[cycle,32,42]" + string(_totalGold) + "[scale,0.125][sGoldenSeedUI,1]    [/scale]";
            scribble(_str).starting_format(locGetNumFont(), make_color_rgb(255, 255, 255)).align(1, 1).blend(16777215, 1).msdf_border(make_color_rgb(46, 50, 59), 3).transform(_goldTextSize, _goldTextSize, 0).draw(_goldDrawx, _goldDrawy);
        }
        
        if (global.orderChecklistFilled && instance_exists(oOrderControl))
        {
            var _excessFruitCount = getExcessFruitCount();
            var _multiplierText = "" + string(_excessFruitCount);
            
            if (_excessFruitCount > 0)
            {
            }
        }
    }
}

function getExcessFruitCount()
{
    var _totalTypesInOrder = ds_grid_height(oOrderControl.recipeDataGrid);
    var _totalFruitsInOrder = ds_grid_get_sum(oOrderControl.recipeDataGrid, UnknownEnum.Value_1, 0, UnknownEnum.Value_1, _totalTypesInOrder);
    var _totalTypes = ds_grid_height(global.comboGrid);
    var _totalFruits = ds_grid_get_sum(global.comboGrid, UnknownEnum.Value_1, 0, UnknownEnum.Value_1, _totalTypes);
    var _excessFruits = _totalFruits - _totalFruitsInOrder;
    var _multiplier = _excessFruits;
    
    if (abilityCheck(UnknownEnum.Value_22))
        _multiplier += oOrderControl.endlessModeMinimumFruitAmount;
    
    _multiplier = clamp(_multiplier, 0, 999);
    return _multiplier;
}

function drawExtraBonus(arg0, arg1, arg2)
{
    extraBonusTween = max(0, extraBonusTween - 0.1111111111111111);
    arg1 -= 4;
    var _fontScale = 0.4;
    var _bonusTextScale = _fontScale * (1 + (extraBonusTween * 0.5));
    var _bonusTextAngle = 5 * extraBonusTween;
    scribble(arg2).msdf_shadow(make_color_rgb(46, 50, 59), 1, 0, 2).line_height(0, 23).starting_format(locGetNumFont(false), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 3).wrap(128, -1, locIsAsian()).transform(_bonusTextScale, _bonusTextScale, _bonusTextAngle).align(1, 1).draw(arg0, arg1 + 2);
    _fontScale = 0.2857142857142857;
    var _extraBonusString = loc("main game UI extra bonus");
    scribble("[cycle,32,43]" + _extraBonusString).msdf_shadow(make_color_rgb(46, 50, 59), 1, 0, 2).line_height(0, 23).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 3).wrap(128, -1, locIsAsian()).transform(_fontScale, _fontScale, 0).align(1, 0).draw(arg0, arg1 + 10);
}
