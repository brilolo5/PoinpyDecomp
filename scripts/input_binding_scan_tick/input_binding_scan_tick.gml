function input_binding_scan_tick()
{
    var _filter_source = (argument_count > 0) ? argument[0] : undefined;
    var _player_index = (argument_count > 1 && argument[1] != undefined) ? argument[1] : 0;
    
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
        global.__input_rebind_last_player = self;
        rebind_this_frame = true;
        
        if (rebind_state == -2)
        {
            return UnknownEnum.Value_m1;
        }
        else if (rebind_state == -1)
        {
            return UnknownEnum.Value_m2;
        }
        else if (rebind_state == 0)
        {
            rebind_state = 1;
            rebind_gamepad = gamepad;
            rebind_filter_source = _filter_source;
            
            if (_filter_source == undefined)
                rebind_target_source = source;
            else
                rebind_target_source = _filter_source;
            
            __input_trace("Binding scan started for player ", _player_index, " (filter=", input_source_get_name(rebind_filter_source), ", target source=", input_source_get_name(rebind_target_source), ", gamepad=", gamepad, ")");
        }
        else
        {
            if (rebind_target_source == UnknownEnum.Value_0)
            {
                __input_trace("Binding scan failed: Source for player ", _player_index, " is INPUT_SOURCE.NONE");
                rebind_state = -1;
                return UnknownEnum.Value_m10;
            }
            
            if (rebind_filter_source == undefined && rebind_target_source != source)
            {
                __input_trace("Binding scan failed: Source for player ", _player_index, " changed (from ", input_source_get_name(rebind_target_source), " to ", input_source_get_name(source), ")");
                rebind_state = -1;
                return UnknownEnum.Value_m11;
            }
            
            if (rebind_target_source == UnknownEnum.Value_2 && rebind_gamepad != gamepad)
            {
                __input_trace("Binding scan failed: Gamepad for player ", _player_index, " changed (from ", rebind_gamepad, " to ", gamepad, ")");
                rebind_state = -1;
                return UnknownEnum.Value_m12;
            }
            
            if (rebind_target_source == UnknownEnum.Value_2 && gamepad == -1)
            {
                __input_trace("Binding scan failed: Gamepad for player ", _player_index, " is INPUT_NO_GAMEPAD");
                rebind_state = -1;
                return UnknownEnum.Value_m13;
            }
            
            if (rebind_state == 1)
            {
                if (rebind_filter_source == undefined)
                {
                    if (!any_input())
                    {
                        __input_trace("Now scanning for a new binding from player ", _player_index);
                        rebind_state = 2;
                    }
                }
                else if (!any_input(-3))
                {
                    __input_trace("Now scanning for a new binding from player ", _player_index);
                    rebind_state = 2;
                }
            }
            else if (rebind_state == 2)
            {
                var _new_binding = undefined;
                var _binding_source = UnknownEnum.Value_0;
                
                if (keyboard_key > vk_nokey)
                {
                    _new_binding = new __input_class_binding("key", keyboard_key);
                    _binding_source = UnknownEnum.Value_1;
                }
                else if (mouse_button > mb_none)
                {
                    _new_binding = new __input_class_binding("mouse button", mouse_button);
                    _binding_source = UnknownEnum.Value_1;
                }
                else if (mouse_wheel_up())
                {
                    _new_binding = new __input_class_binding("mouse wheel up");
                    _binding_source = UnknownEnum.Value_1;
                }
                else if (mouse_wheel_down())
                {
                    _new_binding = new __input_class_binding("mouse wheel down");
                    _binding_source = UnknownEnum.Value_1;
                }
                else
                {
                    var _check_array = [32769, 32770, 32771, 32772, 32781, 32782, 32783, 32784, 32773, 32774, 32775, 32776, 32778, 32777, 32779, 32780, 32785, 32786, 32787, 32788];
                    var _i = 0;
                    
                    repeat (array_length(_check_array))
                    {
                        var _check = _check_array[_i];
                        
                        if (input_gamepad_is_axis(gamepad, _check))
                        {
                            var _value = input_gamepad_value(gamepad, _check);
                            
                            if (abs(_value) > input_axis_threshold_get(_check, _player_index).mini)
                            {
                                _new_binding = new __input_class_binding("gamepad axis", _check, _value < 0);
                                _binding_source = UnknownEnum.Value_2;
                            }
                        }
                        else if (input_gamepad_check(gamepad, _check))
                        {
                            _new_binding = new __input_class_binding("gamepad button", _check);
                            _binding_source = UnknownEnum.Value_2;
                        }
                        
                        _i++;
                    }
                }
                
                if (is_struct(_new_binding))
                {
                    if (_binding_source != rebind_target_source)
                    {
                        __input_trace("Binding scan failed: New binding source (", input_source_get_name(_binding_source), ") for ", _player_index, " doesn't match desired rebinding source (", input_source_get_name(rebind_target_source), ")");
                        rebind_state = -1;
                        return UnknownEnum.Value_m14;
                    }
                    else
                    {
                        __input_trace("Binding found for player ", _player_index, ": \"", input_binding_get_name(_new_binding), "\"");
                        rebind_state = -2;
                        return _new_binding;
                    }
                }
            }
        }
    }
    
    return undefined;
}
