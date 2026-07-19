function input_gamepad_get_type(arg0)
{
    if (arg0 < 0)
        return "unknown";
    
    var _gamepad = global.__input_gamepads[arg0];
    
    if (!is_struct(_gamepad))
        return "unknown";
    
    return "unknown";
}
