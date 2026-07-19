function bezierDraw(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
{
    draw_primitive_begin(pr_linestrip);
    var _incr = 1 / arg8;
    var _t = 0;
    
    repeat (arg8 + 1)
    {
        var _x = bezierDimension(_t, arg0, arg2, arg4, arg6);
        var _y = bezierDimension(_t, arg1, arg3, arg5, arg7);
        draw_vertex(arg9 + _x, arg10 + _y);
        _t += _incr;
    }
    
    draw_primitive_end();
}
