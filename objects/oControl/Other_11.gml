if (live_call())
    return global.live_result;

var _wCenter = global.windowCenterx;
var _wMiddle = global.windowMiddley;
var _wLeft = global.windowLeft;
var _wRight = global.windowRight;
var _wTop = global.windowTop + 3;
var _wBottom = global.windowBottom;
var viewx = getViewx(global.cam);
var xcenter = global.windowCenterx;
var xLeft = xcenter - ((global.viewWidth / 4) + 5);
var xRight = xcenter + ((global.viewWidth / 4) + 4);
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
drawSetAlign(1, 1);

if (drawFps)
{
    drawSetAlign(0, 2);
    var _text = string(fps) + "\n" + string(fps_real) + "\n" + string(instance_count) + "\n" + string(getViewy(global.cam));
    drawTextShaded(0, global.viewHeight, _text, 16777215, make_color_rgb(46, 50, 59), 0);
    var _gameTime = global.oneGameTime div 60;
    var _gameTimeMinute = _gameTime div 60;
    var _gameTimeSecs = _gameTime % 60;
    
    if (_gameTimeSecs < 10)
        _gameTimeSecs = "0" + string(_gameTimeSecs);
    
    var _gameTimeText = "time:" + string(_gameTimeMinute) + ":" + string(_gameTimeSecs);
    drawTextShaded(0, global.viewHeight - 128, _gameTimeText, 16777215, make_color_rgb(46, 50, 59), 0);
    show_debug_overlay(1);
}

if (drawNotch)
{
    draw_set_color(make_color_rgb(46, 50, 59));
    draw_rectangle(xLeft, 0, xRight, global.notchOffset, 0);
}
