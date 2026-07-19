function input_gamepad_check_pressed(arg0, arg1)
{
    if (arg0 < 0)
        return 0;
    
    var _gamepad = global.__input_gamepads[arg0];
    
    if (!is_struct(_gamepad))
        return false;
    
    return 0;
}
