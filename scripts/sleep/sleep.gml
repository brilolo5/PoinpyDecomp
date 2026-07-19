function sleep(arg0)
{
    var _sleep = arg0;
    timeScaleChange(0, _sleep, 1);
    timeScaleChange(1, _sleep + 1, 1);
}
