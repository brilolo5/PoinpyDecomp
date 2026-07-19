function drawRectangleOutlineFast(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    if (arg6 > 0)
    {
        draw_sprite_stretched_ext(sUIPixel, 0, arg0, arg1, (arg6 + arg2) - arg0, arg6, arg4, arg5);
        draw_sprite_stretched_ext(sUIPixel, 0, arg0, arg1 + arg6, arg6, arg3 - arg1, arg4, arg5);
        draw_sprite_stretched_ext(sUIPixel, 0, arg0 + arg6, arg3, arg2 - arg0, arg6, arg4, arg5);
        draw_sprite_stretched_ext(sUIPixel, 0, arg2, arg1 + arg6, arg6, arg3 - arg1, arg4, arg5);
    }
}
