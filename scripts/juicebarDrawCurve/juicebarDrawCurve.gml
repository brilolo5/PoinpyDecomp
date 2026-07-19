function juicebarDrawCurve(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
{
    var _maxAngle = 180 * clamp(arg4, 0, 1);
    var _segments = 40;
    var _oldColour = draw_get_colour();
    var _oldAlpha = draw_get_alpha();
    draw_set_colour(arg7);
    draw_set_alpha(arg8);
    var _UVs = sprite_get_uvs(sUIPixel, 0);
    var _u = _UVs[0];
    var _v = _UVs[1];
    draw_primitive_begin_texture(pr_trianglestrip, sprite_get_texture(sUIPixel, 0));
    var _incr = 180 / _segments;
    var _angle = 0;
    
    repeat (_segments + 1)
    {
        var _drawAngle = 180 - min(_maxAngle, _angle);
        draw_vertex_texture(arg0 + lengthdir_x(arg2, _drawAngle), arg1 + lengthdir_y(arg2, _drawAngle), _u, _v);
        draw_vertex_texture(arg0 + lengthdir_x(arg3, _drawAngle), arg1 + lengthdir_y(arg3, _drawAngle), _u, _v);
        
        if (_angle > _maxAngle)
            break;
        
        _angle += _incr;
    }
    
    draw_primitive_end();
    draw_set_colour(_oldColour);
    draw_set_alpha(_oldAlpha);
    
    if (arg5)
        juicebarDrawCapWave(arg0 + lengthdir_x(arg2, 180 - _maxAngle), arg1 + lengthdir_y(arg2, 180 - _maxAngle), arg0 + lengthdir_x(arg3, 180 - _maxAngle), arg1 + lengthdir_y(arg3, 180 - _maxAngle), arg6, arg7, arg8);
    else
        juicebarDrawCap(arg0 + lengthdir_x(arg2, 180 - _maxAngle), arg1 + lengthdir_y(arg2, 180 - _maxAngle), arg0 + lengthdir_x(arg3, 180 - _maxAngle), arg1 + lengthdir_y(arg3, 180 - _maxAngle), arg6, arg8);
}
