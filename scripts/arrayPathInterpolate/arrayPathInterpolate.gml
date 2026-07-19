function arrayPathInterpolate(arg0, arg1, arg2)
{
    arg0 = clamp(arg0, 0, 1);
    arg0 *= ((array_length(arg1) - 2) / 2);
    var _index = arg2 + (2 * floor(arg0));
    var _float = frac(arg0);
    
    if (_float == 0)
        return arg1[_index];
    
    return lerp(arg1[_index], arg1[_index + 2], _float);
}
