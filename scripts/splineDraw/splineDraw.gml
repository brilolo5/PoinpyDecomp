function splineDraw(arg0, arg1, arg2, arg3)
{
    draw_primitive_begin(pr_linestrip);
    var _incr = 1 / arg1;
    var _t = 0;
    
    repeat (arg1 + 1)
    {
        var _point = splineInterpolate(_t, arg0);
        draw_vertex(arg2 + _point[0], arg3 + _point[1]);
        _t += _incr;
    }
    
    draw_primitive_end();
    var _i = 0;
    
    repeat (array_length(arg0) div 2)
    {
        draw_circle(arg0[_i], arg0[_i + 1], 2, false);
        _i += 2;
    }
}
