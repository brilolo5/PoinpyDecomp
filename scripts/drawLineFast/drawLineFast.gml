function drawLineFast(arg0, arg1, arg2, arg3)
{
    draw_sprite_ext(sUIPixel, 0, arg0, arg1, point_distance(arg0, arg1, arg2, arg3), 1, point_direction(arg0, arg1, arg2, arg3), draw_get_colour(), draw_get_alpha());
}
