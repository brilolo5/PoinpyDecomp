wallColor = make_color_rgb(255, 255, 255);
var _width = image_xscale * 2;
var _height = image_yscale * 2;
var _quarter = 4;
var _left = bbox_left + _quarter;
var _top = bbox_top + _quarter;
var _offsetBy = 0.5;
var _randOffset = x + (y / 10);
partIndex = 0;

for (var _i = 0; _i < _height; _i += 1)
{
    for (var _t = 0; _t < _width; _t += 1)
    {
        partx[partIndex] = _left + (_quarter * 2 * _t) + (sin(_i + _randOffset) * _offsetBy);
        party[partIndex] = _top + (_quarter * 2 * _i) + (sin(_t + _randOffset) * (_offsetBy / 2));
        partIndex += 1;
    }
}

onScreen = 0;
var _fillerRectBorder = 3;
fillerRectLeft = bbox_left + _fillerRectBorder;
fillerRectRight = bbox_right - _fillerRectBorder;
fillerRectTop = bbox_top + _fillerRectBorder;
fillerRectBottom = bbox_bottom - _fillerRectBorder;
