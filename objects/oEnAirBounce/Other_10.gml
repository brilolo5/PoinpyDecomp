var _floory = ystart - 8;
var _lineWidth = (1 - (abs(y - _floory) / 48)) * 32;
_lineWidth = clamp(_lineWidth, 8, 20);
var _handy = bbox_top + 6;

if (y < _floory)
    _handy = bbox_bottom - 2;

if (inRange(y, _floory, 4))
    _handy = y;

var _ropeFrame = 1;

if (abs(y - _floory) < 32)
    _ropeFrame = 2;
else
    _ropeFrame = 1;

handyLerp = lerp(handyLerp, _handy, 0.5);
draw_set_color(make_color_rgb(46, 50, 59));
draw_sprite_ext(sEnemyBungeeBoyRope_knot, 0, x, _floory, xscale, yscale, imageAngle * xDirection, c_white, 1);
drawSpriteSetSize(sEnemyBungeeBoyRope, _ropeFrame, x, _floory, _lineWidth, handyLerp - _floory);
imageIndex = ((ystart - y) / 12) + 11;
draw_sprite_ext(spriteIndex, imageIndex, x + dcx, y + dcy, xscale, yscale, imageAngle * xDirection, c_white, 1);
