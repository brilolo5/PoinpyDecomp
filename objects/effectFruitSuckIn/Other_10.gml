suckInTimer = approach(suckInTimer, 1, doDelta(0.1111111111111111));
var _suck = 1 - suckInTimer;
var _playerx = x;
var _playery = y;

with (oPlayer)
{
    _playerx = x;
    _playery = y;
}

dir2p = point_direction(x, y, _playerx, _playery);
dir = dir2p + 90;
dist = point_distance(x, y, _playerx, _playery);
var _spriteHeight = sprite_get_height(sprite_index);
var _spriteExtendScale = (((dist / _spriteHeight) * 1) / 10) * _suck;
var _drawx = _playerx - lengthdir_x((dist / 2) * _suck, dir2p);
var _drawy = _playery - lengthdir_y((dist / 2) * _suck, dir2p);
draw_sprite_ext(spriteIndex, imgIndex, _drawx, _drawy, xscale * 0.75, _spriteExtendScale, dir, c_white, 1);
myAlarm0.tick();
