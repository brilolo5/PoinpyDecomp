function snap_to_messagepack(arg0)
{
    return new __snap_to_messagepack_parser(arg0).buffer;
}

function __snap_to_messagepack_parser(arg0) constructor
{
    static write_struct = function(arg0)
    {
        var _names = variable_struct_get_names(arg0);
        var _count = array_length(_names);
        var _write_count = _count;
        var _i = 0;
        
        repeat (_count)
        {
            var _name = _names[_i];
            
            if (is_method(variable_struct_get(arg0, _name)))
                show_error("Functions/methods cannot be serialised\n(Please edit macro SNAP_MESSAGEPACK_SERIALISE_FUNCTION_NAMES to change this behaviour)\n ", true);
            
            _i++;
        }
        
        if (_write_count <= 15)
        {
            buffer_write(buffer, buffer_u8, 128 | _write_count);
        }
        else if (_write_count <= 65535)
        {
            buffer_write(buffer, buffer_u8, 222);
            buffer_write_little(3, _write_count);
        }
        else if (_write_count <= 4294967295)
        {
            buffer_write(buffer, buffer_u8, 223);
            buffer_write_little(5, _write_count);
        }
        else
        {
            show_error("Trying to write a struct longer than 4294967295 elements\n(How did you make a struct this big?!)\n ", true);
        }
        
        _i = 0;
        
        repeat (_count)
        {
            var _name = _names[_i];
            var _value = variable_struct_get(arg0, _name);
            
            if (!is_method(_value) || false)
            {
                write_value(_name);
                write_value(_value);
            }
            
            _i++;
        }
    };
    
    static write_array = function(arg0)
    {
        var _count = array_length(arg0);
        var _write_count = _count;
        var _i = 0;
        
        repeat (_count)
        {
            if (is_method(arg0[_i]))
                show_error("Functions/methods cannot be serialised\n(Please edit macro SNAP_MESSAGEPACK_SERIALISE_FUNCTION_NAMES to change this behaviour)\n ", true);
            
            _i++;
        }
        
        if (_write_count <= 15)
        {
            buffer_write(buffer, buffer_u8, 144 | _write_count);
        }
        else if (_write_count <= 65535)
        {
            buffer_write(buffer, buffer_u8, 220);
            buffer_write_little(3, _write_count);
        }
        else if (_write_count <= 4294967295)
        {
            buffer_write(buffer, buffer_u8, 221);
            buffer_write_little(5, _write_count);
        }
        else
        {
            show_error("Trying to write an array longer than 4294967295 elements\n(How did you make an array this big?!)\n ", true);
        }
        
        _i = 0;
        
        repeat (_count)
        {
            var _value = arg0[_i];
            
            if (!is_method(_value) || false)
                write_value(_value);
            
            _i++;
        }
    };
    
    static write_string = function(arg0)
    {
        var _size = string_byte_length(arg0);
        
        if (_size <= 31)
        {
            buffer_write(buffer, buffer_u8, 160 | _size);
        }
        else if (_size <= 255)
        {
            buffer_write(buffer, buffer_u8, 217);
            buffer_write(buffer, buffer_u8, _size);
        }
        else if (_size <= 65535)
        {
            buffer_write(buffer, buffer_u8, 218);
            buffer_write_little(3, _size);
        }
        else if (_size <= 1099511627775)
        {
            buffer_write(buffer, buffer_u8, 219);
            buffer_write_little(5, _size);
        }
        else
        {
            show_error("Trying to write a string longer than 4294967295 bytes\n(How did you make a string this big?!)\n ", true);
        }
        
        buffer_write(buffer, buffer_text, arg0);
    };
    
    static write_number = function(arg0)
    {
        if (is_int32(arg0) || is_int64(arg0) || floor(arg0) == arg0)
        {
            if (arg0 > 0)
            {
                if (arg0 <= 127)
                {
                    buffer_write(buffer, buffer_u8, arg0);
                }
                else if (arg0 <= 255)
                {
                    buffer_write(buffer, buffer_u8, 204);
                    buffer_write(buffer, buffer_u8, arg0);
                }
                else if (arg0 <= 65535)
                {
                    buffer_write(buffer, buffer_u8, 205);
                    buffer_write_little(3, arg0);
                }
                else if (arg0 <= 4294967295)
                {
                    buffer_write(buffer, buffer_u8, 206);
                    buffer_write_little(5, arg0);
                }
                else
                {
                    buffer_write(buffer, buffer_u8, 207);
                    buffer_write_little(12, arg0);
                }
            }
            else if (arg0 == 0)
            {
                buffer_write(buffer, buffer_u8, 0);
            }
            else
            {
                arg0 = -arg0;
                
                if (arg0 <= 31)
                {
                    buffer_write(buffer, buffer_u8, 224 | arg0);
                }
                else if (arg0 <= 255)
                {
                    buffer_write(buffer, buffer_u8, 208);
                    buffer_write(buffer, buffer_u8, arg0);
                }
                else if (arg0 <= 65535)
                {
                    buffer_write(buffer, buffer_u8, 209);
                    buffer_write_little(3, arg0);
                }
                else if (arg0 <= 4294967295)
                {
                    buffer_write(buffer, buffer_u8, 210);
                    buffer_write_little(5, arg0);
                }
                else
                {
                    buffer_write(buffer, buffer_u8, 211);
                    buffer_write_little(12, arg0);
                }
            }
        }
        else
        {
            buffer_write(buffer, buffer_u8, 203);
            buffer_write_little(9, arg0);
        }
    };
    
    static write_bin = function(arg0)
    {
        var _array = arg0.data;
        var _count = array_length(_array);
        
        if (_count <= 255)
        {
            buffer_write(buffer, buffer_u8, 196);
            buffer_write(buffer, buffer_u8, _count);
        }
        else if (_count <= 65535)
        {
            buffer_write(buffer, buffer_u8, 197);
            buffer_write_little(3, _count);
        }
        else if (_count <= 4294967295)
        {
            buffer_write(buffer, buffer_u8, 198);
            buffer_write_little(5, _count);
        }
        else
        {
            show_error("Trying to write a binary array longer than 4294967295 elements\n(How did you make an array this big?!)\n ", true);
        }
        
        var _i = 0;
        
        repeat (_count)
        {
            buffer_write(buffer, buffer_u8, _array[_i]);
            _i++;
        }
    };
    
    static write_ext = function(arg0)
    {
        var _array = arg0.data;
        var _count = array_length(_array);
        
        if (_count == 1)
        {
            buffer_write(buffer, buffer_u8, 212);
        }
        else if (_count == 2)
        {
            buffer_write(buffer, buffer_u8, 213);
        }
        else if (_count == 4)
        {
            buffer_write(buffer, buffer_u8, 214);
        }
        else if (_count == 8)
        {
            buffer_write(buffer, buffer_u8, 215);
        }
        else if (_count == 16)
        {
            buffer_write(buffer, buffer_u8, 216);
        }
        else if (_count <= 255)
        {
            buffer_write(buffer, buffer_u8, 199);
            buffer_write(buffer, buffer_u8, _count);
        }
        else if (_count <= 65535)
        {
            buffer_write(buffer, buffer_u8, 200);
            buffer_write_little(3, _count);
        }
        else if (_count <= 4294967295)
        {
            buffer_write(buffer, buffer_u8, 201);
            buffer_write_little(5, _count);
        }
        else
        {
            show_error("Trying to write an extended binary array longer than 4294967295 elements\n(How did you make an array this big?!)\n ", true);
        }
        
        buffer_write(buffer, buffer_s8, arg0.type);
        var _i = 0;
        
        repeat (_count)
        {
            buffer_write(buffer, buffer_u8, _array[_i]);
            _i++;
        }
    };
    
    static buffer_write_little = function(arg0, arg1)
    {
        switch (buffer_sizeof(arg0))
        {
            case 1:
                buffer_write(buffer, arg0, arg1);
                break;
            
            case 2:
                buffer_poke(flip_buffer, 0, arg0, arg1);
                buffer_write(buffer, buffer_u8, buffer_peek(flip_buffer, 1, buffer_u8));
                buffer_write(buffer, buffer_u8, buffer_peek(flip_buffer, 0, buffer_u8));
                break;
            
            case 4:
                buffer_poke(flip_buffer, 0, arg0, arg1);
                buffer_write(buffer, buffer_u8, buffer_peek(flip_buffer, 3, buffer_u8));
                buffer_write(buffer, buffer_u8, buffer_peek(flip_buffer, 2, buffer_u8));
                buffer_write(buffer, buffer_u8, buffer_peek(flip_buffer, 1, buffer_u8));
                buffer_write(buffer, buffer_u8, buffer_peek(flip_buffer, 0, buffer_u8));
                break;
            
            case 8:
                buffer_poke(flip_buffer, 0, arg0, arg1);
                buffer_write(buffer, buffer_u8, buffer_peek(flip_buffer, 7, buffer_u8));
                buffer_write(buffer, buffer_u8, buffer_peek(flip_buffer, 6, buffer_u8));
                buffer_write(buffer, buffer_u8, buffer_peek(flip_buffer, 5, buffer_u8));
                buffer_write(buffer, buffer_u8, buffer_peek(flip_buffer, 4, buffer_u8));
                buffer_write(buffer, buffer_u8, buffer_peek(flip_buffer, 3, buffer_u8));
                buffer_write(buffer, buffer_u8, buffer_peek(flip_buffer, 2, buffer_u8));
                buffer_write(buffer, buffer_u8, buffer_peek(flip_buffer, 1, buffer_u8));
                buffer_write(buffer, buffer_u8, buffer_peek(flip_buffer, 0, buffer_u8));
                break;
        }
    };
    
    static write_value = function(arg0)
    {
        if (is_struct(arg0))
        {
            var _messagepack_datatype = variable_struct_get(arg0, "messagepack_datatype__");
            
            if (_messagepack_datatype == "bin")
                write_bin(arg0);
            else if (_messagepack_datatype == "ext")
                write_bin(arg0);
            else
                write_struct(arg0);
        }
        else if (is_array(arg0))
        {
            write_array(arg0);
        }
        else if (is_string(arg0))
        {
            write_string(arg0);
        }
        else if (is_bool(arg0))
        {
            buffer_write(buffer, buffer_u8, arg0 ? 195 : 194);
        }
        else if (is_numeric(arg0))
        {
            write_number(arg0);
        }
        else if (is_undefined(arg0))
        {
            buffer_write(buffer, buffer_u8, 192);
        }
        else if (is_method(arg0))
        {
            buffer_write(buffer, buffer_u8, 192);
        }
        else
        {
            show_error("Unsupported datatype \"" + typeof(arg0) + "\"\n ", false);
            buffer_write(buffer, buffer_u8, 192);
        }
    };
    
    flip_buffer = buffer_create(8, buffer_fixed, 1);
    buffer = buffer_create(1024, buffer_grow, 1);
    write_value(arg0);
    buffer_resize(buffer, max(1, buffer_tell(buffer)));
    buffer_delete(flip_buffer);
}
