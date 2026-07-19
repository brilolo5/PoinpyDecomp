function input_tick()
{
    var _any_changed = false;
    global.__input_frame++;
    var _mouse_x = 0;
    var _mouse_y = 0;
    
    switch (1)
    {
        case 0:
            _mouse_x = device_mouse_x(0);
            _mouse_y = device_mouse_y(0);
            break;
        
        case 1:
            _mouse_x = device_mouse_x_to_gui(0);
            _mouse_y = device_mouse_y_to_gui(0);
            break;
        
        case 2:
            _mouse_x = device_mouse_raw_x(0);
            _mouse_y = device_mouse_raw_y(0);
            break;
        
        default:
            __input_error("Invalid mouse mode (", 1, ")");
            break;
    }
    
    global.__input_mouse_moved = point_distance(_mouse_x, _mouse_y, global.__input_mouse_x, global.__input_mouse_y) > 2;
    global.__input_mouse_x = _mouse_x;
    global.__input_mouse_y = _mouse_y;
    var _g = 0;
    
    repeat (array_length(global.__input_gamepads))
    {
        var _gamepad = global.__input_gamepads[_g];
        
        if (is_struct(_gamepad))
        {
            if (gamepad_is_connected(_g))
            {
                _gamepad.tick();
            }
            else
            {
                __input_trace("Gamepad ", _g, " disconnected");
                global.__input_gamepads[_g] = undefined;
                _p = 0;
                
                repeat (4)
                {
                    with (global.__input_players[_p])
                    {
                        if (gamepad == _g && source == UnknownEnum.Value_2)
                        {
                            __input_trace("Player ", _p, " gamepad disconnected");
                            source = UnknownEnum.Value_0;
                            _any_changed = true;
                        }
                    }
                    
                    _p++;
                }
            }
        }
        else if (gamepad_is_connected(_g))
        {
            __input_trace("Gamepad ", _g, " connected");
            __input_trace("New gamepad = \"", gamepad_get_description(_g), "\", GUID=\"", gamepad_get_guid(_g), "\"");
            global.__input_gamepads[_g] = new __input_class_gamepad(_g);
        }
        
        _g++;
    }
    
    var _p = 0;
    
    repeat (4)
    {
        global.__input_players[_p].tick();
        _p++;
    }
    
    return _any_changed;
}
