depth = 10000;
layer0_y = y;
layer1_y = y;
bgArea = global.currentLevelChunkSet;
bgLayerData = getAreaColor(bgArea);
color = make_color_rgb(255, 255, 255);

drawTranscendenceBg = function()
{
    var viewy = getViewy(global.cam);
    var viewx = getViewx(global.cam);
    draw_clear(make_color_rgb(255, 255, 255));
    var _middle = global.viewHeight / 2;
    
    drawWave = function(arg0, arg1, arg2, arg3, arg4 = 1, arg5 = 1, arg6 = 0)
    {
        var viewy = getViewy(global.cam);
        var viewx = getViewx(global.cam);
        var _centerx = viewx + (global.viewWidth / 2);
        var _drawy = viewy + arg0;
        var _waveFillScreenWidth = 160;
        var _waveSprite = sTranscendenceWave;
        var _waveIndex = ((current_time / 100) * 1 * arg2) + arg6;
        var _wavePartWidth_source = sprite_get_width(_waveSprite);
        var _wavePartHeight_source = sprite_get_height(_waveSprite);
        var _waveColor = arg1;
        var _waveScale = arg3;
        var _waveAlpha = 1;
        var _wavePartWidth = _wavePartWidth_source * _waveScale;
        var _wavePartHeight = _wavePartHeight_source * _waveScale;
        var _wavePartNum = ceil(_waveFillScreenWidth / _wavePartWidth);
        
        if ((_wavePartNum % 2) == 0)
            _wavePartNum += 1;
        
        _wavePartNum /= 2;
        _wavePartNum = floor(_wavePartNum);
        var i = -_wavePartNum;
        
        while (i <= _wavePartNum)
        {
            draw_sprite_ext(_waveSprite, _waveIndex, _centerx + (i * _wavePartWidth), _drawy, _waveScale * arg4, _waveScale * arg5, 0, _waveColor, _waveAlpha);
            i += 1;
        }
        
        draw_set_color(arg1);
        draw_rectangle(viewx, _drawy + ((_wavePartHeight / 2) * arg5), viewx + _waveFillScreenWidth, _drawy + (100 * arg5), 0);
    };
    
    drawLinesOfWaves = function(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    {
        for (var i = 0; i < arg2; i += 1)
        {
            var _ratio = i / arg2;
            var _posCurve = animcurveGetValueAtPos(curveQuad, "curve1", _ratio);
            var _whiteMixCurve = animcurveGetValueAtPos(curveSineInv, "curve1", _ratio);
            var _waveWobbleRate = 0;
            var _waveWobbleDelays = 0;
            var _drawPosy = lerp(arg0, arg1, _posCurve);
            var _ratioScale = lerp(arg3, arg4, _posCurve);
            var _waveImageNumber = sprite_get_number(sTranscendenceWave);
            var _waveImageIndex = ((((current_time / 100) * 1) - i) + 2) % _waveImageNumber;
            var _waveColor = getAuroraColor(0.8, make_color_rgb(255, 255, 255), 0.9 * (1 - _whiteMixCurve), 1 - (_waveImageIndex / _waveImageNumber));
            drawWave(_drawPosy, _waveColor, 0, _ratioScale, arg5, arg6, _waveImageIndex);
        }
    };
    
    var _frontScale = 0.8;
    var _backScale = 1/15;
    var _layerNum = 10;
    var _spaceApart = 16;
    drawLinesOfWaves(_middle + _spaceApart, _middle * 2, _layerNum, _backScale, _frontScale, 1, 1);
    drawLinesOfWaves(_middle - _spaceApart, 0, _layerNum, _backScale, _frontScale, -1, -1);
};
