function better_scaling_draw_surface()
{
    var scale_up = (argument[3] > 1 || argument[4] > 1) && argument[8] != 0;
    var scale_down = argument[3] < 1 || argument[4] < 1;
    
    if (scale_up)
    {
        switch (argument[8])
        {
            case 1:
                shader_set_track(sh_better_scaling_bicubic);
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_bicubic, "texel_size"), 1 / surface_get_width(argument[0]), 1 / surface_get_height(argument[0]));
                texture_set_interpolation(true);
                break;
            
            case 2:
                shader_set_track(sh_better_scaling_hq4x);
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_hq4x, "texel_size"), 1 / surface_get_width(argument[0]), 1 / surface_get_height(argument[0]));
                texture_set_interpolation(false);
                break;
            
            case 3:
                shader_set_track(sh_better_scaling_5xbra);
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbra, "texel_size"), 1 / surface_get_width(argument[0]), 1 / surface_get_height(argument[0]));
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbra, "texture_size"), surface_get_width(argument[0]), surface_get_height(argument[0]));
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbra, "color"), color_get_red(argument[6]) / 255, color_get_green(argument[6]) / 255, color_get_blue(argument[6]) / 255, argument[7]);
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbra, "color_to_make_transparent"), -1, -1, -1);
                texture_set_interpolation(false);
                break;
            
            case 4:
                shader_set_track(sh_better_scaling_5xbrb);
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbrb, "texel_size"), 1 / surface_get_width(argument[0]), 1 / surface_get_height(argument[0]));
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbrb, "texture_size"), surface_get_width(argument[0]), surface_get_height(argument[0]));
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbrb, "color"), color_get_red(argument[6]) / 255, color_get_green(argument[6]) / 255, color_get_blue(argument[6]) / 255, argument[7]);
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbrb, "color_to_make_transparent"), -1, -1, -1);
                texture_set_interpolation(false);
                break;
            
            case 5:
                shader_set_track(sh_better_scaling_5xbrc);
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbrc, "texel_size"), 1 / surface_get_width(argument[0]), 1 / surface_get_height(argument[0]));
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbrc, "texture_size"), surface_get_width(argument[0]), surface_get_height(argument[0]));
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbrc, "color"), color_get_red(argument[6]) / 255, color_get_green(argument[6]) / 255, color_get_blue(argument[6]) / 255, argument[7]);
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbrc, "color_to_make_transparent"), -1, -1, -1);
                texture_set_interpolation(false);
                break;
        }
    }
    else if (scale_down)
    {
        var width = surface_get_width(argument[0]);
        var height = surface_get_height(argument[0]);
        var samples_x;
        
        if (argument[3] == 0)
            samples_x = width;
        else
            samples_x = min(width, 1 / argument[3]);
        
        var samples_y;
        
        if (argument[4] == 0)
            samples_y = height;
        else
            samples_y = min(height, 1 / argument[4]);
        
        var max_samples = max(samples_x, samples_y);
        var offset_x = (1 / width) * samples_x * 0.5;
        var offset_y = (1 / height) * samples_y * 0.5;
        
        if (max_samples <= 2)
        {
            shader_set_track(sh_better_scaling_supersampling_2x2);
            shader_set_uniform_f(shader_get_uniform(sh_better_scaling_supersampling_2x2, "offset"), offset_x, offset_y);
        }
        else if (max_samples <= 3)
        {
            shader_set_track(sh_better_scaling_supersampling_3x3);
            shader_set_uniform_f(shader_get_uniform(sh_better_scaling_supersampling_3x3, "offset"), offset_x, offset_y);
        }
        else
        {
            shader_set_track(sh_better_scaling_supersampling_4x4);
            shader_set_uniform_f(shader_get_uniform(sh_better_scaling_supersampling_4x4, "offset"), offset_x, offset_y);
        }
        
        texture_set_interpolation(true);
    }
    
    draw_surface_ext(argument[0], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7]);
    
    if (scale_up || scale_down)
    {
        if (scale_up)
            texture_set_interpolation(true);
        
        shader_reset_track();
    }
}
