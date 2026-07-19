function __input_class_player() constructor
{
    static axis_threshold_set = function(arg0, arg1, arg2)
    {
        var _axis_struct = variable_struct_get(config.axis_thresholds, arg0);
        
        if (!is_struct(_axis_struct))
        {
            _axis_struct = {};
            variable_struct_set(config.axis_thresholds, arg0, _axis_struct);
        }
        
        _axis_struct.mini = arg1;
        _axis_struct.maxi = arg2;
        return _axis_struct;
    };
    
    static axis_threshold_get = function(arg0)
    {
        var _struct = variable_struct_get(config.axis_thresholds, arg0);
        
        if (is_struct(_struct))
            return _struct;
        
        return axis_threshold_set(arg0, 0.3, 1);
    };
    
    static set_verb = function(arg0, arg1)
    {
        with (variable_struct_get(verbs, arg0))
        {
            value = arg1;
            tick();
        }
    };
    
    static tick = function()
    {
        if (!rebind_this_frame && rebind_state < 0)
            rebind_state = 0;
        
        rebind_this_frame = false;
        var _verb_names = variable_struct_get_names(verbs);
        var _v = 0;
        
        repeat (array_length(_verb_names))
        {
            with (variable_struct_get(verbs, _verb_names[_v]))
                clear();
            
            _v++;
        }
        
        tick_source(global.__input_source_names[source]);
        var _history_array = history_do ? history_array : undefined;
        tick_verbs(_history_array);
        
        if (history_do)
            array_delete(_history_array, 0, array_length(_history_array) - 20);
        
        with (cursor)
        {
            tick(other.rebind_state);
            limit();
        }
    };
    
    static tick_verbs = function(arg0)
    {
        var _verb_names = variable_struct_get_names(verbs);
        var _v = 0;
        
        repeat (array_length(_verb_names))
        {
            with (variable_struct_get(verbs, _verb_names[_v]))
                tick(arg0);
            
            _v++;
        }
    };
    
    static tick_source = function(arg0)
    {
        var _source_verb_struct = variable_struct_get(config, arg0);
        
        if (is_struct(_source_verb_struct))
        {
            var _verb_names = variable_struct_get_names(_source_verb_struct);
            var _v = 0;
            
            repeat (array_length(_verb_names))
            {
                var _verb_name = _verb_names[_v];
                var _raw = 0;
                var _value = 0;
                var _analogue = undefined;
                var _raw_analogue = undefined;
                var _alternate_array = variable_struct_get(_source_verb_struct, _verb_name);
                var _a = 0;
                
                repeat (array_length(_alternate_array))
                {
                    var _binding = _alternate_array[_a];
                    
                    if (is_struct(_binding))
                    {
                        switch (_binding.type)
                        {
                            case "key":
                                if (keyboard_check(_binding.value))
                                {
                                    _value = 1;
                                    _raw = 1;
                                    _analogue = false;
                                    _raw_analogue = false;
                                }
                                
                                break;
                            
                            case "gamepad button":
                                if (input_gamepad_check(gamepad, _binding.value))
                                {
                                    _value = 1;
                                    _raw = 1;
                                    _analogue = false;
                                    _raw_analogue = false;
                                }
                                
                                break;
                            
                            case "mouse button":
                                if (device_mouse_check_button(0, _binding.value))
                                {
                                    _value = 1;
                                    _raw = 1;
                                    _analogue = false;
                                    _raw_analogue = false;
                                }
                                
                                break;
                            
                            case "mouse wheel up":
                                if (mouse_wheel_up())
                                {
                                    _value = 1;
                                    _raw = 1;
                                    _analogue = false;
                                    _raw_analogue = false;
                                }
                                
                                break;
                            
                            case "mouse wheel down":
                                if (mouse_wheel_down())
                                {
                                    _value = 1;
                                    _raw = 1;
                                    _analogue = false;
                                    _raw_analogue = false;
                                }
                                
                                break;
                            
                            case "gamepad axis":
                                var _found_raw = input_gamepad_value(gamepad, _binding.value);
                                var _axis_threshold = axis_threshold_get(_binding.value);
                                
                                if (_binding.axis_negative)
                                    _found_raw = -_found_raw;
                                
                                var _found_value = _found_raw;
                                _found_value = (_found_value - _axis_threshold.mini) / (_axis_threshold.maxi - _axis_threshold.mini);
                                _found_value = clamp(_found_value, 0, 1);
                                
                                if (_found_raw > _raw)
                                {
                                    _raw = _found_raw;
                                    _raw_analogue = true;
                                }
                                
                                if (_found_value > _value)
                                {
                                    _value = _found_value;
                                    _analogue = true;
                                }
                                
                                break;
                            
                            case "gamepad axis pair":
                                var _found_raw = input_gamepad_value(gamepad, _binding.value);
                                var _found_raw_b = input_gamepad_value(gamepad, _binding.value_b);
                                var _raw_dist = sqrt((_found_raw * _found_raw) + (_found_raw_b * _found_raw_b));
                                var _found_value = _found_raw / _raw_dist;
                                var _axis_threshold = axis_threshold_get(_binding.value);
                                var _dist = (_raw_dist - _axis_threshold.mini) / (_axis_threshold.maxi - _axis_threshold.mini);
                                _dist = clamp(_dist, 0, 1);
                                _found_value *= _dist;
                                
                                if (abs(_found_raw) > _raw)
                                {
                                    _raw = _found_raw;
                                    _raw_analogue = true;
                                }
                                
                                if (abs(_found_value) > _value)
                                {
                                    _value = _found_value;
                                    _analogue = true;
                                }
                                
                                break;
                        }
                    }
                    
                    _a++;
                }
                
                var _verb_struct = variable_struct_get(verbs, _verb_name);
                _verb_struct.value = _value;
                _verb_struct.raw = _raw;
                
                if (_analogue != undefined)
                    _verb_struct.analogue = _analogue;
                
                if (_raw_analogue != undefined)
                    _verb_struct.raw_analogue = _raw_analogue;
                
                _v++;
            }
        }
    };
    
    static set_binding = function(arg0, arg1, arg2, arg3)
    {
        if (arg0 < 0 || arg0 >= UnknownEnum.Value_3)
        {
            __input_error("Invalid source (", arg0, ")");
            return undefined;
        }
        
        if (arg2 < 0)
        {
            __input_error("Invalid \"alternate\" argument (", arg2, ")");
            return undefined;
        }
        
        if (arg2 >= 2)
        {
            __input_error("\"alternate\" argument too large (", arg2, " vs. ", 2, ")\nIncrease INPUT_MAX_ALTERNATE_BINDINGS for more alternate binding slots");
            return undefined;
        }
        
        var _source_verb_struct = variable_struct_get(config, global.__input_source_names[arg0]);
        
        if (!is_struct(_source_verb_struct))
        {
            _source_verb_struct = {};
            variable_struct_set(config, global.__input_source_names[arg0], _source_verb_struct);
        }
        else
        {
        }
        
        var _verb_alternate_array = variable_struct_get(_source_verb_struct, arg1);
        
        if (!is_array(_verb_alternate_array))
        {
            _verb_alternate_array = array_create(2, undefined);
            variable_struct_set(_source_verb_struct, arg1, _verb_alternate_array);
        }
        else
        {
        }
        
        _verb_alternate_array[arg2] = arg3;
        variable_struct_set(_source_verb_struct, arg1, _verb_alternate_array);
        
        if (!is_struct(variable_struct_get(verbs, arg1)))
        {
            var _verb_struct = new __input_class_verb();
            _verb_struct.name = arg1;
            variable_struct_set(verbs, arg1, _verb_struct);
        }
        
        return arg3;
    };
    
    static get_binding = function(arg0 = source, arg1, arg2)
    {
        var _source_verb_struct = variable_struct_get(config, global.__input_source_names[arg0]);
        
        if (is_struct(_source_verb_struct))
        {
            var _alternate_array = variable_struct_get(_source_verb_struct, arg1);
            
            if (is_array(_alternate_array))
            {
                var _binding = _alternate_array[arg2];
                
                if (is_struct(_binding))
                    return _binding;
            }
        }
        
        return undefined;
    };
    
    static any_input = function()
    {
        var _source = (argument_count > 0 && argument[0] != undefined) ? argument[0] : source;
        
        if (_source == -3)
        {
            if (any_input(UnknownEnum.Value_1))
                return true;
            
            if (any_input(UnknownEnum.Value_2))
                return true;
            
            return false;
        }
        
        switch (_source)
        {
            case UnknownEnum.Value_0:
                return false;
                break;
            
            case UnknownEnum.Value_1:
                return keyboard_check(vk_anykey) || global.__input_mouse_moved || device_mouse_check_button(0, mb_any) || mouse_wheel_up() || mouse_wheel_down();
                break;
            
            case UnknownEnum.Value_2:
                if (!gamepad_is_connected(gamepad))
                    return false;
                
                return input_gamepad_check(gamepad, 32769) || input_gamepad_check(gamepad, 32770) || input_gamepad_check(gamepad, 32771) || input_gamepad_check(gamepad, 32772) || input_gamepad_check(gamepad, 32781) || input_gamepad_check(gamepad, 32782) || input_gamepad_check(gamepad, 32783) || input_gamepad_check(gamepad, 32784) || input_gamepad_check(gamepad, 32773) || input_gamepad_check(gamepad, 32774) || input_gamepad_check(gamepad, 32775) || input_gamepad_check(gamepad, 32776) || input_gamepad_check(gamepad, 32778) || input_gamepad_check(gamepad, 32777) || input_gamepad_check(gamepad, 32779) || input_gamepad_check(gamepad, 32780) || (false && input_gamepad_check(gamepad, 32789)) || (false && input_gamepad_check(gamepad, 32790)) || abs(input_gamepad_value(gamepad, 32785)) > axis_threshold_get(32785).mini || abs(input_gamepad_value(gamepad, 32786)) > axis_threshold_get(32786).mini || abs(input_gamepad_value(gamepad, 32787)) > axis_threshold_get(32787).mini || abs(input_gamepad_value(gamepad, 32788)) > axis_threshold_get(32788).mini;
                break;
        }
        
        return false;
    };
    
    source = UnknownEnum.Value_0;
    gamepad = -1;
    sources = array_create(UnknownEnum.Value_3, undefined);
    verbs = {};
    axis_thresholds = {};
    last_input_time = -1;
    cursor = new __input_class_cursor();
    rebind_state = 0;
    rebind_source = undefined;
    rebind_gamepad = undefined;
    rebind_verb = undefined;
    rebind_alternate = undefined;
    rebind_this_frame = false;
    rebind_backup_val = undefined;
    history_do = false;
    history_array = undefined;
    config = 
    {
        axis_thresholds: {}
    };
}
