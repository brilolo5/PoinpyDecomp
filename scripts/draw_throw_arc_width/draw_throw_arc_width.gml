function draw_throw_arc_width()
{
    var xi = argument[0];
    var yi = argument[1];
    var hi = argument[2];
    var vi = argument[3];
    var a = argument[4] / 2;
    var tstep = argument[5];
    var object = argument[6];
    var w = argument[7] / 2;
    var have_max = argument_count == 9;
    var max_vel = 0;
    
    if (have_max)
        max_vel = argument[8];
    
    var prevx = xi;
    var prevy = yi;
    var nextx = xi;
    var nexty = yi;
    var degs = 0;
    
    if (tstep <= 0)
        return false;
    
    draw_primitive_begin(pr_trianglestrip);
    
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
                if (nextx != prevx || nexty != prevy)
                {
                    degs = point_direction(nextx, nexty, prevx, prevy);
                    draw_vertex(nextx + lengthdir_x(w, degs + 90), nexty + lengthdir_y(w, degs + 90));
                    draw_vertex(nextx + lengthdir_x(w, degs - 90), nexty + lengthdir_y(w, degs - 90));
                }
                
                prevx = nextx;
                prevy = nexty;
                t += (tstep / 4);
                nextx = (t * hi) + xi;
                nexty = calculate_y(have_max, max_vel, t, vi, yi, a, prevy);
            }
            until (collision_line(nextx, nexty, prevx, prevy, object, false, true));
            
            break;
        }
        
        degs = point_direction(nextx, nexty, prevx, prevy);
        draw_vertex(prevx + lengthdir_x(w, degs + 90), prevy + lengthdir_y(w, degs + 90));
        draw_vertex(prevx + lengthdir_x(w, degs - 90), prevy + lengthdir_y(w, degs - 90));
        prevx = nextx;
        prevy = nexty;
    }
    
    draw_primitive_end();
    return true;
}
