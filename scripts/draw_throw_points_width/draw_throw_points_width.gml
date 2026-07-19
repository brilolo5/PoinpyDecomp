function draw_throw_points_width()
{
    var xi = argument[0];
    var yi = argument[1];
    var xf = argument[2];
    var yf = argument[3];
    var hv = argument[5];
    var a = argument[6] / 2;
    var tstep = argument[7];
    var object = argument[8];
    var w = argument[9] / 2;
    var prevx = xi;
    var prevy = yi;
    var nextx = xi;
    var nexty = yi;
    var changey = 0;
    var tf = 0;
    var sf = 0;
    var dy = yf - yi;
    var dx = xf - xi;
    
    if (tstep == 0)
        return false;
    
    var hi, vi;
    
    if (!hv)
    {
        vi = argument[4];
        
        if ((sqr(vi) + (4 * a * dy)) < 0)
        {
            vi = sqrt(-4 * a * dy) + 0.1;
            tstep = -tstep;
        }
        
        if (hv == 0)
            tf = (-vi + sqrt(sqr(vi) + (4 * a * dy))) / (2 * a);
        else
            tf = (-vi - sqrt(sqr(vi) + (4 * a * dy))) / (2 * a);
        
        if (tf == 0)
            return false;
        
        hi = dx / tf;
    }
    else
    {
        hi = argument[4];
        tf = dx / hi;
        
        if (tf == 0)
            return false;
        
        vi = (dy - (a * sqr(tf))) / tf;
        
        if ((hi < 0 && dx > 0) || (hi > 0 && dx < 0))
            tstep = -tstep;
    }
    
    draw_primitive_begin(pr_trianglestrip);
    
    for (var t = 0; nexty < room_height; t += tstep)
    {
        nextx = (t * hi) + xi;
        nexty = (a * sqr(t)) + (vi * t) + yi;
        
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
                nexty = (a * sqr(t)) + (vi * t) + yi;
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
    
    draw_vertex(nextx + lengthdir_x(w, degs + 90), nexty + lengthdir_y(w, degs + 90));
    draw_vertex(nextx + lengthdir_x(w, degs - 90), nexty + lengthdir_y(w, degs - 90));
    draw_primitive_end();
    return true;
}
