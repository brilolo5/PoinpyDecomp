function deltaLerp(arg0, arg1, arg2)
{
    var _l = arg1 + ((arg0 - arg1) * power(1 - arg2, global.deltaTimeRate));
    return _l;
}
