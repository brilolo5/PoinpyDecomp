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
    var current_speed = sqrt((xsp * xsp) + (ysp * ysp));
    dir = point_direction(x, y, target.x, target.y) - 180;
    xsp = current_speed * dcos(dir);
    ysp = current_speed * dsin(-dir);
}
