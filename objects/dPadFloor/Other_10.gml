var viewy = getViewy(global.cam) + 32;
var middley = viewy + (global.viewHeight / 2);
var persepectivePoint = middley;
var perspectiveDepth = -10;
var _drawy = y;
draw_sprite_ext(sDetailPadFloorLeft, 0, cornerOrigin, _drawy, 0.1 * xDirection, 0.1 * image_yscale, 0, c_white, 1);
var i;

for (i = 1; i < (size - 1); i += 1)
    draw_sprite_ext(sDetailPadFloorMid, i - 1, cornerOrigin + (16 * i * xDirection), _drawy, 0.1 * xDirection, 0.1 * image_yscale, 0, c_white, 1);

draw_sprite_ext(sDetailPadFloorRight, i, cornerOrigin + (16 * (size - 1)), _drawy, 0.1 * xDirection, 0.1 * image_yscale, 0, c_white, 1);
