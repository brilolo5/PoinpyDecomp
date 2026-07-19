var _centerx = getViewx(global.cam) + guiGetCenter();
var _middley = getViewy(global.cam) + guiGetMiddle();
draw_set_color(make_color_rgb(46, 50, 59));
draw_set_alpha(shadeAlpha);
drawRectFromCenter(_centerx, _middley, global.viewWidth, global.viewHeight, 0);
draw_set_alpha(1);
draw_set_color(c_white);
