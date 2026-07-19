var _targetTimescale = 0;
var _shift = (global.timeScale - _targetTimescale) * 0.1;
timeScaleChange(_targetTimescale, 1, _shift);

if (!endingResult && global.difficultyLevel >= 25)
{
    timeScaleChange(1, 3, 1);
    instance_destroy();
}
else
{
    uiTick("results root");
    
    if (input_player_source_get() == UnknownEnum.Value_1)
    {
        uiFocusCursor("results root", device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), input_check("menu select"), input_check("menu back"));
    }
    else if (input_player_source_get() == UnknownEnum.Value_2)
    {
        var _dx = input_value("menu right") - input_value("menu left");
        var _dy = input_value("menu down") - input_value("menu up");
        uiFocusGamepad("results root", _dx, _dy, input_check("menu select"), input_check("menu back"));
    }
}
