var viewy = getViewy(global.cam) + 32;
var middley = viewy + (global.viewHeight / 2);
var persepectivePoint = middley;
var perspectiveDepth = -10;
var _drawy = y - ((persepectivePoint - y) / perspectiveDepth);
draw_sprite_ext(sprite_index, image_index, x, _drawy, 0.1, 0.1, 0, c_white, 1);
