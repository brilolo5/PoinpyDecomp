function __input_gamepad_find_in_sdl2_database(arg0)
{
    with (arg0)
    {
        if (os_type == os_switch || os_type == os_ps4 || os_type == os_xboxone)
        {
            description = gamepad_get_description(index);
            exit;
        }
        
        var _os_filter_dict = variable_struct_get(global.__input_blacklist_dictionary, "all");
        var _os_vid_pid_dict = is_struct(_os_filter_dict) ? variable_struct_get(_os_filter_dict, "vid+pid") : undefined;
        var _os_guid_dict = is_struct(_os_filter_dict) ? variable_struct_get(_os_filter_dict, "guid") : undefined;
        var _os_desc_array = is_struct(_os_filter_dict) ? variable_struct_get(_os_filter_dict, "description contains") : undefined;
        
        if (is_struct(_os_vid_pid_dict) && variable_struct_exists(_os_vid_pid_dict, vendor + product))
        {
            __input_trace("Warning! Controller is blacklisted (cross-platform, found by VID+PID \"", vendor + product, "\")");
            blacklisted = true;
        }
        
        if (is_struct(_os_guid_dict) && variable_struct_exists(_os_guid_dict, guid))
        {
            __input_trace("Warning! Controller is blacklisted (cross-platform, found by GUID \"", guid, "\")");
            blacklisted = true;
        }
        
        if (is_array(_os_desc_array))
        {
            var _description_lower = string_lower(gamepad_get_description(index));
            var _i = 0;
            
            repeat (array_length(_os_desc_array))
            {
                if (string_pos(_os_desc_array[_i], _description_lower) > 0)
                {
                    __input_trace("Warning! Controller is blacklisted (cross-platform, banned substring \"", _os_desc_array[_i], "\" found in description)");
                    blacklisted = true;
                    break;
                }
                
                _i++;
            }
        }
        
        var _os = undefined;
        
        switch (os_type)
        {
            case os_windows:
                _os = "windows";
                break;
            
            case os_uwp:
                _os = "uwp";
                break;
            
            case os_linux:
                _os = "linux";
                break;
            
            case os_macosx:
                _os = "mac";
                break;
            
            case os_ios:
                _os = "ios";
                break;
            
            case os_tvos:
                _os = "tvos";
                break;
            
            case os_android:
                _os = "tvos";
                break;
            
            default:
                __input_error("OS not supported");
                break;
        }
        
        _os_filter_dict = variable_struct_get(global.__input_blacklist_dictionary, _os);
        _os_vid_pid_dict = is_struct(_os_filter_dict) ? variable_struct_get(_os_filter_dict, "vid+pid") : undefined;
        _os_guid_dict = is_struct(_os_filter_dict) ? variable_struct_get(_os_filter_dict, "guid") : undefined;
        _os_desc_array = is_struct(_os_filter_dict) ? variable_struct_get(_os_filter_dict, "description contains") : undefined;
        
        if (is_struct(_os_vid_pid_dict) && variable_struct_exists(_os_vid_pid_dict, vendor + product))
        {
            __input_trace("Warning! Controller is blacklisted (cross-platform, found by VID+PID \"", vendor + product, "\")");
            blacklisted = true;
        }
        
        if (is_struct(_os_guid_dict) && variable_struct_exists(_os_guid_dict, guid))
        {
            __input_trace("Warning! Controller is blacklisted (cross-platform, found by GUID \"", guid, "\")");
            blacklisted = true;
        }
        
        if (is_array(_os_desc_array))
        {
            var _description_lower = string_lower(gamepad_get_description(index));
            var _i = 0;
            
            repeat (array_length(_os_desc_array))
            {
                if (string_pos(_os_desc_array[_i], _description_lower) > 0)
                {
                    __input_trace("Warning! Controller is blacklisted (OS-specific, banned substring \"", _os_desc_array[_i], "\" found in description)");
                    blacklisted = true;
                    break;
                }
                
                _i++;
            }
        }
        
        if (blacklisted)
        {
            description = gamepad_get_description(index);
            exit;
        }
        
        if (xinput)
        {
            description = "XInput";
            exit;
        }
        
        if (os_type == os_macosx && (gamepad_get_mapping(index) == "" || gamepad_get_mapping(index) == "no mapping"))
        {
            __input_trace("Warning! Gamepad already has a native GameMaker remapping");
            description = gamepad_get_description(index);
            exit;
        }
        
        var _vp_array = variable_struct_get(global.__input_sdl2_database.by_vendor_product, vendor + product);
        var _os_array = variable_struct_get(global.__input_sdl2_database.by_platform, os_type);
        var _result_array = [];
        
        if (is_array(_vp_array) && is_array(_os_array))
        {
            var _v = 0;
            
            repeat (array_length(_vp_array))
            {
                _definition = _vp_array[_v];
                var _o = 0;
                
                repeat (array_length(_os_array))
                {
                    if (_os_array[_o] == _definition)
                    {
                        array_set(_result_array, array_length(_result_array), _definition);
                        break;
                    }
                    
                    _o++;
                }
                
                _v++;
            }
        }
        
        var _definition = undefined;
        
        if (array_length(_result_array) > 0)
            _definition = _result_array[0];
        else if (array_length(_vp_array) > 0)
            _definition = _vp_array[0];
        
        if (is_array(_definition))
        {
            sdl2_definition = _definition;
            description = _definition[1];
        }
        else
        {
            __input_trace("Warning! No SDL defintion found for vendor=", vendor, ", product=", product);
            description = "Unknown";
        }
    }
}
