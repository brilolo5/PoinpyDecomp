function drawReadyBonusSign()
{
    var centerx = global.windowCenterx;
    var _drawListPosx = centerx;
    var _drawListPosy = global.gameSurfaceTop + 20 + 4 + global.notchOffset + 4 + 4;
    var _drawListIndex = recipeDataGrid;
    drawOrderList(_drawListPosx, _drawListPosy, _drawListIndex, angerTimer, angerTimerMax);
    
    if ((global.orderChecklistFilled && recipeRiseSequence <= 0.05) || (orderComplete && !orderFailed))
    {
        var _ocfMax = 10;
        var _ocfTween = (_ocfMax - global.orderChecklistFilled) / _ocfMax;
        
        if (orderComplete && !orderFailed)
        {
            _ocfTween = 0;
            global.orderChecklistFilled = _ocfMax;
        }
        
        var _thumbScale = 1 + (_ocfTween * 0.75);
        var _thumbx = _drawListPosx + 12;
        var _thumby = _drawListPosy + 16;
        var _thumbAngle = 20 * _ocfTween;
        
        if (global.orderChecklistFilled < _ocfMax)
        {
            global.orderChecklistFilled += 1;
            
            if (global.orderChecklistFilled >= _ocfMax)
                _thumbScale = 0.9;
        }
        
        var _excessFruitCount = getExcessFruitCount();
        
        if (!orderComplete)
            bonusCountRecord = _excessFruitCount;
        
        var _readyx = (_drawListPosx + 16) - 8 - 1 - 2;
        var _readyy = ((_drawListPosy + 32) - 8 - 2) + 3;
        drawSetAlign(1, 1);
        var _readyString = "[wave][cycle,32,43]" + loc("main game UI juice ready");
        var _readySize = 1.2;
        _readySize = 1.2;
        
        if (_excessFruitCount > 0)
        {
            _readyString = "[wave][cycle,32,43]" + loc("main game UI extra bonus");
            _readySize = 0.8;
            _readySize = 1;
        }
        
        if (global.finalStretchSequence >= UnknownEnum.Value_3)
        {
            _excessFruitCount = 0;
            bonusCountRecord = 0;
            _readyString = "[wave][cycle,32,43]" + loc("main game UI star juice ready");
            _readySize = 1.2;
            _readySize = 1.2;
        }
        
        var _textColor = make_color_rgb(225, 223, 1);
        
        if (orderComplete)
        {
            _readyString = loc("main game UI juice done");
            _textColor = make_color_rgb(255, 255, 255);
        }
        
        _readySize *= 0.5;
        
        if (!abilityCheck(UnknownEnum.Value_22))
            scribble(_readyString).line_height(0, 22).starting_format(locGetFontFromLanguage(), _textColor).msdf_border(make_color_rgb(46, 50, 59), 3).transform(_thumbScale * _readySize, _thumbScale * _readySize, _thumbAngle + 10).align(1, 1).draw(_readyx, _readyy);
        
        if (_excessFruitCount > 0 || (orderComplete && bonusCountRecord > 0))
        {
            bonusCountDelay = max(0, bonusCountDelay - (1/3));
            var _textWobble = "[wobble]";
            
            if (orderComplete)
            {
                bonusCountTween = bonusCountRecord;
                bonusAnimationTween = 0;
                _textWobble = "";
            }
            else if (bonusCountTween != _excessFruitCount && bonusCountDelay <= 0)
            {
                bonusCountTween = clamp(bonusCountTween, _excessFruitCount - 32, _excessFruitCount);
                bonusCountTween = min(_excessFruitCount, bonusCountTween + 1);
                bonusCountDelay = 1;
                bonusAnimationTween = 1;
                playSoundBonusFruitGet(_excessFruitCount);
            }
            
            bonusAnimationTween = max(0, bonusAnimationTween - 0.1851851851851852);
            var _extraBonusTween = bonusAnimationTween;
            var _textOutlineColor = make_color_rgb(46, 50, 59);
            var _bonusTextColor = make_color_rgb(255, 255, 255);
            var _bonusTextOutlineColor = make_color_rgb(90, 243, 145);
            var _bonusLevel = floor(bonusCountTween / 5);
            _bonusLevel = _bonusLevel % 3;
            var _bonusTextColorArray;
            _bonusTextColorArray[0] = make_color_rgb(254, 66, 113);
            _bonusTextColorArray[1] = make_color_rgb(255, 238, 96);
            _bonusTextColorArray[2] = make_color_rgb(65, 162, 255);
            _bonusTextColorArray[3] = make_color_rgb(254, 66, 113);
            _bonusTextColorArray[4] = make_color_rgb(255, 238, 96);
            _bonusTextColorArray[5] = make_color_rgb(65, 162, 255);
            var _bonusTextColorIndex = _bonusLevel % 3;
            _bonusTextColorIndex += 1;
            var _colIndex = abs(((_bonusTextColorIndex + 4) - 1) % 3);
            _bonusTextOutlineColor = _bonusTextColorArray[_bonusTextColorIndex];
            
            if (_extraBonusTween >= 0.5)
            {
                _textOutlineColor = make_color_rgb(255, 255, 255);
                _bonusTextOutlineColor = make_color_rgb(255, 255, 255);
            }
            
            var _extraBonusDrawx = _drawListPosx + 1;
            var _extraBonusDrawy = _drawListPosy - 3;
            var _fontScale = 0.2857142857142857;
            _fontScale = 1/3;
            var _extraBonusString = loc("main game UI extra bonus");
            _fontScale = 1 + (orderComplete * 0.3);
            var _bonusTextScalex = _fontScale * (1 + (_extraBonusTween * 0.5));
            var _bonusTextScaley = _fontScale * (1 - (_extraBonusTween * 0.9));
            var _bonusTextAngle = 7;
            _extraBonusString = _textWobble + string(bonusCountTween);
            scribble(_extraBonusString).line_height(0, 23).starting_format(locGetNumFont(-1), make_color_rgb(255, 255, 255)).msdf_border(_bonusTextOutlineColor, 6).wrap(128, -1, locIsAsian()).transform(_bonusTextScalex, _bonusTextScaley, _bonusTextAngle).align(1, 1).draw(_extraBonusDrawx, _extraBonusDrawy + 4);
            scribble(_extraBonusString).line_height(0, 23).starting_format(locGetNumFont(-1), _bonusTextColor).msdf_border(_textOutlineColor, 3).wrap(128, -1, locIsAsian()).transform(_bonusTextScalex, _bonusTextScaley, _bonusTextAngle).align(1, 1).draw(_extraBonusDrawx, _extraBonusDrawy + 4);
        }
        else
        {
            bonusCountTween = 1;
        }
    }
}
