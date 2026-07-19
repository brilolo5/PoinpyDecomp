function windowCenter(arg0, arg1)
{
    var _wwidth = arg0;
    var _dwidth = display_get_width();
    _wwidth = clamp(_wwidth, 1, _dwidth);
    var _wheight = arg1;
    var _dheight = display_get_height();
    _wheight = clamp(_wheight, 1, _dheight);
    window_set_position((_dwidth / 2) - (_wwidth / 2), (_dheight / 2) - (_wheight / 2));
}
