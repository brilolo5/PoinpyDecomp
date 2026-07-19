function juicebarDrawCapWave()
{
    var _xOuter = argument[0];
    var _yOuter = argument[1];
    var _xInner = argument[2];
    var _yInner = argument[3];
    var _thickness = argument[4];
    var _colour = argument[5];
    var _alpha = argument[6];
    var _time = (argument_count > 7 && argument[7] != undefined) ? argument[7] : (current_time / 13);
    var _oldColour = draw_get_colour();
    var _oldAlpha = draw_get_alpha();
    draw_set_colour(_colour);
    draw_set_alpha(_alpha);
    var _dx = _xInner - _xOuter;
    var _dy = _yInner - _yOuter;
    var _d = _thickness / sqrt((_dx * _dx) + (_dy * _dy));
    _dx *= _d;
    _dy *= _d;
    var _waveFreq = 864;
    var _segments = 15;
    var _UVs = sprite_get_uvs(sUIPixel, 0);
    var _u = _UVs[0];
    var _v = _UVs[1];
    draw_primitive_begin_texture(pr_trianglestrip, sprite_get_texture(sUIPixel, 0));
    var _incr = 1 / _segments;
    var _t = 0;
    
    repeat (_segments + 1)
    {
        var _angle = _t * _waveFreq;
        var _s = 0.5 * (dsin((_angle - _time) + (40 * (0.2 + (0.8 * dcos(0.7 * _time))))) + dsin(0.25 * _time));
        _s = 0.5 + (0.5 * _s);
        var _x1 = lerp(_xOuter, _xInner, _t);
        var _y1 = lerp(_yOuter, _yInner, _t);
        var _x2 = _x1 + (_dy * _s);
        var _y2 = _y1 - (_dx * _s);
        draw_vertex_texture(_x1, _y1, _u, _v);
        draw_vertex_texture(_x2, _y2, _u, _v);
        _t += _incr;
    }
    
    draw_primitive_end();
    draw_set_colour(_oldColour);
    draw_set_alpha(_oldAlpha);
}
