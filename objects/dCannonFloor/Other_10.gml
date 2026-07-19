var viewy = getViewy(global.cam) + 32;
var middley = viewy + (global.viewHeight / 2);
var persepectivePoint = middley;
var perspectiveDepth = -10;
var _drawy = y;
xDirection = 1;
draw_sprite_ext(spriteIndex, 1, cornerOrigin, _drawy, 0.1 * xDirection, 0.1 * image_yscale, 0, c_white, 1);
var i;

for (i = 0; i < size; i += 1)
    draw_sprite_ext(spriteIndex, 0, cornerOrigin + (16 * i * xDirection), _drawy, 0.1 * xDirection * -1, 0.1 * image_yscale, 0, c_white, 1);

i -= 1;
draw_sprite_ext(spriteIndex, 1, cornerOrigin + (16 * i * xDirection), _drawy, 0.1 * xDirection * -1, 0.1 * image_yscale, 0, c_white, 1);
