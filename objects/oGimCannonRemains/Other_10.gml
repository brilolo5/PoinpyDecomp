var viewy = getViewy(global.cam) + 32;
var middley = viewy + (global.viewHeight / 2);
var _drawy = y;
draw_sprite_ext(spriteIndex, 0, x, _drawy, 0.1 * image_xscale, 0.1 * image_yscale, -cannonAngle / 2, c_white, 1);
draw_sprite_ext(spriteIndex, 1, x, _drawy, 0.1 * image_xscale, 0.1 * image_yscale, cannonAngle, c_white, 1);
draw_sprite_ext(spriteIndex, 2, x, _drawy, 0.1 * image_xscale, 0.1 * image_yscale, 0, c_white, 1);
