var _distance = point_distance(xstart, ystart, x, y);
var _dir2soul = point_direction(xstart, ystart, x, y);
var _distanceUnit = _distance / 6;
var _xOffset = lengthdir_x(_distanceUnit, _dir2soul);
var _yOffset = lengthdir_y(_distanceUnit, _dir2soul);

for (var i = 0; i < _distance; i += _distanceUnit)
    draw_circle(xstart + (_xOffset * (i / _distanceUnit)), ystart + (_yOffset * (i / _distanceUnit)), 2, 0);
