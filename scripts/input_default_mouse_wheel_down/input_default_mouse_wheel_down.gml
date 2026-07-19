function input_default_mouse_wheel_down()
{
    var _verb = argument[0];
    var _alternate = (argument_count > 1 && argument[1] != undefined) ? argument[1] : 0;
    global.__input_mouse_valid = true;
    global.__input_default_player.set_binding(UnknownEnum.Value_1, _verb, _alternate, new __input_class_binding("mouse wheel down"));
    var _p = 0;
    
    repeat (4)
    {
        global.__input_players[_p].set_binding(UnknownEnum.Value_1, _verb, _alternate, new __input_class_binding("mouse wheel down"));
        _p++;
    }
}
