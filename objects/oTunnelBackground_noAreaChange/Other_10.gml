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
var __top = _boxTop + ((_tileNum - 1) * _sprHeight);
var i, _col;

for (i = 1; i < _tileNum; i += 1)
{
    _col = col[i % 2];
    __top = _boxTop + (i * _sprHeight);
    draw_set_color(_col);
    draw_rectangle(_viewx, __top, _viewx + global.viewWidth, __top + _sprHeight, 0);
    draw_sprite_ext(sIntervalTunnelEdge, i, _viewx + (global.viewWidth / 2), __top, _edgeSprScale, _edgeSprScale, 0, _col, 1);
}

draw_sprite_ext(sIntervalTunnelEdge, i, _viewx + (global.viewWidth / 2), __top + _sprHeight, _edgeSprScale, -_edgeSprScale, 0, _col, 1);
_col = make_color_rgb(69, 80, 97);
draw_set_color(_col);
texture_set_interpolation(true);
