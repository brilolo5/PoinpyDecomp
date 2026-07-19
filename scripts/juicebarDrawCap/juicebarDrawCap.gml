function juicebarDrawCap(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var _angle = point_direction(arg0, arg1, arg2, arg3);
    var _width = point_distance(arg0, arg1, arg2, arg3);
    draw_sprite_ext(sJuicebarCap, 0, arg0, arg1, arg4 / 3, _width, _angle + 90, c_white, arg5);
}
