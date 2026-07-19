function triangleWave(arg0, arg1)
{
    arg0 %= arg1;
    arg0 *= (2 / arg1);
    return (arg0 > 1) ? (2 - arg0) : arg0;
}
