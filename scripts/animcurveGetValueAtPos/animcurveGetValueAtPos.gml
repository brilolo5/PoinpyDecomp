function animcurveGetValueAtPos(arg0, arg1, arg2)
{
    var _animCurve = animcurve_get(arg0);
    var _animCurveChannel = animcurve_get_channel(_animCurve, arg1);
    var _animCurveIndex = animcurve_channel_evaluate(_animCurveChannel, arg2);
    return _animCurveIndex;
}

function animcurveGetValueAtPos_combine2(arg0, arg1, arg2, arg3, arg4, arg5)
{
    var _animCurveIndex;
    
    if (arg5 < arg4)
    {
        var _animCurve = animcurve_get(arg0);
        var _animCurveChannel = animcurve_get_channel(_animCurve, arg1);
        arg5 /= arg4;
        _animCurveIndex = animcurve_channel_evaluate(_animCurveChannel, arg5) / 2;
    }
    else
    {
        var _animCurve = animcurve_get(arg2);
        var _animCurveChannel = animcurve_get_channel(_animCurve, arg3);
        arg5 = (arg5 - arg4) / (1 - arg4);
        _animCurveIndex = (animcurve_channel_evaluate(_animCurveChannel, arg5) + 1) / 2;
    }
    
    return _animCurveIndex;
}
