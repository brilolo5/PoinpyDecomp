function collisionLinePoint(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
{
    var x1 = arg0;
    var y1 = arg1;
    var x2 = arg2;
    var y2 = arg3;
    var qi = arg4;
    var qp = arg5;
    var qn = arg6;
    var rr = collision_line(x1, y1, x2, y2, qi, qp, qn);
    var rx = x2;
    var ry = y2;
    
    if (rr != -4)
    {
        var p0 = 0;
        var p1 = 1;
        
        repeat (ceil(log2(point_distance(x1, y1, x2, y2))) + 1)
        {
            var np = p0 + ((p1 - p0) * 0.5);
            var nx = x1 + ((x2 - x1) * np);
            var ny = y1 + ((y2 - y1) * np);
            var px = x1 + ((x2 - x1) * p0);
            var py = y1 + ((y2 - y1) * p0);
            var nr = collision_line(px, py, nx, ny, qi, qp, qn);
            
            if (nr != -4)
            {
                rr = nr;
                rx = nx;
                ry = ny;
                p1 = np;
            }
            else
            {
                p0 = np;
            }
        }
    }
    
    var r;
    r[0] = rr;
    r[1] = rx;
    r[2] = ry;
    return r;
}
