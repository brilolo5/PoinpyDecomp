set = 0;
growth = 0;
fruitMaxCount = 5;
alarm[0] = 1;

function growTutFruit()
{
    if (set)
    {
        var _fruitCount = 0;
        
        while (true)
        {
            show_debug_message("counting fruit");
            var _fruitInArea = instance_place(x, y, oFruit);
            
            if (_fruitInArea)
            {
                _fruitCount += 1;
                instance_deactivate_object(_fruitInArea);
            }
            else
            {
                break;
            }
        }
        
        instance_activate_object(oFruit);
        var _generateNum = fruitMaxCount - _fruitCount;
        
        repeat (_generateNum)
        {
            show_debug_message("generating fruit");
            var _posx, _posy;
            
            while (true)
            {
                var _randomFruitNum = irandom(fruitPositionCount - 1);
                _posx = fruitPositionArray[_randomFruitNum][0];
                _posy = fruitPositionArray[_randomFruitNum][1];
                
                if (!position_meeting(_posx, _posy, oFruit))
                    break;
                
                show_debug_message("while loop" + string(_randomFruitNum) + "," + string(_posx) + "," + string(_posy));
            }
            
            var _newFruit = instance_create_depth(_posx, _posy, 0, oFruit);
            _newFruit.golden = 0;
            _newFruit.fruitType = UnknownEnum.Value_4;
            _newFruit.fruitType = fruitRandomizeEvenly();
            _newFruit.fruitSet = 1;
            _newFruit.sprIndex = getFruitSprite(_newFruit.fruitType);
            generateEffect(_posx, _posy, "temp white flash", 0);
        }
    }
}

function fruitRandomizeEvenly()
{
    var _appleCount = 0;
    var _mangosCount = 0;
    
    with (oFruit)
    {
        if (fruitType == UnknownEnum.Value_0)
            _appleCount += 1;
        
        if (fruitType == UnknownEnum.Value_12)
            _mangosCount += 1;
    }
    
    var _str = "apple" + string(_appleCount);
    show_debug_message(_str);
    _str = "mang" + string(_mangosCount) + "\n";
    show_debug_message(_str);
    
    if (_appleCount < _mangosCount)
        return UnknownEnum.Value_0;
    else if (_appleCount > _mangosCount)
        return UnknownEnum.Value_12;
    else
        return choose(UnknownEnum.Value_12, UnknownEnum.Value_0);
}
