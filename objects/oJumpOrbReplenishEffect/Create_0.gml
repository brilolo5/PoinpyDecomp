event_inherited();
cx = 0;
cy = 0;
xscale = 24 / sprite_get_width(sprite_index);
yscale = 8 / sprite_get_width(sprite_index);
imageAngle = 0;
pause = 6;
x = oPlayer.x - sign(oPlayer.x - (room_width / 2));
y = oPlayer.y + 16;

if (instance_exists(oPlayer))
{
    var _destx = oPlayer.x;
    var _desty = oPlayer.y - 20;
    angleFromPlayer = point_direction(_destx, _desty, x, y);
    var _angleDif = angle_difference(angleFromPlayer, 90);
    clockwise = (_angleDif > 0) ? 1 : -1;
    var _angleFrames = 10;
    var _closeInFrames = _angleFrames * 2;
    angleSpeed = -(_angleDif / _angleFrames);
    distanceFromPlayer = point_distance(_destx, _desty, x, y);
    closeInSpeed = distanceFromPlayer / _closeInFrames;
}
else
{
    instance_destroy();
}

var _xoffset = lengthdir_x(distanceFromPlayer, angleFromPlayer);
var _yoffset = lengthdir_y(distanceFromPlayer, angleFromPlayer);
px = _xoffset;
py = _yoffset;
