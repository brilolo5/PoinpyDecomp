function draw_throw_arc()
{
    var xi = argument[0];
    var yi = argument[1];
    var hi = argument[2];
    var vi = argument[3];
    var a = argument[4] / 2;
    var tstep = argument[5];
    var object = argument[6];
    var have_max = argument_count == 8;
    var max_vel = 0;
    
    if (have_max)
        max_vel = argument[7];
    
    var prevx = xi;
    var prevy = yi;
    var nextx = xi;
    var nexty = yi;
    
    if (tstep <= 0)
        return false;
    
    for (var t = 0; nexty < room_height; t += tstep)
    {
        nextx = (t * hi) + xi;
        nexty = calculate_y(have_max, max_vel, t, vi, yi, a, prevy);
        
        if (collision_line(nextx, nexty, prevx, prevy, object, false, true))
        {
            t -= tstep;
            nextx = prevx;
            nexty = prevy;
            
            do
            {
                draw_line(nextx, nexty, prevx, prevy);
                prevx = nextx;
                prevy = nexty;
                t += (tstep / 4);
                nextx = (t * hi) + xi;
                nexty = calculate_y(have_max, max_vel, t, vi, yi, a, prevy);
            }
            until (collision_line(nextx, nexty, prevx, prevy, object, false, true));
            
            break;
        }
        
        draw_line(nextx, nexty, prevx, prevy);
        prevx = nextx;
        prevy = nexty;
    }
    
    return true;
}
