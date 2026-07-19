function drawPill()
{
    var _left = argument[0];
    var _top = argument[1];
    var _right = argument[2];
    var _bottom = argument[3];
    var _colour = (argument_count > 4 && argument[4] != undefined) ? argument[4] : draw_get_colour();
    var _alpha = (argument_count > 5 && argument[5] != undefined) ? argument[5] : draw_get_alpha();
    
    if (_alpha <= 0)
        exit;
    
    var _rect_t = _top;
    var _rect_b = _bottom;
    var _half_height = 0.5 * (_rect_b - _rect_t);
    var _middle = 0.5 * (_rect_t + _rect_b);
    var _rect_l = _left + _half_height;
    var _rect_r = _right - _half_height;
    var _count = 17;
    var _incr = 180 / _count;
    draw_primitive_begin(pr_trianglelist);
    var _x1 = undefined;
    var _y1 = undefined;
    var _x2 = _rect_l;
    var _y2 = _rect_t;
    var _angle = 90;
    
    repeat (_count + 1)
    {
        _x1 = _x2;
        _y1 = _y2;
        _x2 = _rect_l + lengthdir_x(_half_height, _angle);
        _y2 = _middle + lengthdir_y(_half_height, _angle);
        draw_vertex_colour(_rect_l, _middle, _colour, _alpha);
        draw_vertex_colour(_x1, _y1, _colour, _alpha);
        draw_vertex_colour(_x2, _y2, _colour, _alpha);
        _angle += _incr;
    }
    
    draw_vertex_colour(_rect_l, _rect_t, _colour, _alpha);
    draw_vertex_colour(_rect_r, _rect_t, _colour, _alpha);
    draw_vertex_colour(_rect_r, _rect_b, _colour, _alpha);
    draw_vertex_colour(_rect_l, _rect_t, _colour, _alpha);
    draw_vertex_colour(_rect_r, _rect_b, _colour, _alpha);
    draw_vertex_colour(_rect_l, _rect_b, _colour, _alpha);
    _x1 = undefined;
    _y1 = undefined;
    _x2 = _rect_r;
    _y2 = _rect_b;
    _angle = 270;
    
    repeat (_count + 1)
    {
        _x1 = _x2;
        _y1 = _y2;
        _x2 = _rect_r + lengthdir_x(_half_height, _angle);
        _y2 = _middle + lengthdir_y(_half_height, _angle);
        draw_vertex_colour(_rect_r, _middle, _colour, _alpha);
        draw_vertex_colour(_x1, _y1, _colour, _alpha);
        draw_vertex_colour(_x2, _y2, _colour, _alpha);
        _angle += _incr;
    }
    
    draw_primitive_end();
}
