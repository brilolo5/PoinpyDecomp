function drawSquircleWithOutline(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
{
    if (arg7 > 0)
        drawSquircle(arg0 - arg7, arg1 - arg7, arg2 + arg7, arg3 + arg7, arg4, arg6, 1);
    
    drawSquircle(arg0, arg1, arg2, arg3, arg4 - arg7, arg5, 1);
}
