function drawEllipse(arg0, arg1, arg2, arg3, arg4)
{
    var _x = arg0;
    var _y = arg1;
    var _halfwidth = arg2 / 2;
    var _halfheight = arg3 / 2;
    var _outline = arg4;
    var _left = _x - _halfwidth;
    var _right = _x + _halfwidth;
    var _top = _y - _halfheight;
    var _bottom = _y + _halfheight;
    draw_ellipse(_left, _top, _right, _bottom, _outline);
}
