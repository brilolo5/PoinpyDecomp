function drawRectFromCenter(arg0, arg1, arg2, arg3, arg4)
{
    var _centerx = arg0;
    var _centery = arg1;
    var _rectWidth = arg2;
    var _rectHeight = arg3;
    var _outline = arg4;
    var _rectLeft = _centerx - (_rectWidth / 2);
    var _rectRight = _rectLeft + _rectWidth;
    var _rectTop = _centery - (_rectHeight / 2);
    var _rectBottom = _rectTop + _rectHeight;
    draw_rectangle(_rectLeft, _rectTop, _rectRight, _rectBottom, _outline);
}
