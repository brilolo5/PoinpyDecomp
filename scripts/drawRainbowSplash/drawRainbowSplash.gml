function drawRainbowSplash(arg0, arg1, arg2, arg3)
{
    if (arg2 == 0)
        exit;
    
    arg2 *= 2;
    var _x1 = arg0 - 7;
    var _y1 = arg1 - 6;
    var _x2 = arg0 + 9;
    var _y2 = arg1 - 10;
    var _x3 = arg0 - 10;
    var _y3 = arg1 + 11;
    var _x4 = arg0 + 9;
    var _y4 = arg1 + 8;
    var _scale1 = arg2;
    var _scale2 = arg2;
    var _scale3 = arg2;
    var _scale4 = arg2;
    var _angle1 = 0 - (0.018 * arg3);
    var _angle2 = 90 - (0.015 * arg3);
    var _angle3 = 180 - (0.021 * arg3);
    var _angle4 = 270 - (0.012 * arg3);
    var _old_filter = gpu_get_tex_filter();
    gpu_set_tex_filter(false);
    draw_sprite_ext(sResultsRewardSplash, 0, _x1, _y1, _scale1, _scale1, _angle1, c_black, 1);
    draw_sprite_ext(sResultsRewardSplash, 0, _x2, _y2, _scale2, _scale2, _angle2, c_black, 1);
    draw_sprite_ext(sResultsRewardSplash, 0, _x3, _y3, _scale3, _scale3, _angle3, c_black, 1);
    draw_sprite_ext(sResultsRewardSplash, 0, _x4, _y4, _scale4, _scale4, _angle4, c_black, 1);
    gpu_set_blendmode(bm_max);
    draw_sprite_ext(sResultsRewardSplash, 0, _x2, _y2, _scale2, _scale2, _angle2, make_color_rgb(248, 45, 97), 1);
    draw_sprite_ext(sResultsRewardSplash, 0, _x4, _y4, _scale4, _scale4, _angle4, make_color_rgb(255, 233, 1), 1);
    draw_sprite_ext(sResultsRewardSplash, 0, _x3, _y3, _scale3, _scale3, _angle3, make_color_rgb(36, 145, 249), 1);
    draw_sprite_ext(sResultsRewardSplash, 0, _x1, _y1, _scale1, _scale1, _angle1, make_color_rgb(65, 231, 125), 1);
    gpu_set_blendmode(bm_normal);
    gpu_set_tex_filter(_old_filter);
}
