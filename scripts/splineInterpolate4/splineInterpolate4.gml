function splineInterpolate4(arg0, arg1, arg2, arg3, arg4)
{
    if (arg0 <= 0)
        return arg1;
    
    if (arg0 >= 1)
        return arg4;
    
    var _p01 = lerp(arg1, arg2, arg0);
    var _p12 = lerp(arg2, arg3, arg0);
    var _p23 = lerp(arg3, arg4, arg0);
    var _p0112 = lerp(_p01, _p12, arg0);
    var _p1223 = lerp(_p12, _p23, arg0);
    return lerp(_p0112, _p1223, arg0);
}
