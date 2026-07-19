function splineBakeToArrayPath(arg0, arg1, arg2, arg3)
{
    var _out = array_create(2 * arg1);
    array_resize(_out, 0);
    var _incr = 1 / (arg1 - 1);
    var _t = 0;
    
    repeat (arg1)
    {
        var _point = splineInterpolate(_t, arg0);
        array_push(_out, _point[0], _point[1]);
        _t += _incr;
    }
    
    return _out;
}
