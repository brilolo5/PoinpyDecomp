function snap_to_binary(arg0)
{
    return new __snap_to_binary_parser(arg0).buffer;
}

function __snap_to_binary_parser(arg0) constructor
{
    static parse_struct = function(arg0)
    {
        buffer_write(buffer, buffer_u8, 1);
        var _names = variable_struct_get_names(arg0);
        var _count = array_length(_names);
        var _i = 0;
        
        repeat (_count)
        {
            var _name = _names[_i];
            value = variable_struct_get(arg0, _name);
            
            if (!is_method(value) || true)
            {
                if (is_struct(_name) || is_array(_name))
                {
                    show_error("Key type \"" + typeof(_name) + "\" not supported\n ", false);
                    _name = string(ptr(_name));
                }
                
                buffer_write(buffer, buffer_u8, 3);
                buffer_write(buffer, buffer_string, string(_name));
                write_value();
            }
            
            _i++;
        }
        
        buffer_write(buffer, buffer_u8, 0);
    };
    
    static parse_array = function(arg0)
    {
        var _count = array_length(arg0);
        var _i = 0;
        buffer_write(buffer, buffer_u8, 2);
        
        repeat (_count)
        {
            value = arg0[_i];
            write_value();
            _i++;
        }
        
        buffer_write(buffer, buffer_u8, 0);
    };
    
    static write_value = function()
    {
        if (is_struct(value))
        {
            parse_struct(value);
        }
        else if (is_array(value))
        {
            parse_array(value);
        }
        else if (is_string(value))
        {
            buffer_write(buffer, buffer_u8, 3);
            buffer_write(buffer, buffer_string, value);
        }
        else if (is_real(value))
        {
            if (value == 0)
            {
                buffer_write(buffer, buffer_u8, 5);
            }
            else if (value == 1)
            {
                buffer_write(buffer, buffer_u8, 6);
            }
            else
            {
                buffer_write(buffer, buffer_u8, 4);
                buffer_write(buffer, buffer_f64, value);
            }
        }
        else if (is_bool(value))
        {
            buffer_write(buffer, buffer_u8, value ? 6 : 5);
        }
        else if (is_undefined(value))
        {
            buffer_write(buffer, buffer_u8, 7);
        }
        else if (is_int32(value))
        {
            buffer_write(buffer, buffer_u8, 8);
            buffer_write(buffer, buffer_s32, value);
        }
        else if (is_int64(value))
        {
            buffer_write(buffer, buffer_u8, 9);
            buffer_write(buffer, buffer_u64, value);
        }
        else if (is_method(value))
        {
            show_error("Functions/methods cannot be serialised\n(Please edit macro SNAP_BINARY_SERIALISE_FUNCTION_NAMES to change this behaviour)\n ", true);
            buffer_write(buffer, buffer_u8, 7);
        }
        else
        {
            show_message("Datatype \"" + typeof(value) + "\" not supported");
        }
    };
    
    root = arg0;
    buffer = buffer_create(1024, buffer_grow, 1);
    
    if (is_struct(root))
        parse_struct(root);
    else if (is_array(root))
        parse_array(root);
    else
        show_error("Value not struct or array. Returning empty string\n ", false);
    
    buffer_resize(buffer, buffer_tell(buffer));
}
