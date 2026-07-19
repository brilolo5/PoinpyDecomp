function surface_blur(arg0, arg1, arg2, arg3)
{
    var _surface = arg0;
    var _temp = arg1;
    var _shader = arg2;
    var _scale = arg3;
    var _temp_destroy = false;
    
    if (!surface_exists(_temp))
    {
        _temp_destroy = true;
        _temp = surface_create_track(surface_get_width(_surface), surface_get_height(_surface));
    }
    
    surface_set_target(_temp);
    draw_clear(c_black);
    shader_set_track(_shader);
    shader_set_uniform_f(shader_get_uniform(_shader, "u_vTexelStep"), _scale * texture_get_texel_width(surface_get_texture(_surface)), 0);
    shader_set_uniform_f(shader_get_uniform(_shader, "u_fIntensity"), 1);
    draw_surface(_surface, 0, 0);
    shader_reset_track();
    surface_reset_target();
    surface_set_target(_surface);
    shader_set_track(_shader);
    shader_set_uniform_f(shader_get_uniform(_shader, "u_vTexelStep"), 0, _scale * texture_get_texel_height(surface_get_texture(_temp)));
    shader_set_uniform_f(shader_get_uniform(_shader, "u_fIntensity"), 1);
    draw_surface(_temp, 0, 0);
    shader_reset_track();
    surface_reset_target();
    
    if (_temp_destroy)
        surface_free(_temp);
}
