function input_default_gamepad_axis_pair()
{
    var _axis_x = argument[0];
    var _axis_y = argument[1];
    var _verb_x = argument[2];
    var _verb_y = argument[3];
    var _alternate = (argument_count > 4 && argument[4] != undefined) ? argument[4] : 0;
    global.__input_gamepad_valid = true;
    global.__input_default_player.set_binding(UnknownEnum.Value_2, _verb_x, _alternate, new __input_class_binding("gamepad axis pair", _axis_x, undefined, _axis_y));
    global.__input_default_player.set_binding(UnknownEnum.Value_2, _verb_y, _alternate, new __input_class_binding("gamepad axis pair", _axis_y, undefined, _axis_x));
    var _p = 0;
    
    repeat (4)
    {
        global.__input_players[_p].set_binding(UnknownEnum.Value_2, _verb_x, _alternate, new __input_class_binding("gamepad axis pair", _axis_x, undefined, _axis_y));
        global.__input_players[_p].set_binding(UnknownEnum.Value_2, _verb_y, _alternate, new __input_class_binding("gamepad axis pair", _axis_y, undefined, _axis_x));
        _p++;
    }
}
