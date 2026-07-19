function draw_throw_bounce()
{
    var xi = argument[0];
    var yi = argument[1];
    var hi = argument[2];
    var vi = argument[3];
    var a = argument[4] / 2;
    var tstep = argument[5];
    var object = argument[6];
    var hbounce = argument[7];
    var vbounce = argument[8];
    var prec = argument[9];
    var quick = argument[10];
    var tmax = 150;
    var max_vel = 0;
    var have_max = argument_count == 13;
    
    if (have_max)
        max_vel = argument[12];
    
    if (argument_count >= 12)
        tmax = argument[11];
    
    var prevx = xi;
    var prevy = yi;
    var nextx = xi;
    var nexty = yi;
    var ab_t = 0;
    var staley = false;
    var coll = -4;
    
    if (tstep <= 0)
        return false;
    
    for (var t = 0; abs(ab_t) < tmax; t += tstep)
    {
        nextx = (t * hi) + xi;
        
        if (!staley)
            nexty = calculate_y(have_max, max_vel, t, vi, yi, a, prevy);
        
        coll = collision_line(prevx, prevy, nextx, nexty, object, prec, true);
        
        if (coll != -4)
        {
            var pdx = nextx - prevx;
            var pdy = nexty - prevy;
            var counter = 0;
            t -= tstep;
            nextx = prevx;
            nexty = prevy;
            
            if (!quick)
                coll = object;
            
            do
            {
                draw_line(nextx, nexty, prevx, prevy);
                prevx = nextx;
                prevy = nexty;
                t += (tstep / 4);
                ab_t += (tstep / 4);
                counter++;
                nextx = (t * hi) + xi;
                
                if (!staley)
                    nexty = calculate_y(have_max, max_vel, t, vi, yi, a, prevy);
            }
            until (counter == 5 || collision_line(prevx, prevy, nextx, nexty, coll, prec, true));
            
            var ydir = 0;
            var xdir = 0;
            var dx = nextx - prevx;
            var dy = nexty - prevy;
            
            if (collision_point(prevx + dx, prevy, object, prec, true))
                xdir = 1;
            
            if (collision_point(prevx, prevy + dy, object, prec, true))
                ydir = 1;
            
            if (xdir)
                hi = -hi * hbounce;
            
            if (ydir)
            {
                vi = -sign(dy) * abs((pdy * vbounce) / tstep);
                
                if (pdy > 0 && vi > -0.5)
                    staley = true;
            }
            else
            {
                vi = pdy / tstep;
            }
            
            coll = -4;
            xi = prevx;
            yi = prevy;
            nextx = prevx;
            nexty = prevy;
            t = 0;
        }
        else
        {
            draw_line(nextx, nexty, prevx, prevy);
            prevx = nextx;
            prevy = nexty;
            ab_t += tstep;
        }
    }
    
    return true;
}
