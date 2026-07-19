function gainComboElement(arg0, arg1, arg2)
{
    var _comboElementToGain = arg0;
    var _comboElementType = arg1;
    var _comboGolden = arg2;
    tempScore += 1;
    var _bannedCheck = 0;
    var _bannedListSize = ds_list_size(global.bannedFruitList);
    
    if (_bannedListSize)
    {
        for (var i = 0; i < _bannedListSize; i += 1)
        {
            if (_comboElementType == global.bannedFruitList[| i])
                _bannedCheck = 1;
        }
    }
    
    if (_comboGolden && abilityCheck(UnknownEnum.Value_10) && !_bannedCheck)
    {
        playSoundAbilityInstantMoney();
        _comboGolden = 3;
    }
    
    if (_bannedCheck && fruitBanIsActive())
    {
        if (damageInvincibility || oPlayer.currentState == "invincible spin jump" || oPlayer.currentState == "slamming - invincible" || oPlayer.currentState == "dead")
        {
        }
        else
        {
            playerComboLoss();
            addHitStop(0);
            screenShake(4, 4);
            selfShake = 8;
            selfShakeAmount = 5;
            timeScaleChange(0, 12, 1);
            timeScaleChange(0.5, 13, 1);
            timeScaleChange(1, 20, 0.015);
        }
    }
    else if (ds_grid_height(global.comboGrid) > 0)
    {
        if (ds_grid_value_exists(global.comboGrid, UnknownEnum.Value_0, 0, UnknownEnum.Value_0, ds_grid_height(global.comboGrid) - 1, _comboElementType))
        {
            var _duplicateFruit_y = ds_grid_value_y(global.comboGrid, UnknownEnum.Value_0, 0, UnknownEnum.Value_0, ds_grid_height(global.comboGrid) - 1, _comboElementType);
            ds_grid_add(global.comboGrid, UnknownEnum.Value_1, _duplicateFruit_y, 1);
            ds_grid_add(global.comboGrid, UnknownEnum.Value_2, _duplicateFruit_y, _comboGolden);
        }
        else
        {
            var dsGridHeight = ds_grid_height(global.comboGrid);
            ds_grid_resize(global.comboGrid, comboGridWidth, dsGridHeight + 1);
            global.comboGrid[# UnknownEnum.Value_0, dsGridHeight] = _comboElementType;
            global.comboGrid[# UnknownEnum.Value_1, dsGridHeight] = 1;
            global.comboGrid[# UnknownEnum.Value_2, dsGridHeight] = _comboGolden;
        }
        
        ds_grid_sort(global.comboGrid, UnknownEnum.Value_1, false);
    }
    else
    {
        ds_grid_resize(global.comboGrid, comboGridWidth, 1);
        global.comboGrid[# UnknownEnum.Value_0, 0] = _comboElementType;
        global.comboGrid[# UnknownEnum.Value_1, 0] = 1;
        global.comboGrid[# UnknownEnum.Value_2, 0] = _comboGolden;
    }
    
    with (oOrderControl)
    {
        bonusAnimationTween = 1;
        
        if (recipeMismatchSequence)
        {
            ds_grid_set_region(recipeDataGrid, UnknownEnum.Value_3, 0, UnknownEnum.Value_3, ds_grid_height(recipeDataGrid) - 1, 0);
            recipeMismatchSequence = 0;
            recipeMismatchSequenceTimer = recipeMismatchSequenceTimerDefault;
            recipeMismatchAnimcurvePos = 0;
        }
    }
    
    orderChecklistUpdate();
    return !(_bannedCheck && fruitBanIsActive());
}
