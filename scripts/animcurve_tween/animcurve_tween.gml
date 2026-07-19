function animcurve_tween(arg0, arg1, arg2, arg3)
{
    var _w = animcurve_channel_evaluate(animcurve_get_channel(arg2, 0), arg3);
    var _value = lerp(arg0, arg1, _w);
    return _value;
}
