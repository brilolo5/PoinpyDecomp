function scribble_font_bake_outline(arg0, arg1, arg2, arg3, arg4, arg5)
{
    if (is_string(arg4))
    {
        var _found = global.__scribble_colours[? arg4];
        
        if (arg4 == undefined)
        {
            __scribble_error("Colour \"", arg4, "\" not recognised");
            exit;
        }
        
        arg4 = _found & 16777215;
    }
    
    shader_set_track(__shd_scribble_bake_outline);
    shader_set_uniform_i(shader_get_uniform(shader_current(), "u_iOutlineSize"), arg2);
    shader_set_uniform_i(shader_get_uniform(shader_current(), "u_iOutlineSamples"), arg3);
    shader_set_uniform_f(shader_get_uniform(shader_current(), "u_vOutlineColor"), color_get_red(arg4) / 255, color_get_green(arg4) / 255, color_get_blue(arg4) / 255);
    shader_reset_track();
    scribble_font_bake_shader(arg0, arg1, __shd_scribble_bake_outline, 2, arg2, arg2, arg2, arg2, arg2, arg5);
}
