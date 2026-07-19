function drawPillWithOutline(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    var _old_colour = draw_get_colour();
    
    if (arg6 > 0)
    {
        draw_set_colour(arg5);
        drawPill(arg0 - arg6, arg1 - arg6, arg2 + arg6, arg3 + arg6);
    }
    
    draw_set_colour(arg4);
    drawPill(arg0, arg1, arg2, arg3);
    draw_set_colour(_old_colour);
}
