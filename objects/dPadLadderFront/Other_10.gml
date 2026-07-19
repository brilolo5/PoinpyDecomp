var viewy = getViewy(global.cam) + 32;
var middley = viewy + (global.viewHeight / 2);
var persepectivePoint = middley;
var perspectiveDepth = -10;
var _drawy = y + (16 * ((size - 1) / 2));

for (var i = 0; i < size; i += 1)
    draw_sprite_ext(sDetailPadLadderFront, i, x, _drawy - (i * 16), 0.1 * xDirection, 0.1, 0, c_white, 1);
