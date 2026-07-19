function drawBgMoon(arg0, arg1, arg2)
{
    var _count = 70;
    var _incr = 360 / _count;
    draw_set_circle_precision(_count);
    draw_set_colour(#FFEA64);
    draw_circle(arg0, arg1, 454 * arg2, false);
    draw_primitive_begin(pr_trianglestrip);
    draw_set_alpha(0);
    var _i = 0;
    
    repeat (_count + 1)
    {
        draw_vertex_colour(arg0 + lengthdir_x(590 * arg2, _i), arg1 + lengthdir_y(590 * arg2, _i), #FFEA64, 0);
        draw_vertex_colour(arg0 + lengthdir_x(450 * arg2, _i), arg1 + lengthdir_y(450 * arg2, _i), #FFEA64, 0.43);
        _i += _incr;
    }
    
    draw_primitive_end();
    draw_set_colour(c_white);
    draw_set_alpha(1);
    draw_set_circle_precision(24);
}
