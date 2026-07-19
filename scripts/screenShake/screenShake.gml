function screenShake(arg0, arg1)
{
    with (oCamera)
    {
        if (arg0 > screenShakeAmount)
        {
            screenShakeAmount = arg0;
            screenShakeTimer = arg1;
        }
    }
}
