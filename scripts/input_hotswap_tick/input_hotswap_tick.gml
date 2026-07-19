function input_hotswap_tick()
{
    var _player_index = (argument_count > 0 && argument[0] != undefined) ? argument[0] : 0;
    
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= 4)
    {
        __input_error("Player index too large (", _player_index, " vs. ", 4, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    with (global.__input_players[_player_index])
    {
        if (last_input_time < 0 || (current_time - last_input_time) > 33)
        {
            var _new_device = __input_hotswap_tick_input(_player_index);
            
            if (_new_device.source != UnknownEnum.Value_0)
            {
                input_player_source_set(_new_device.source, _player_index);
                
                if (_new_device.source == UnknownEnum.Value_2)
                    input_player_gamepad_set(_new_device.gamepad, _player_index);
                
                return true;
            }
        }
    }
    
    return false;
}

function __input_hotswap_tick_input(arg0)
{
    if (global.__input_keyboard_valid && __input_source_is_available(UnknownEnum.Value_1) && keyboard_check(vk_anykey))
    {
        return 
        {
            source: UnknownEnum.Value_1,
            gamepad: undefined
        };
    }
    else if (global.__input_mouse_valid && __input_source_is_available(UnknownEnum.Value_1) && ((true && global.__input_mouse_moved) || device_mouse_check_button(0, mb_any) || mouse_wheel_up() || mouse_wheel_down()))
    {
        return 
        {
            source: UnknownEnum.Value_1,
            gamepad: undefined
        };
    }
    else if (global.__input_gamepad_valid && os_type != os_android)
    {
        var _g = 0;
        
        repeat (gamepad_get_device_count())
        {
            if (gamepad_is_connected(_g) && __input_source_is_available(UnknownEnum.Value_2, _g))
            {
                if (input_gamepad_check(_g, 32769) || input_gamepad_check(_g, 32770) || input_gamepad_check(_g, 32771) || input_gamepad_check(_g, 32772) || input_gamepad_check(_g, 32781) || input_gamepad_check(_g, 32782) || input_gamepad_check(_g, 32783) || input_gamepad_check(_g, 32784) || input_gamepad_check(_g, 32773) || input_gamepad_check(_g, 32774) || input_gamepad_check(_g, 32775) || input_gamepad_check(_g, 32776) || input_gamepad_check(_g, 32778) || input_gamepad_check(_g, 32777) || input_gamepad_check(_g, 32779) || input_gamepad_check(_g, 32780) || (false && input_gamepad_check(_g, 32789)) || (false && input_gamepad_check(_g, 32790)) || (true && abs(input_gamepad_value(_g, 32785)) > input_axis_threshold_get(32785, arg0).mini) || (true && abs(input_gamepad_value(_g, 32786)) > input_axis_threshold_get(32786, arg0).mini) || (true && abs(input_gamepad_value(_g, 32787)) > input_axis_threshold_get(32787, arg0).mini) || (true && abs(input_gamepad_value(_g, 32788)) > input_axis_threshold_get(32788, arg0).mini))
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
