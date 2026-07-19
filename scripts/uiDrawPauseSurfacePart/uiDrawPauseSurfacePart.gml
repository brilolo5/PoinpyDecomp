function uiDrawPauseSurfacePart(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var _texture = -1;
    
    if (global.printScreenSprite != undefined && sprite_exists(global.printScreenSprite))
    {
        if (surface_exists(global.printScreenSprite))
            _texture = sprite_get_texture(global.printScreenSprite, 0);
    }
    else if (global.ingamePause && global.printScreen != undefined && surface_exists(global.printScreen))
    {
        if (surface_exists(global.printScreen))
            _texture = surface_get_texture(global.printScreen);
    }
    
    if (_texture != -1)
    {
        uiShaderSet(shFog);
        shader_set_uniform_f(shader_get_uniform(shFog, "u_vFog"), colour_get_red(arg4) / 255, colour_get_green(arg4) / 255, colour_get_blue(arg4) / 255, arg5);
        draw_primitive_begin_texture(pr_trianglelist, _texture);
        var _u1 = (arg0 - global.windowLeft) / global.viewWidth;
        var _u2 = (arg2 - global.windowLeft) / global.viewWidth;
        var _v1 = (arg1 - global.gameSurfaceTop) / global.viewHeight;
        var _v2 = (arg3 - global.gameSurfaceTop) / global.viewHeight;
        draw_vertex_texture_colour(arg0, arg1, _u1, _v1, c_white, 1);
        draw_vertex_texture_colour(arg2, arg1, _u2, _v1, c_white, 1);
        draw_vertex_texture_colour(arg2, arg3, _u2, _v2, c_white, 1);
        draw_vertex_texture_colour(arg0, arg1, _u1, _v1, c_white, 1);
        draw_vertex_texture_colour(arg2, arg3, _u2, _v2, c_white, 1);
        draw_vertex_texture_colour(arg0, arg3, _u1, _v2, c_white, 1);
        draw_primitive_end();
        uiShaderReset();
    }
}
