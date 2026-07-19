if (live_call())
    return global.live_result;

xscale = xscaleBase * xDirection * xShrink;
yscale = yscaleBase * yDirection * yShrink;
dcx = cx;
dcy = cy;
var gts = global.timeScale;
var cr = global.surfaceCompressionRate;
var _spriteWidth = (sprite_get_width(sprite_index) * 1) / 10;
var _spriteHeight = (sprite_get_height(sprite_index) * 1) / 10;
var _surfaceWidth = _spriteWidth * cr;
var _surfaceHeight = _spriteHeight * cr;
var _sOriginx = ((sprite_get_xoffset(sprite_index) * 1) / 10) * cr;
var _sOriginy = ((sprite_get_xoffset(sprite_index) * 1) / 10) * cr;
var _sDrawx = (x - (_sOriginx / cr)) + dcx;
var _sDrawy = (y - (_sOriginy / cr)) + dcy;
imageAngleTween += (-clockwiseOrNo * 1.75 * xDirection * gts);
var _roundBy = 90;
var _angleUnit = 360 / _roundBy;
var _imageAngleTweenRound = round((imageAngleTween / 360) * _roundBy) * _angleUnit;
var _x = x + dcx;
var _y = y + dcy;
var _neckLength = 13;
var _neckx = _x + lengthdir_x(_neckLength, _imageAngleTweenRound * xDirection);
var _necky = _y + lengthdir_y(_neckLength, _imageAngleTweenRound * xDirection);
var _pointArray = collisionLinePoint(_x, _y, _neckx, _necky, oWall, false, false);
draw_sprite_ext(sTentoBall_InnerBody, 1, _pointArray[1], _pointArray[2], xscale, yscale, (_imageAngleTweenRound * xDirection) - 90, c_white, 1);
draw_sprite_ext(sprite_index, 0, x + dcx, y + dcy, xscale * 1, yscale * 1, _imageAngleTweenRound * xDirection, c_white, 1);
