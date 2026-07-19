draw_clear(c_black);
var _dw = display_get_gui_width();
var _dh = display_get_gui_height();
var _xs = _dw / window_get_width();
var _ys = _dh / window_get_height();

if (state_index > 0)
{
    draw_clear(make_color_rgb(46, 50, 59));
    draw_clear(c_black);
    var asHeight = global.viewHeight;
    var asWidthRatio = clamp(global.viewWidth / global.viewHeight / (window_get_width() / window_get_height()), 0, 1);
    var asHeightRatio = clamp(global.viewHeight / global.viewWidth / (window_get_height() / window_get_width()), 0, 1);
    var asWidth = global.viewWidth;
    var asCenterPoint = asWidth / asWidthRatio / 2;
    var asMiddlePoint = asHeight / asHeightRatio / 2;
    var asLeft = asCenterPoint - (asWidth / 2);
    var asTop = asMiddlePoint - (asHeight / 2);
    global.gameSurfaceLeft = asLeft;
    global.gameSurfaceTop = asTop;
    global.gameSurfaceRight = asLeft + asWidth;
    global.gameSurfaceBottom = asTop + asHeight;
    display_set_gui_size(global.viewWidth / asWidthRatio, global.viewHeight / asHeightRatio);
    global.windowCenterx = asWidth / asWidthRatio / 2;
    global.windowLeft = (asWidth / asWidthRatio / 2) - (asWidth / 2);
    global.windowRight = (asWidth / asWidthRatio / 2) + (asWidth / 2);
    global.windowMiddley = asHeight / asHeightRatio / 2;
    global.windowTop = (asHeight / asHeightRatio / 2) - (asHeight / 2);
    global.windowBottom = (asHeight / asHeightRatio / 2) + (asHeight / 2);
    
    if (is_nan(global.windowLeft))
        global.lastValidWindowLeft = 0;
    
    if (is_nan(global.windowTop))
        global.lastValidWindowTop = 0;
    
    if (is_nan(global.windowRight))
        global.lastValidWindowRight = 0;
    
    if (is_nan(global.windowBottom))
        global.lastValidWindowBottom = 0;
    
    drawRectangleLTRB(global.gameSurfaceLeft, global.gameSurfaceTop, global.gameSurfaceRight, global.gameSurfaceBottom, 0, 1);
    var _sprite = sNFSplash;
    var _windowWidth = global.gameSurfaceRight - global.gameSurfaceLeft;
    var _windowHeight = global.gameSurfaceBottom - global.gameSurfaceTop;
    var _displayWidth = display_get_gui_width();
    var _displayHeight = display_get_gui_height();
    
    if (_displayWidth > _displayHeight)
        _sprite = sNFSplash_landscape;
    
    var _Hparts = 8;
    var _Vparts = 4;
    var _splashPartWidth = sprite_get_width(_sprite);
    var _splashPartHeight = sprite_get_height(_sprite);
    var _splashWidth = _splashPartWidth * _Hparts;
    var _splashHeight = _splashPartHeight * _Vparts;
    _xs = _displayWidth / _splashWidth;
    _ys = _displayHeight / _splashHeight;
    var _scale = max(_xs, _ys);
    var _splashPartWidthScaled = _splashPartWidth * _scale;
    var _splashPartHeightScaled = _splashPartHeight * _scale;
    var _splashWidthScaled = _splashWidth * _scale;
    var _splashHeightScaled = _splashHeight * _scale;
    var _splashLeftPos = (_dw / 2) - (_splashWidthScaled / 2);
    var _splashTopPos = (_dh / 2) - (_splashHeightScaled / 2);
    
    for (var i = 0; i < _Hparts; i += 1)
    {
        var _imageIndex = 0;
        var _splashPosx = _splashLeftPos;
        _imageIndex += i;
        _splashPosx += (i * _splashPartWidthScaled);
        
        for (var t = 0; t < _Vparts; t += 1)
        {
            var _splashPosy = _splashTopPos;
            _imageIndex = i + (t * _Hparts);
            _splashPosy += (t * _splashPartHeightScaled);
            draw_sprite_ext(_sprite, _imageIndex, _splashPosx, _splashPosy, _scale, _scale, 0, c_white, 1 - fade_alpha);
        }
    }
}
