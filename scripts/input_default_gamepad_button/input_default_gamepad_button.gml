function input_default_gamepad_button()
{
    var _button = argument[0];
    var _verb = argument[1];
    var _alternate = (argument_count > 2 && argument[2] != undefined) ? argument[2] : 0;
    
    if (1 && _button == 32789)
        __input_error("gp_guide not permitted\nSet INPUT_SDL2_ALLOW_GUIDE to <true> to allow gp_guide");
    
    if (1 && _button == 32790)
        __input_error("gp_misc1 not permitted\nSet INPUT_SDL2_ALLOW_MISC1 to <true> to allow gp_misc1");
    
    global.__input_gamepad_valid = true;
    
    if (global.__input_swap_ab)
    {
        if (_button == 32769)
        {
            _button = 32770;
            __input_trace("Default binding for \"", _verb, "\" swapped from A/O to B/X");
        }
        else if (_button == 32770)
        {
            _button = 32769;
            __input_trace("Default binding for \"", _verb, "\" swapped from B/X to A/O");
        }
    }
    
    global.__input_default_player.set_binding(UnknownEnum.Value_2, _verb, _alternate, new __input_class_binding("gamepad button", _button));
    var _p = 0;
    
    repeat (4)
    {
        global.__input_players[_p].set_binding(UnknownEnum.Value_2, _verb, _alternate, new __input_class_binding("gamepad button", _button));
        _p++;
    }
}
