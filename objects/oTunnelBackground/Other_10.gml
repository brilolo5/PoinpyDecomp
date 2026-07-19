var _viewy = getViewy(global.cam);
var _viewx = getViewx(global.cam);
var _depth = -(ystart - _viewy) / 18;
var _bgx = _viewx + 80;
y = ystart + _depth;
draw_set_color(c_blue);
var _bgHeight = bbox_bottom - bbox_top;
var _boxTop = y - (_bgHeight / 2);
var _boxBottom = y + (_bgHeight / 2);
var _sprHeight = 48;
var _tileNum = ceil(_bgHeight / _sprHeight);
col[0] = make_color_rgb(69, 80, 97);
col[1] = make_color_rgb(122, 131, 146);
texture_set_interpolation(false);
var _edgeSprScale = global.viewWidth / sprite_get_width(sIntervalTunnelEdge);
var i, __top, _col;

for (i = 0; i < _tileNum; i += 1)
{
    _col = col[i % 2];
    __top = _boxTop + (i * _sprHeight);
    draw_set_color(_col);
    draw_rectangle(_viewx, __top, _viewx + global.viewWidth, __top + _sprHeight, 0);
    draw_sprite_ext(sIntervalTunnelEdge, i, _viewx + (global.viewWidth / 2), __top, _edgeSprScale, _edgeSprScale, 0, _col, 1);
}

draw_sprite_ext(sIntervalTunnelEdge, i, _viewx + (global.viewWidth / 2), __top + _sprHeight, _edgeSprScale, -_edgeSprScale, 0, _col, 1);
texture_set_interpolation(true);

if (global.finalStretchSequence < UnknownEnum.Value_3)
{
    if ((_viewy + (global.viewHeight / 2)) >= y)
    {
        with (oGameBackground)
        {
            bgArea = other.previousLevelChunk;
            bgLayerData = getAreaColor(bgArea);
        }
    }
    else
    {
        with (oGameBackground)
        {
            bgArea = other.nextLevelChunk;
            bgLayerData = getAreaColor(bgArea);
        }
    }
}
