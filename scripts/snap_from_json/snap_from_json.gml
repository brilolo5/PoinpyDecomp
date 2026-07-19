function snap_from_json(arg0)
{
    var _buffer = buffer_create(string_byte_length(arg0), buffer_fixed, 1);
    buffer_write(_buffer, buffer_text, arg0);
    buffer_seek(_buffer, buffer_seek_start, 0);
    var _cache_buffer = buffer_create(256, buffer_grow, 1);
    var _parser = new __snap_from_json_parser(_buffer, buffer_get_size(_buffer), _cache_buffer);
    buffer_delete(_buffer);
    buffer_delete(_cache_buffer);
    return _parser.root;
}

function __snap_from_json_parser(arg0, arg1, arg2) constructor
{
    static push_cache = function()
    {
        if (cache_value == undefined)
        {
            if (!cache_started)
            {
                show_error("Trying to read cache but there's nothing there (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
            }
            else
            {
                buffer_write(cache_buffer, buffer_u8, 0);
                cache_value = buffer_peek(cache_buffer, 0, buffer_string);
                
                if (!was_string)
                {
                    switch (cache_value)
                    {
                        case "true":
                            cache_value = true;
                            break;
                        
                        case "false":
                            cache_value = false;
                            break;
                        
                        case "null":
                            cache_value = undefined;
                            break;
                        
                        default:
                            try
                            {
                                cache_value = real(cache_value);
                            }
                            catch (_error)
                            {
                                show_error("\"" + string(cache_value) + "\" could not be interpreted (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
                            }
                            
                            break;
                    }
                }
            }
        }
        
        if (root_is_struct)
        {
            if (in_key)
            {
                key = cache_value;
                in_key = false;
            }
            else
            {
                variable_struct_set(root, key, cache_value);
                in_key = true;
            }
        }
        else
        {
            array_set(root, root_array_size++, cache_value);
        }
        
        buffer_seek(cache_buffer, buffer_seek_start, 0);
        cache_started = false;
        cache_value = undefined;
        was_string = false;
    };
    
    buffer = arg0;
    buffer_size = arg1;
    cache_buffer = arg2;
    cache_started = false;
    cache_value = undefined;
    root = undefined;
    root_is_struct = false;
    root_array_size = 0;
    in_string = false;
    escaped = false;
    was_string = false;
    in_key = false;
    key = undefined;
    in_comment = false;
    one_line_comment = false;
    
    while (buffer_tell(buffer) < buffer_size)
    {
        value = buffer_read(buffer, buffer_u8);
        
        if (in_comment)
        {
            if (one_line_comment)
            {
                if (value == 10 || value == 13)
                    in_comment = false;
            }
            else if (value == 47 && buffer_peek(buffer, buffer_tell(buffer) - 2, buffer_u8) == 42)
            {
                in_comment = false;
            }
        }
        else if (value == 34)
        {
            if (root != undefined)
            {
                if (in_string)
                {
                    if (escaped)
                    {
                        buffer_write(cache_buffer, buffer_u8, value);
                        escaped = false;
                    }
                    else
                    {
                        in_string = false;
                    }
                }
                else
                {
                    cache_started = true;
                    in_string = true;
                    was_string = true;
                }
            }
            else
            {
                show_error("Quote mark found outside of an object or array (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
            }
        }
        else if (in_string)
        {
            if (escaped)
            {
                switch (value)
                {
                    case 110:
                        buffer_write(cache_buffer, buffer_u8, 10);
                        break;
                    
                    case 114:
                        buffer_write(cache_buffer, buffer_u8, 13);
                        break;
                    
                    case 116:
                        buffer_write(cache_buffer, buffer_u8, 9);
                        break;
                    
                    default:
                        buffer_write(cache_buffer, buffer_u8, value);
                        break;
                }
                
                escaped = false;
            }
            else if (value == 92)
            {
                escaped = true;
            }
            else
            {
                buffer_write(cache_buffer, buffer_u8, value);
            }
        }
        else
        {
            switch (value)
            {
                case 58:
                    if (root_is_struct)
                    {
                        if (in_key)
                            push_cache();
                        else
                            show_error("\":\" found outside key (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
                    }
                    else
                    {
                        show_error("\":\" found outside an object (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
                    }
                    
                    break;
                
                case 44:
                    if (cache_started)
                        push_cache();
                    else
                        show_error("\",\" unexpected (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
                    
                    in_key = root_is_struct;
                    break;
                
                case 91:
                    if (root == undefined)
                    {
                        root = [];
                    }
                    else if (!in_key)
                    {
                        buffer_seek(buffer, buffer_seek_relative, -1);
                        cache_started = true;
                        cache_value = new __snap_from_json_parser(buffer, buffer_size, cache_buffer).root;
                    }
                    else
                    {
                        show_error("\"[\" unexpected (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
                    }
                    
                    break;
                
                case 123:
                    if (root == undefined)
                    {
                        root = {};
                        root_is_struct = true;
                        in_key = true;
                    }
                    else if (!in_key)
                    {
                        buffer_seek(buffer, buffer_seek_relative, -1);
                        cache_started = true;
                        cache_value = new __snap_from_json_parser(buffer, buffer_size, cache_buffer).root;
                    }
                    else
                    {
                        show_error("\"{\" unexpected (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
                    }
                    
                    break;
                
                case 93:
                case 125:
                    if (cache_started)
                        push_cache();
                    
                    exit;
                    break;
                
                case 47:
                    if (value == 47)
                    {
                        var _next_value = buffer_peek(buffer, buffer_tell(buffer), buffer_u8);
                        
                        if (_next_value == 47)
                        {
                            in_comment = true;
                            one_line_comment = true;
                        }
                        else if (_next_value == 42)
                        {
                            in_comment = true;
                            one_line_comment = false;
                        }
                        else if (root == undefined)
                        {
                            show_error("\"" + chr(value) + "\" found outside of an object or array (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
                            return undefined;
                        }
                        else
                        {
                            buffer_write(cache_buffer, buffer_u8, value);
                            cache_started = true;
                        }
                    }
                    
                    break;
                
                default:
                    if (value > 32)
                    {
                        if (root == undefined)
                        {
                            show_error("\"" + chr(value) + "\" found outside of an object or array (position " + string(buffer_tell(buffer) - 1) + ")\n ", false);
                            return undefined;
                        }
                        else
                        {
                            buffer_write(cache_buffer, buffer_u8, value);
                            cache_started = true;
                        }
                    }
                    
                    break;
            }
        }
    }
}
