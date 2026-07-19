if (!active)
{
    if (abs(y - oPlayer.y) < activationRange)
        active = 1;
}

if (active)
{
    dir = point_direction(x, y, oPlayer.x, oPlayer.y);
    xsp += (accel * dcos(dir));
    ysp += (accel * dsin(-dir));
    var current_speed = sqrt((xsp * xsp) + (ysp * ysp));
    
    if (current_speed > maxSpeed)
    {
        xsp *= (maxSpeed / current_speed);
        ysp *= (maxSpeed / current_speed);
    }
}

if (xsp != 0)
    xdirection = sign(xsp);
