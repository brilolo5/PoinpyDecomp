texture_set_interpolation(false);

if (onScreen)
{
    for (var _i = 0; _i < partIndex; _i += 1)
        draw_sprite_ext(sCloudWallPart, 0, partx[_i], party[_i], 0.1, 0.1, 0, wallColor, 1);
}

texture_set_interpolation(true);
draw_set_color(make_color_rgb(255, 255, 255));
draw_rectangle(fillerRectLeft, fillerRectTop, fillerRectRight, fillerRectBottom, 0);
