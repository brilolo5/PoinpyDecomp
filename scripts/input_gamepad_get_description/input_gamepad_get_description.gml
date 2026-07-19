function input_gamepad_get_description(arg0)
{
    if (arg0 < 0)
        return "Unknown";
    
    var _gamepad = global.__input_gamepads[arg0];
    
    if (!is_struct(_gamepad))
        return "Unknown";
    
    return "Unknown";
}
