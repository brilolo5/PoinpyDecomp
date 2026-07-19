function juicebarDrawStraight(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
{
    var _w = (1 + arg2) - arg0;
    var _h = (1 + arg3) - arg1;
    var _x = arg0 + (arg4 * _w);
    drawRectangleLTRB(arg0, arg1, _x, arg3, arg7, arg8);
    
    if (arg5)
        juicebarDrawCapWave(_x, arg1, _x, arg3 + 1, arg6, arg7, arg8);
    else
        juicebarDrawCap(_x, arg1, _x, arg3, arg6, arg8);
}
