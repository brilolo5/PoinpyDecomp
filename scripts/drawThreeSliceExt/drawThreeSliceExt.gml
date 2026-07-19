function drawThreeSliceExt(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    var _spriteWidth = arg4 * sprite_get_width(arg0);
    var _width = max(2 * _spriteWidth, (1 + arg2) - arg1);
    draw_sprite_ext(arg0, 0, arg1, arg3, arg4, arg4, 0, arg5, arg6);
    draw_sprite_stretched_ext(arg0, 1, arg1 + _spriteWidth, arg3 - (arg4 * sprite_get_yoffset(arg0)), _width - 1 - (2 * _spriteWidth), arg4 * sprite_get_height(arg0), arg5, arg6);
    draw_sprite_ext(arg0, 2, arg2 - _spriteWidth, arg3, arg4, arg4, 0, arg5, arg6);
}
