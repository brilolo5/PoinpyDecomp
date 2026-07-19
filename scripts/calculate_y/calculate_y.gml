function calculate_y(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    var have_max = arg0;
    var changey = 0;
    var max_vel = arg1;
    var nexty = 0;
    var t = arg2;
    var vi = arg3;
    var yi = arg4;
    var a = arg5;
    var prevy = arg6;
    
    if (have_max)
    {
        changey = (a * sqr(t)) + (vi * t) + yi;
        
        if (changey > (max_vel + yi))
            nexty = prevy + max_vel;
        else
            nexty = changey;
    }
    else
    {
        nexty = (a * sqr(t)) + (vi * t) + yi;
    }
    
    return nexty;
}
