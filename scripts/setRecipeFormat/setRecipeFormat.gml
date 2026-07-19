function setRecipeFormat(arg0)
{
    var _difficulty = arg0;
    var _orderSpecification = UnknownEnum.Value_0;
    var _fruitTempList = ds_list_create();
    var _baseFruitNum = 1;
    
    if (global.finalStretchSequence)
    {
        getRecipeFromDifficultyForFinalArea(_difficulty, _fruitTempList);
    }
    else if (!abilityCheck(UnknownEnum.Value_22))
    {
        getRecipeFromDifficulty(_difficulty, _fruitTempList);
    }
    else
    {
        getFruitList(_fruitTempList, "apples_9");
        var _mode = getEndlessMode();
        
        switch (_mode)
        {
            case UnknownEnum.Value_0:
                orderRatioAdd(orFiller(endlessModeMinimumFruitAmount), orBanned(3));
                break;
            
            case UnknownEnum.Value_1:
                orderRatioAdd(orFiller(endlessModeMinimumFruitAmount), orBanned(2));
                break;
            
            case UnknownEnum.Value_2:
                orderRatioAdd(orFiller(endlessModeMinimumFruitAmount), orBanned(1));
                break;
            
            case UnknownEnum.Value_3:
                orderRatioAdd(orFiller(endlessModeMinimumFruitAmount));
                break;
            
            case UnknownEnum.Value_4:
                orderRatioAdd(orFiller(endlessModeMinimumFruitAmount));
                break;
        }
    }
    
    var _orListSize = ds_list_size(orderRatioList) - 1;
    var _randomPick = irandom(_orListSize);
    
    if (!abilityCheck(UnknownEnum.Value_22))
    {
        while (true)
        {
            if (_randomPick != recipePreviousRandomPick)
            {
                recipePreviousRandomPick = _randomPick;
                break;
            }
            
            _randomPick = irandom(_orListSize);
        }
    }
    
    var _orRandomlyPickedList = orderRatioList[| _randomPick];
    ds_list_sort(_orRandomlyPickedList, true);
    
    while (_orRandomlyPickedList[| 0] < 0)
    {
        var _specsValue = _orRandomlyPickedList[| 0];
        
        if (_specsValue < -200)
        {
            var _banAmount = abs(_specsValue + 200);
            addBannedFruit(_fruitTempList, _banAmount);
        }
        else if (_specsValue < -100)
        {
            var _fillAmount = abs(_specsValue + 100);
            fillerAmount = _fillAmount;
        }
        
        ds_list_delete(_orRandomlyPickedList, 0);
    }
    
    generateFruitList(_fruitTempList);
    ds_list_destroy(_fruitTempList);
    return _orRandomlyPickedList;
}
