function drawSquircle(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    if (arg4 <= 0)
        return drawRectangleFast(arg0, arg1, arg2, arg3, arg5, arg6);
    
    arg2++;
    arg3++;
    var _rect_l = arg0 + arg4;
    var _rect_t = arg1 + arg4;
    var _rect_r = arg2 - arg4;
    var _rect_b = arg3 - arg4;
    var _count = 9;
    var _incr = 90 / _count;
    draw_primitive_begin(pr_trianglelist);
    var _angle = 0;
    var _x1 = undefined;
    var _y1 = undefined;
    var _x2 = arg2;
    var _y2 = _rect_t;
    
    repeat (_count + 1)
    {
        _x1 = _x2;
        _y1 = _y2;
        _x2 = _rect_r + lengthdir_x(arg4, _angle);
        _y2 = _rect_t + lengthdir_y(arg4, _angle);
        draw_vertex_colour(_rect_r, _rect_t, arg5, arg6);
        draw_vertex_colour(_x1, _y1, arg5, arg6);
        draw_vertex_colour(_x2, _y2, arg5, arg6);
        _angle += _incr;
    }
    
    _angle = 90;
    _x1 = undefined;
    _y1 = undefined;
    _x2 = _rect_l;
    _y2 = _rect_t;
    
    repeat (_count + 1)
    {
        _x1 = _x2;
        _y1 = _y2;
        _x2 = _rect_l + lengthdir_x(arg4, _angle);
        _y2 = _rect_t + lengthdir_y(arg4, _angle);
        draw_vertex_colour(_rect_l, _rect_t, arg5, arg6);
        draw_vertex_colour(_x1, _y1, arg5, arg6);
        draw_vertex_colour(_x2, _y2, arg5, arg6);
        _angle += _incr;
    }
    
    _angle = 180;
    _x1 = undefined;
    _y1 = undefined;
    _x2 = _rect_l;
    _y2 = _rect_b;
    
    repeat (_count + 1)
    {
        _x1 = _x2;
        _y1 = _y2;
        _x2 = _rect_l + lengthdir_x(arg4, _angle);
        _y2 = _rect_b + lengthdir_y(arg4, _angle);
        draw_vertex_colour(_rect_l, _rect_b, arg5, arg6);
        draw_vertex_colour(_x1, _y1, arg5, arg6);
        draw_vertex_colour(_x2, _y2, arg5, arg6);
        _angle += _incr;
    }
    
    _angle = 270;
    _x1 = undefined;
    _y1 = undefined;
    _x2 = _rect_r;
    _y2 = _rect_b;
    
    repeat (_count + 1)
    {
        _x1 = _x2;
        _y1 = _y2;
        _x2 = _rect_r + lengthdir_x(arg4, _angle);
        _y2 = _rect_b + lengthdir_y(arg4, _angle);
        draw_vertex_colour(_rect_r, _rect_b, arg5, arg6);
        draw_vertex_colour(_x1, _y1, arg5, arg6);
        draw_vertex_colour(_x2, _y2, arg5, arg6);
        _angle += _incr;
    }
    
    draw_vertex_colour(_rect_l, arg1, arg5, arg6);
    draw_vertex_colour(_rect_r, arg1, arg5, arg6);
    draw_vertex_colour(_rect_r, arg3, arg5, arg6);
    draw_vertex_colour(_rect_l, arg1, arg5, arg6);
    draw_vertex_colour(_rect_r, arg3, arg5, arg6);
    draw_vertex_colour(_rect_l, arg3, arg5, arg6);
    draw_vertex_colour(arg0, _rect_t, arg5, arg6);
    draw_vertex_colour(_rect_l, _rect_t, arg5, arg6);
    draw_vertex_colour(_rect_l, _rect_b, arg5, arg6);
    draw_vertex_colour(arg0, _rect_t, arg5, arg6);
    draw_vertex_colour(_rect_l, _rect_b, arg5, arg6);
    draw_vertex_colour(arg0, _rect_b, arg5, arg6);
    draw_vertex_colour(_rect_r, _rect_t, arg5, arg6);
    draw_vertex_colour(arg2, _rect_t, arg5, arg6);
    draw_vertex_colour(arg2, _rect_b, arg5, arg6);
    draw_vertex_colour(_rect_r, _rect_t, arg5, arg6);
    draw_vertex_colour(arg2, _rect_b, arg5, arg6);
    draw_vertex_colour(_rect_r, _rect_b, arg5, arg6);
    draw_primitive_end();
}
