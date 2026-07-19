draw_self();
drawTextOutlined(x, y - 64 - 16 - 8, myModeText, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 0.9);
areaTextColor[UnknownEnum.Value_2] = make_color_rgb(90, 243, 145);
areaTextColor[UnknownEnum.Value_3] = make_color_rgb(65, 162, 255);
areaTextColor[UnknownEnum.Value_4] = make_color_rgb(254, 66, 113);
areaTextColor[UnknownEnum.Value_5] = make_color_rgb(255, 238, 96);
var _averageList = global.arcadeAverageList_current[myMode];
var _average = 0;
var _drawx = x;
var _spaceBetweenNums = 32;
var _drawy = y - 32 - 16 - 8 - 4;
var _listText = "";
var _listSize = ds_list_size(_averageList);
var _averageDrawx = _drawx - (_spaceBetweenNums * ((_listSize - 1) / 2));
var _areaForAverage = global.arcadeAreaLock[myMode];
var _averageActualAverage = 0;
var _averageTextSize = 0.9;

for (var i = 0; i < _listSize; i += 1)
{
    var _averageText = _averageList[| i];
    var _textColor = areaTextColor[_areaForAverage];
    var _textx = _averageDrawx + (i * _spaceBetweenNums);
    var _texty = _drawy - 8;
    
    if (_averageList[| i] < 0)
    {
        _averageActualAverage = -99999;
        _averageText = "*";
        _textColor = make_color_rgb(255, 255, 255);
    }
    else
    {
        _averageActualAverage += _averageList[| i];
    }
    
    draw_set_color(make_color_rgb(176, 183, 195));
    drawRectFromCenter(_textx, _texty - 0.5, 24, 16, 0);
    drawTextOutlined(_textx, _texty, _averageText, _textColor, make_color_rgb(46, 50, 59), 0, _averageTextSize);
    _areaForAverage -= 1;
    
    if (_areaForAverage < UnknownEnum.Value_2)
        _areaForAverage = UnknownEnum.Value_5;
}

if (_averageActualAverage > -1)
{
    _averageActualAverage /= _listSize;
    _averageActualAverage = round(_averageActualAverage);
    _averageActualAverage = "average: " + string(_averageActualAverage);
}
else
{
    _averageActualAverage = "average: -";
}

drawTextOutlined(_drawx, _drawy + 6, _averageActualAverage, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _averageTextSize);

if (_averageActualAverage != "average: -")
{
    _averageList = global.arcadeAverageList_highest[myMode];
    _average = 0;
    _drawx = x;
    _spaceBetweenNums = 20;
    _drawy = _drawy + 32 + 4;
    _listText = "";
    _listSize = ds_list_size(_averageList);
    _averageDrawx = _drawx - (_spaceBetweenNums * ((_listSize - 1) / 2));
    _areaForAverage = global.arcadeAreaLock_highest[myMode];
    _averageActualAverage = 0;
    
    for (var i = 0; i < _listSize; i += 1)
    {
        var _textx = _averageDrawx + (i * _spaceBetweenNums);
        var _texty = _drawy - 8 - 2;
        draw_set_color(make_color_rgb(176, 183, 195));
        drawRectFromCenter(_textx, _texty - 0.5, 16, 12, 0);
        var _averageText = _averageList[| i];
        var _textColor = areaTextColor[_areaForAverage];
        
        if (_averageList[| i] < 0)
        {
            _averageActualAverage = -99999;
            _averageText = "*";
            _textColor = make_color_rgb(255, 255, 255);
        }
        else
        {
            _averageActualAverage += _averageList[| i];
        }
        
        drawTextOutlined(_textx, _texty, _averageText, _textColor, make_color_rgb(46, 50, 59), 0, 0.7);
        _areaForAverage -= 1;
        
        if (_areaForAverage < UnknownEnum.Value_2)
            _areaForAverage = UnknownEnum.Value_5;
    }
    
    if (_averageActualAverage > -1)
    {
        _averageActualAverage /= _listSize;
        _averageActualAverage = round(_averageActualAverage);
        _averageActualAverage = "best average: " + string(_averageActualAverage);
    }
    else
    {
        _averageActualAverage = "best average: -";
    }
    
    drawTextOutlined(_drawx, _drawy, _averageActualAverage, make_color_rgb(225, 223, 1), make_color_rgb(46, 50, 59), 0, 0.7);
}
