function bezierLength(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
{
    arg2 -= arg0;
    arg3 -= arg1;
    arg4 -= arg0;
    arg5 -= arg1;
    arg6 -= arg0;
    arg7 -= arg1;
    var _x1 = undefined;
    var _y1 = undefined;
    var _x2 = 0;
    var _y2 = 0;
    var _dist = 0;
    var _bezier_inc = 1 / (arg8 - 1);
    var _t = _bezier_inc;
    
    repeat (arg8 - 1)
    {
        var _inv_t = 1 - _t;
        _x1 = _x2;
        _y1 = _y2;
        _x2 = (3 * _inv_t * _inv_t * _t * arg2) + (3 * _inv_t * _t * _t * arg4) + (_t * _t * _t * arg6);
        _y2 = (3 * _inv_t * _inv_t * _t * arg3) + (3 * _inv_t * _t * _t * arg5) + (_t * _t * _t * arg7);
        var _dx = _x2 - _x1;
        var _dy = _y2 - _y1;
        _dist += sqrt((_dx * _dx) + (_dy * _dy));
        _t += _bezier_inc;
    }
    
    return _dist;
}
