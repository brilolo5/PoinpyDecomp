function map(arg0, arg1, arg2, arg3, arg4)
{
    var inr = arg2 - arg1;
    var outr = arg4 - arg3;
    return (((arg0 - arg1) * outr) / inr) + arg3;
}
