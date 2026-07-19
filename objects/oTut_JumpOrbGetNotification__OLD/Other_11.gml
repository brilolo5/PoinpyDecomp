var xcenter = global.windowCenterx;
var wLeft = global.windowLeft;
var wRight = global.windowRight;
var _gameSurfaceTop = global.gameSurfaceTop;

if (surface_exists(printScreen))
    draw_surface_stretched(printScreen, wLeft, _gameSurfaceTop, global.viewWidth, global.viewHeight);

draw_set_color(make_color_rgb(46, 50, 59));
draw_set_alpha(0.3);
draw_rectangle(0, 0, 1000, 1000, 0);
draw_set_alpha(1);
var _vMargin = 12;
var _textLeftPos = wLeft + 16;
var _textTopPos = global.windowTop + 20;
var _textSize = 0.8;
drawSetAlign(0, 0);

function drawGuideText(arg0, arg1, arg2)
{
    scribble(arg2).starting_format(global.defaultFont, make_color_rgb(255, 255, 255)).blend(make_color_rgb(255, 255, 255), 1).msdf_border(make_color_rgb(46, 50, 59), 3).wrap(280, -1, locIsAsian()).transform(0.4, 0.4, 0).align(1, 1).draw(arg0, arg1);
}

var _drawx = xcenter;
var _drawy = global.windowMiddley;
drawGuideText(_drawx, _drawy, youGotItString);
var _jumpOrbSpr = 439;
var _orbScale = 0.15000000000000002 * (1 + (0.05 * sin(global.time / 25)));
draw_sprite_ext(sJumpCounts00, 0, _drawx, _drawy - 32, _orbScale, _orbScale, 0, c_white, 1);

if (mouse_check_button_released(mb_left))
{
    global.jumpTimes = global.jumpTimesMax;
    instance_destroy();
}
