function drawCircleThinOutline(arg0, arg1, arg2, arg3, arg4)
{
    var _uvs = sprite_get_uvs(sUIPixel, 0);
    var _u = _uvs[0];
    var _v = _uvs[1];
    draw_primitive_begin_texture(pr_linestrip, sprite_get_texture(sUIPixel, 0));
    var _incr = 9;
    var _angle = 0;
    
    repeat (41)
    {
        draw_vertex_texture_color(arg0 + lengthdir_x(arg2 - 1, _angle), arg1 + lengthdir_y(arg2 - 1, _angle), _u, _v, arg3, arg4);
        _angle += _incr;
    }
    
    draw_primitive_end();
}
