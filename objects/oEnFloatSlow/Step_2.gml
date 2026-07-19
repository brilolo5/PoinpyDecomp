var current_speed;
var gts = global.timeScale;
cx += (xsp * global.timeScale);
cy += (ysp * global.timeScale);
var xspRound = floor(abs(cx)) * sign(cx);
var yspRound = floor(abs(cy)) * sign(cy);
cx -= xspRound;
cy -= yspRound;

repeat (abs(xspRound))
{
    target = instance_place(x + sign(xspRound), y, parentWall);
    
    if (target == -4)
    {
        x += sign(xspRound);
    }
    else
    {
        xsp *= -1;
        break;
    }
}

repeat (abs(yspRound))
{
    target = instance_place(x, y + sign(yspRound), parentWall);
    
    if (target == -4)
    {
        y += sign(yspRound);
    }
    else
    {
        ysp *= -1;
        break;
    }
    
    y += sign(yspRound);
}

target = instance_place(x, y, oEnemyHoming);

if (target)
{
    current_speed = sqrt((xsp * xsp) + (ysp * ysp));
    dir = point_direction(x, y, target.x, target.y) - 180;
    xsp = current_speed * dcos(dir);
    ysp = current_speed * dsin(-dir);
}

var _fric = fric * global.timeScale;
current_speed = sqrt((xsp * xsp) + (ysp * ysp));

if (current_speed > maxSpeed)
{
    xsp *= (maxSpeed / current_speed);
    ysp *= (maxSpeed / current_speed);
}

current_speed = sqrt((xsp * xsp) + (ysp * ysp));

if (current_speed > _fric)
{
    xsp *= ((current_speed - _fric) / current_speed);
    ysp *= ((current_speed - _fric) / current_speed);
}
else if (current_speed < -_fric)
{
    xsp *= ((current_speed + _fric) / current_speed);
    ysp *= ((current_speed + _fric) / current_speed);
}
else
{
    xsp = 0;
    ysp = 0;
}

xscale = xDirection * xShrink;
yscale = yDirection * yShrink;
