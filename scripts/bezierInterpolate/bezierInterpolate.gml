function bezierInterpolate(arg0, arg1, arg2, arg3, arg4)
{
    var _inv_t = 1 - arg0;
    return (_inv_t * _inv_t * _inv_t * arg1) + (3 * _inv_t * _inv_t * arg0 * arg2) + (3 * _inv_t * arg0 * arg0 * arg3) + (arg0 * arg0 * arg0 * arg4);
}
