var _cullHeight = -16;
var _bottomCheck = bbox_bottom - _cullHeight - getViewy(global.cam);
var _topCheck = (getViewy(global.cam) + global.viewHeight) - (bbox_top + _cullHeight);
var _inScreen = sign(min(_bottomCheck, _topCheck));
_inScreen = clamp(_inScreen, 0, 1);

if (_inScreen)
{
    var _drawx = x + (image_xscale * 8);
    var _height = image_yscale;
    var _ytop = bbox_top + 8;
    
    for (var i = 0; i < _height; i += 3)
    {
        var _size = clamp(_height - i, 1, 3) - 1;
        var _drawy = _ytop + (i * 16) + (_size * 8);
        draw_sprite_ext(sSoftPadding, _size, _drawx, _drawy, 0.1 * image_xscale * 1, 0.1, 0, c_white, 1);
    }
}
