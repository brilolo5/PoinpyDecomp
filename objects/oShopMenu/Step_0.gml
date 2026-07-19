var _targetTimescale = 0;
var _shift = (global.timeScale - _targetTimescale) * 0.025;
timeScaleChange(_targetTimescale, 1, _shift);
uiTick("shop root");

if (input_player_source_get() == UnknownEnum.Value_1)
{
    uiFocusCursor("shop root", device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), input_check("menu select"), input_check("menu back"));
}
else if (input_player_source_get() == UnknownEnum.Value_2)
{
    var _dx = input_value("menu right") - input_value("menu left");
    var _dy = input_value("menu down") - input_value("menu up");
    uiFocusGamepad("shop root", _dx, _dy, input_check("menu select"), input_check("menu back"));
}
