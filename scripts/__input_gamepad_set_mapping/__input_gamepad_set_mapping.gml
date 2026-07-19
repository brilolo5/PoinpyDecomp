function __input_gamepad_set_mapping(arg0)
{
    with (arg0)
    {
        if (os_type == os_switch || os_type == os_ps4 || os_type == os_xboxone)
            exit;
        
        if (xinput)
        {
            description = "XInput";
            
            if (os_type == os_windows)
            {
                set_mapping(32781, 0, "b", "dpup");
                set_mapping(32782, 1, "b", "dpdown");
                set_mapping(32783, 2, "b", "dpleft");
                set_mapping(32784, 3, "b", "dpright");
                set_mapping(32778, 4, "b", "start");
                set_mapping(32777, 5, "b", "back");
                set_mapping(32779, 6, "b", "leftstick");
                set_mapping(32780, 7, "b", "rightstick");
                set_mapping(32773, 8, "b", "leftshoulder");
                set_mapping(32774, 9, "b", "rightshoulder");
                set_mapping(32769, 12, "b", "a");
                set_mapping(32770, 13, "b", "b");
                set_mapping(32771, 14, "b", "x");
                set_mapping(32772, 15, "b", "y");
                set_mapping(32785, 0, "a", "leftx");
                set_mapping(32786, 1, "a", "lefty").reverse = true;
                set_mapping(32787, 2, "a", "rightx");
                set_mapping(32788, 3, "a", "righty").reverse = true;
                set_mapping(32775, 4106, "a", "lefttrigger");
                set_mapping(32776, 4107, "a", "righttrigger");
            }
            
            exit;
        }
        else if (true && is_array(sdl2_definition))
        {
            var _i = 2;
            
            repeat (array_length(sdl2_definition) - 3)
            {
                var _entry = sdl2_definition[_i];
                var _pos = string_pos(":", _entry);
                var _entry_name = string_copy(_entry, 1, _pos - 1);
                var _entry_1 = string_delete(_entry, 1, _pos);
                var _gm = variable_struct_get(global.__input_sdl2_look_up_table, _entry_name);
                
                if (_gm != undefined)
                {
                    var _invert = false;
                    var _negative = false;
                    var _positive = false;
                    
                    if (string_char_at(_entry_1, string_length(_entry_1)) == "~")
                    {
                        _entry_1 = string_delete(_entry_1, string_length(_entry_1), 1);
                        _invert = true;
                    }
                    
                    var _raw_type;
                    
                    while (true)
                    {
                        var _char = string_char_at(_entry_1, 1);
                        _entry_1 = string_delete(_entry_1, 1, 1);
                        
                        if (_char == "~")
                        {
                            _invert = true;
                        }
                        else if (_char == "-")
                        {
                            _negative = true;
                        }
                        else if (_char == "+")
                        {
                            _positive = true;
                        }
                        else
                        {
                            _raw_type = _char;
                            break;
                        }
                    }
                    
                    var _input_slot = floor(real(_entry_1));
                    var _mapping = set_mapping(_gm, _input_slot, _raw_type, _entry_name);
                    
                    if (_invert)
                        _mapping.invert = true;
                    
                    if (_negative)
                        _mapping.negative = true;
                    
                    if (_positive)
                        _mapping.positive = true;
                    
                    if (_raw_type == "h")
                        _mapping.hat_mask = floor(10 * real(_entry_1));
                    
                    var _is_trigger_axis = _raw_type == "a" && string_pos("trigger", _entry_name);
                    
                    if ((os_type == os_macosx && _is_trigger_axis) || (os_type == os_windows && (vendor == "4c05" && (product == "cc09" || product == "c405")) && _is_trigger_axis))
                        _mapping.limit_range = true;
                }
                
                _i++;
            }
        }
    }
}
