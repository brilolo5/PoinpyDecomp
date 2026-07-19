function getSpeed(arg0, arg1)
{
    var xsp = arg0;
    var ysp = arg1;
    var current_speed = sqrt((xsp * xsp) + (ysp * ysp));
    return current_speed;
}
