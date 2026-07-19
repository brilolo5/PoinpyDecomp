function drawTestAurora()
{
    var viewy = getViewy(global.cam);
    var viewx = getViewx(global.cam);
    gridWidth = 16;
    gridHeight = 20;
    
    for (var _x = 0; _x <= gridWidth; _x += 1)
    {
        for (var _y = 0; _y <= gridHeight; _y += 1)
        {
            gridPoint[_x][_y][UnknownEnum.Value_0] = _x;
            gridPoint[_x][_y][UnknownEnum.Value_1] = _y;
        }
    }
    
    draw_clear(getWaveBgColor(-1));
    var _gridLeft = viewx - 16;
    var _gridRight = viewx + global.viewWidth + 16;
    var _gridTop = viewy - 16;
    var _gridHorizontalSpacing = 16;
    var _gridVerticalSpacing = 32;
    var _time = global.time / 40;
    var _waveWidth = 8;
    var _waveHeight = 4;
    
    for (var _x = 0; _x <= gridWidth; _x += 1)
    {
        var _lerpValue = _x / (gridWidth - 1);
        var _lerpValueInv = (gridWidth - 1 - _x) / (gridWidth - 1);
        var _curveVal = animcurveGetValueAtPos(curveCircInv, "curve1", _lerpValue);
        var _gridBasex = lerp(_gridLeft, viewx + (global.viewWidth / 2) + 12, _curveVal);
        var _waveWidthFinal = _waveWidth * _lerpValueInv;
        _gridVerticalSpacing -= 1;
        
        for (var _y = 0; _y <= gridHeight; _y += 1)
        {
            var _wavex = sin(_time - _y) * _waveWidthFinal;
            var _wavey = cos(_time - _x) * _waveHeight;
            gridPoint[_x][_y][UnknownEnum.Value_0] = _gridBasex + _wavex;
            gridPoint[_x][_y][UnknownEnum.Value_1] = (_gridVerticalSpacing * _y) + _wavey;
            var _gridPointx = gridPoint[_x][_y][UnknownEnum.Value_0];
            var _gridPointy = gridPoint[_x][_y][UnknownEnum.Value_1];
        }
    }
    
    for (var _x = 0; _x <= (gridWidth - 1); _x += 1)
    {
        var _lerpValue = _x / (gridWidth - 1);
        var _lerpValueInv = (gridWidth - 1 - _x) / (gridWidth - 1);
        var _col = getWaveBgColor(_lerpValue);
        var _pointSize = 1.25 * _lerpValueInv;
        var _pointCol = merge_color(_col, make_color_rgb(255, 255, 255), 0.5);
        draw_primitive_begin(pr_trianglestrip);
        draw_set_color(_col);
        draw_set_alpha(1);
        
        for (var _y = 0; _y <= gridHeight; _y += 1)
        {
            var _gridPointx = _gridLeft + gridPoint[_x][_y][UnknownEnum.Value_0];
            var _gridPointy = _gridTop + gridPoint[_x][_y][UnknownEnum.Value_1];
            draw_vertex(_gridPointx, _gridPointy);
            _gridPointx = _gridLeft + gridPoint[_x + 1][_y][UnknownEnum.Value_0];
            _gridPointy = _gridTop + gridPoint[_x + 1][_y][UnknownEnum.Value_1];
            draw_vertex(_gridPointx, _gridPointy);
        }
        
        draw_primitive_end();
    }
    
    for (var _x = 0; _x <= (gridWidth - 1); _x += 1)
    {
        var _lerpValue = _x / (gridWidth - 1);
        var _lerpValueInv = (gridWidth - 1 - _x) / (gridWidth - 1);
        var _col = getWaveBgColor(_lerpValue);
        var _pointSize = 1.25 * _lerpValueInv;
        var _pointCol = merge_color(_col, make_color_rgb(255, 255, 255), 0.5);
        draw_primitive_begin(pr_trianglestrip);
        draw_set_color(_col);
        draw_set_alpha(1);
        
        for (var _y = 0; _y <= gridHeight; _y += 1)
        {
            var _gridPointx = _gridRight - gridPoint[_x][_y][UnknownEnum.Value_0];
            var _gridPointy = _gridTop + gridPoint[_x][_y][UnknownEnum.Value_1];
            draw_vertex(_gridPointx, _gridPointy);
            _gridPointx = _gridRight - gridPoint[_x + 1][_y][UnknownEnum.Value_0];
            _gridPointy = _gridTop + gridPoint[_x + 1][_y][UnknownEnum.Value_1];
            draw_vertex(_gridPointx, _gridPointy);
        }
        
        draw_primitive_end();
    }
}

function getAuroraColor(arg0, arg1 = 16777215, arg2 = 0, arg3 = current_time / 10000)
{
    arg0 = (arg0 + arg3) % 1;
    var _R = animcurveGetValueAtPos(acErrorGradient, "red", arg0);
    var _G = animcurveGetValueAtPos(acErrorGradient, "green", arg0);
    var _B = animcurveGetValueAtPos(acErrorGradient, "blue", arg0);
    var _col = make_color_rgb(_R, _G, _B);
    _col = merge_color(_col, arg1, arg2);
    return _col;
}

function getWaveBgColor(arg0)
{
    var _col;
    
    if (arg0 == -1)
        _col = make_color_rgb(255, 255, 255);
    else
        _col = merge_color(make_color_rgb(46, 50, 59), make_color_rgb(255, 255, 255), arg0);
    
    return _col;
}
