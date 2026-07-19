var viewy = getViewy(global.cam) + 32;
var middley = viewy + (global.viewHeight / 2);
var persepectivePoint = middley;
var perspectiveDepth = -10;
var _drawy = y;
draw_sprite_ext(spriteIndex, imageIndex, x, _drawy, 0.1 * image_xscale, 0.1 * image_yscale, 0, c_white, 1);
