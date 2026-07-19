function better_scaling_draw_sprite()
{
    var scale_up = (argument[4] > 1 || argument[5] > 1) && argument[9] != 0;
    var scale_down = argument[4] < 1 || argument[5] < 1;
    
    if (scale_up)
    {
        var texture = sprite_get_texture(argument[0], argument[1]);
        
        switch (argument[9])
        {
            case 1:
                shader_set_track(sh_better_scaling_bicubic);
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_bicubic, "texel_size"), texture_get_texel_width(texture), texture_get_texel_height(texture));
                texture_set_interpolation(true);
                break;
            
            case 2:
                shader_set_track(sh_better_scaling_hq4x);
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_hq4x, "texel_size"), texture_get_texel_width(texture), texture_get_texel_height(texture));
                texture_set_interpolation(false);
                break;
            
            case 3:
                shader_set_track(sh_better_scaling_5xbra);
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbra, "texel_size"), texture_get_texel_width(texture), texture_get_texel_height(texture));
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbra, "texture_size"), 1 / texture_get_texel_width(texture), 1 / texture_get_texel_height(texture));
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbra, "color"), color_get_red(argument[7]) / 255, color_get_green(argument[7]) / 255, color_get_blue(argument[7]) / 255, argument[8]);
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbra, "color_to_make_transparent"), -1, -1, -1);
                texture_set_interpolation(false);
                break;
            
            case 4:
                shader_set_track(sh_better_scaling_5xbrb);
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbrb, "texel_size"), texture_get_texel_width(texture), texture_get_texel_height(texture));
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbrb, "texture_size"), 1 / texture_get_texel_width(texture), 1 / texture_get_texel_height(texture));
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbrb, "color"), color_get_red(argument[7]) / 255, color_get_green(argument[7]) / 255, color_get_blue(argument[7]) / 255, argument[8]);
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbrb, "color_to_make_transparent"), -1, -1, -1);
                texture_set_interpolation(false);
                break;
            
            case 5:
                shader_set_track(sh_better_scaling_5xbrc);
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbrc, "texel_size"), texture_get_texel_width(texture), texture_get_texel_height(texture));
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbrc, "texture_size"), 1 / texture_get_texel_width(texture), 1 / texture_get_texel_height(texture));
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbrc, "color"), color_get_red(argument[7]) / 255, color_get_green(argument[7]) / 255, color_get_blue(argument[7]) / 255, argument[8]);
                shader_set_uniform_f(shader_get_uniform(sh_better_scaling_5xbrc, "color_to_make_transparent"), -1, -1, -1);
                texture_set_interpolation(false);
                break;
        }
    }
    else if (scale_down)
    {
        var texture = sprite_get_texture(argument[0], argument[1]);
        var width = sprite_get_width(argument[0]);
        var height = sprite_get_height(argument[0]);
        var samples_x;
        
        if (argument[4] == 0)
            samples_x = width;
        else
            samples_x = min(width, 1 / argument[4]);
        
        var samples_y;
        
        if (argument[5] == 0)
            samples_y = height;
        else
            samples_y = min(height, 1 / argument[5]);
        
        var max_samples = max(samples_x, samples_y);
        var offset_x = texture_get_texel_width(texture) * samples_x * 0.5;
        var offset_y = texture_get_texel_height(texture) * samples_y * 0.5;
        
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
    
    draw_sprite_ext(argument[0], argument[1], argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8]);
    
    if (scale_up || scale_down)
    {
        if (scale_up)
            texture_set_interpolation(true);
        
        shader_reset_track();
    }
}
