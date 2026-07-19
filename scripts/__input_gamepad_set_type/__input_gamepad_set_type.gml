function __input_gamepad_set_type(arg0)
{
    if (!is_struct(arg0))
        return "unknown";
    
    with (arg0)
    {
        switch (os_type)
        {
            case os_switch:
                type = "switch";
                exit;
                break;
            
            case os_ps4:
                type = "ps4";
                exit;
                break;
            
            case os_xboxone:
                type = "xbox one";
                exit;
                break;
        }
        
        if (xinput == true)
        {
            type = "xbox 360";
            guessed_type = true;
        }
        else if (variable_struct_exists(global.__input_type_dictionary, vendor + product))
        {
            type = variable_struct_get(global.__input_type_dictionary, vendor + product);
        }
        else
        {
            guessed_type = true;
            __input_trace("Warning! \"", vendor + product, "\" not found in type database. Guessing controller type based on \"", description, "\"");
            var _desc = string_lower(description);
            
            if (string_count("snes", _desc))
                type = "snes";
            else if (string_count("saturn", _desc))
                type = "saturn";
            else if (string_count("ps5", _desc) || string_count("dualsense", _desc))
                type = "ps5";
            else if (string_count("ps4", _desc) || string_count("dualshock 4", _desc))
                type = "ps4";
            else if (string_count("playstation", _desc) || string_count("ps1", _desc) || string_count("ps2", _desc) || string_count("ps3", _desc) || string_count("dualshock", _desc))
                type = "psx";
            else if (string_count("switch", _desc) || string_count("lic pro controller", _desc))
                type = "switch";
            else if (string_count("xbox one", _desc))
                type = "xbox one";
            else if (string_count("xbox 360", _desc) || string_count("xbox360", _desc))
                type = "xbox 360";
            else if (string_count("8bitdo", _desc))
                type = "8bitdo";
            else
                type = "unknown";
        }
    }
}
