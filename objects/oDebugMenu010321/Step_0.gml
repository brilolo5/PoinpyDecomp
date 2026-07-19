uiTick("debug menu root");

if (input_player_source_get() == UnknownEnum.Value_1)
{
    uiFocusCursor("debug menu root", device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), input_check("menu select"), input_check("menu back"));
}
else if (input_player_source_get() == UnknownEnum.Value_2)
{
    var _dx = input_value("menu right") - input_value("menu left");
    var _dy = input_value("menu down") - input_value("menu up");
    uiFocusGamepad("debug menu root", _dx, _dy, input_check("menu select"), input_check("menu back"));
}

if (mouse_check_button_pressed(mb_right))
{
    saveGame();
    instance_destroy();
}
