function drawSpriteSize(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
{
    var _scale = min(arg4 / sprite_get_width(arg0), arg4 / sprite_get_height(arg0));
    draw_sprite_ext(arg0, arg1, arg2, arg3, _scale, _scale, arg5, arg6, arg7);
}
