function __input_class_gamepad(arg0) constructor
{
    index = arg0;
    description = "Unknown";
    guid = gamepad_get_guid(arg0);
    xinput = undefined;
    type = undefined;
    guessed_type = false;
    blacklisted = false;
    sdl2_definition = undefined;
    vendor = undefined;
    product = undefined;
    custom_mapping = false;
    mapping_gm_to_raw = {};
    mapping_raw_to_gm = {};
    mapping_array = [];
    
    get_held = function(arg0)
    {
        if (!custom_mapping)
            return gamepad_button_check(index, arg0);
        
        var _mapping = variable_struct_get(mapping_gm_to_raw, arg0);
        
        if (_mapping == undefined)
            return 0;
        
        return _mapping.held;
    };
    
    get_pressed = function(arg0)
    {
        if (!custom_mapping)
            return gamepad_button_check_pressed(index, arg0);
        
        var _mapping = variable_struct_get(mapping_gm_to_raw, arg0);
        
        if (_mapping == undefined)
            return 0;
        
        return _mapping.press;
    };
    
    get_released = function(arg0)
    {
        if (!custom_mapping)
            return gamepad_button_check_released(index, arg0);
        
        var _mapping = variable_struct_get(mapping_gm_to_raw, arg0);
        
        if (_mapping == undefined)
            return 0;
        
        return _mapping.release;
    };
    
    get_value = function(arg0)
    {
        if (!custom_mapping)
            return gamepad_axis_value(index, arg0);
        
        var _mapping = variable_struct_get(mapping_gm_to_raw, arg0);
        
        if (_mapping == undefined)
            return 0;
        
        return _mapping.value;
    };
    
    is_axis = function(arg0)
    {
        if (!custom_mapping)
        {
            if (arg0 == 32775 || arg0 == 32776)
                return xinput;
            
            return arg0 == 32785 || arg0 == 32786 || arg0 == 32787 || arg0 == 32788;
        }
        
        var _mapping = variable_struct_get(mapping_gm_to_raw, arg0);
        
        if (_mapping == undefined)
            return false;
        
        return _mapping.type == "a";
    };
    
    set_mapping = function(arg0, arg1, arg2, arg3)
    {
        if (!custom_mapping)
        {
            __input_trace("Gamepad ", index, " has a custom mapping, clearing GM's internal mapping string");
            
            if (os_type == os_macosx)
            {
                if (gamepad_get_mapping(index) != "" && gamepad_get_mapping(index) != "no mapping")
                    __input_trace("Warning! Performing remapping of MacOS controller that already has a remapping. This may well cause glitches and errors (mapping was \"", gamepad_get_mapping(index), "\")");
                
                gamepad_test_mapping(index, gamepad_get_guid(index) + "," + gamepad_get_description(index) + ",");
            }
            else
            {
                gamepad_remove_mapping(index);
            }
            
            custom_mapping = true;
        }
        
        if (os_type == os_macosx)
        {
            if (arg2 == "a")
                arg1 += 6;
            
            if (arg2 == "b")
                arg1 += 17;
        }
        
        var _mapping = 
        {
            gm: arg0,
            raw: arg1,
            type: arg2,
            sdl_name: arg3,
            invert: false,
            negative: false,
            positive: false,
            reverse: false,
            limit_range: false,
            hat_mask: undefined,
            held_previous: false,
            value: 0,
            held: false,
            press: false,
            release: false
        };
        variable_struct_set(mapping_gm_to_raw, arg0, _mapping);
        variable_struct_set(mapping_raw_to_gm, arg1, _mapping);
        array_set(mapping_array, array_length(mapping_array), _mapping);
        return _mapping;
    };
    
    tick = function()
    {
        var _index = index;
        var _i = 0;
        
        repeat (array_length(mapping_array))
        {
            with (mapping_array[_i])
            {
                held_previous = held;
                value = 0;
                held = false;
                press = false;
                release = false;
                
                switch (type)
                {
                    case "b":
                        value = gamepad_button_check(_index, raw);
                        break;
                    
                    case "a":
                        value = gamepad_axis_value(_index, raw);
                        break;
                    
                    case "h":
                        value = gamepad_hat_value(_index, raw);
                        value &= hat_mask;
                        break;
                }
                
                if (limit_range)
                    value = 0.5 + (0.5 * value);
                
                if (negative)
                    value = clamp(value, -1, 0);
                
                if (positive)
                    value = clamp(value, 0, 1);
                
                if (invert)
                    value = 1 - value;
                
                if (reverse)
                    value = -value;
                
                held = abs(value) > 0.2;
                
                if (held_previous != held)
                {
                    if (held)
                        press = true;
                    else
                        release = true;
                }
            }
            
            _i++;
        }
    };
    
    __input_gamepad_set_vid_pid(self);
    __input_gamepad_find_in_sdl2_database(self);
    __input_gamepad_set_type(self);
    __input_gamepad_set_mapping(self);
    __input_trace("Gamepad ", index, " discovered, type = \"", type, "\", description = \"", description, "\" (vendor=", vendor, ", product=", product, ")");
}
