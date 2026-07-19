var viewy = getViewy(global.cam) + 32;
var middley = viewy + (global.viewHeight / 2);
var persepectivePoint = middley;
var perspectiveDepth = -10;
var _drawy = y;
spriteIndex = sprite_index;
var _spriteNumber = sprite_get_number(spriteIndex);
imageIndex += doDelta(0.175);

if (imageIndex >= _spriteNumber)
{
    imageIndex -= _spriteNumber;
    image_xscale *= -1;
}

draw_sprite_ext(spriteIndex, imageIndex, x, _drawy - 0.5, image_xscale, image_yscale, 0, c_white, 1);
