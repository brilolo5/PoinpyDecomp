function draw_sprite_pos_fixed(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
{
    var sprite = arg0;
    var subimg = arg1;
    var colour = arg10;
    var alpha = arg11;
    var texture = sprite_get_texture(sprite, subimg);
    var uvs = sprite_get_uvs(sprite, subimg);
    var px;
    px[0] = arg8;
    var py;
    py[0] = arg9;
    px[1] = arg6;
    py[1] = arg7;
    px[2] = arg4;
    py[2] = arg5;
    px[3] = arg2;
    py[3] = arg3;
    var ax = px[2] - px[0];
    var ay = py[2] - py[0];
    var bx = px[3] - px[1];
    var by = py[3] - py[1];
    var can = (ax * by) - (ay * bx);
    
    if (can != 0)
    {
        var cx = px[0] - px[1];
        var cy = py[0] - py[1];
        var s = ((ax * cy) - (ay * cx)) / can;
        
        if (s > 0 && s < 1)
        {
            var t = ((bx * cy) - (by * cx)) / can;
            
            if (t > 0 && t < 1)
            {
                var q;
                q[0] = 1 / (1 - t);
                q[1] = 1 / (1 - s);
                q[2] = 1 / t;
                q[3] = 1 / s;
                var v_buffer = vertex_create_buffer();
                vertex_begin(v_buffer, global.format_perspective);
                vertex_colour(v_buffer, colour, alpha);
                vertex_position(v_buffer, px[3], py[3]);
                vertex_normal(v_buffer, q[3] * uvs[0], q[3] * uvs[1], q[3]);
                vertex_colour(v_buffer, colour, alpha);
                vertex_position(v_buffer, px[2], py[2]);
                vertex_normal(v_buffer, q[2] * uvs[2], q[2] * uvs[1], q[2]);
                vertex_colour(v_buffer, colour, alpha);
                vertex_position(v_buffer, px[0], py[0]);
                vertex_normal(v_buffer, q[0] * uvs[0], q[0] * uvs[3], q[0]);
                vertex_colour(v_buffer, colour, alpha);
                vertex_position(v_buffer, px[1], py[1]);
                vertex_normal(v_buffer, q[1] * uvs[2], q[1] * uvs[3], q[1]);
                vertex_end(v_buffer);
                shader_set_track(sh_perspective);
                vertex_submit(v_buffer, pr_trianglestrip, texture);
                shader_reset_track();
                vertex_delete_buffer(v_buffer);
            }
        }
    }
}
