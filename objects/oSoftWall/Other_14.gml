texture_set_interpolation(false);

if (onScreen)
{
    for (var _i = 0; _i < partIndex; _i += 1)
        draw_sprite_ext(sCloudWallPart, 1, partx[_i], party[_i], 0.1, 0.1, 0, wallColor, 1);
}

texture_set_interpolation(true);
