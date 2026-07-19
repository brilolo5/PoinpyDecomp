function input_assignment_tick(arg0, arg1, arg2)
{
    if (arg1 < 1)
    {
        __input_error("Invalid maximum player count provided (", arg1, ")");
        return undefined;
    }
    
    if (arg1 > 4)
    {
        __input_error("Maximum player count too large (", arg1, " vs. ", 4, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    if (arg0 < 1)
    {
        __input_error("Invalid minimum player count provided (", arg0, ")");
        return undefined;
    }
    
    if (arg0 > 4)
    {
        __input_error("Minimum player count larger than maximum (", arg0, " vs. ", arg1, ")");
        return undefined;
    }
    
    var _abort = false;
    var _fail;
    
    do
    {
        _fail = false;
        _p = 3;
        
        repeat (3)
        {
            if (input_player_connected(_p) && !input_player_connected(_p - 1))
            {
                __input_trace("Assignment: Moving player ", _p, " (connected) to ", _p - 1, " (disconnected)");
                _fail = true;
                var _temp = global.__input_players[_p - 1];
                global.__input_players[_p - 1] = global.__input_players[_p];
                global.__input_players[_p] = _temp;
            }
            
            _p--;
        }
    }
    until (!_fail);
    
    var _p = arg1;
    
    repeat (4 - arg1)
    {
        input_player_source_set(UnknownEnum.Value_0, _p);
        _p++;
    }
    
    _p = 0;
    
    repeat (arg1)
    {
        if (!input_player_connected(_p))
        {
            var _new_device = __input_assignment_tick_input(_p);
            
            if (_new_device.source != UnknownEnum.Value_0)
            {
                input_player_source_set(_new_device.source, _p);
                
                if (_new_device.source == UnknownEnum.Value_2)
                    input_player_gamepad_set(_new_device.gamepad, _p);
                
                __input_trace("Assignment: Player ", _p, " joined");
                global.__input_players[_p].tick();
                
                if (input_check_pressed(arg2) && input_players_connected() < arg0 && arg0 > 1)
                {
                    __input_trace("Assignment: Player ", _p, " aborted");
                    _abort = true;
                }
                
                input_consume(arg2, _p);
            }
        }
        
        _p++;
    }
    
    _p = 0;
    
    repeat (arg1)
    {
        if (input_check_pressed(arg2, _p))
        {
            __input_trace("Assignment: Player ", _p, " left");
            input_player_source_set(UnknownEnum.Value_0, _p);
        }
        
        _p++;
    }
    
    return _abort;
}

function __input_assignment_tick_input(arg0)
{
    if (global.__input_keyboard_valid && __input_source_is_available(UnknownEnum.Value_1) && keyboard_check_pressed(vk_anykey))
    {
        return 
        {
            source: UnknownEnum.Value_1,
            gamepad: undefined
        };
    }
    else if (global.__input_mouse_valid && __input_source_is_available(UnknownEnum.Value_1) && (device_mouse_check_button_pressed(0, mb_any) || mouse_wheel_up() || mouse_wheel_down()))
    {
        return 
        {
            source: UnknownEnum.Value_1,
            gamepad: undefined
        };
    }
    else if (global.__input_gamepad_valid)
    {
        var _g = 0;
        
        repeat (gamepad_get_device_count())
        {
            if (gamepad_is_connected(_g) && __input_source_is_available(UnknownEnum.Value_2, _g))
            {
                if (input_gamepad_check_pressed(_g, 32769) || input_gamepad_check_pressed(_g, 32770) || input_gamepad_check_pressed(_g, 32771) || input_gamepad_check_pressed(_g, 32772) || input_gamepad_check_pressed(_g, 32781) || input_gamepad_check_pressed(_g, 32782) || input_gamepad_check_pressed(_g, 32783) || input_gamepad_check_pressed(_g, 32784) || input_gamepad_check_pressed(_g, 32773) || input_gamepad_check_pressed(_g, 32774) || input_gamepad_check_pressed(_g, 32775) || input_gamepad_check_pressed(_g, 32776) || input_gamepad_check_pressed(_g, 32778) || input_gamepad_check_pressed(_g, 32777) || input_gamepad_check_pressed(_g, 32779) || input_gamepad_check_pressed(_g, 32780) || (false && input_gamepad_check(_g, 32789)) || (false && input_gamepad_check(_g, 32790)))
                {
                    return 
                    {
                        source: UnknownEnum.Value_2,
                        gamepad: _g
                    };
                }
            }
            
            _g++;
        }
    }
    
    return 
    {
        source: UnknownEnum.Value_0,
        gamepad: -1
    };
}
