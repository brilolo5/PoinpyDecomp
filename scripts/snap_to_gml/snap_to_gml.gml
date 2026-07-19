function snap_to_gml()
{
    var _ds = argument[0];
    var _alphabetise = (argument_count > 1 && argument[1] != undefined) ? argument[1] : false;
    return new __snap_to_gml_parser(_ds, _alphabetise).result;
}

function __snap_to_gml_parser(arg0, arg1) constructor
{
    static parse_struct = function(arg0)
    {
        var _names = variable_struct_get_names(arg0);
        var _count = array_length(_names);
        var _i = 0;
        
        if (alphabetise)
        {
            var _list = ds_list_create();
            
            repeat (_count)
            {
                _list[| _i] = _names[_i];
                _i++;
            }
            
            ds_list_sort(_list, true);
            _i = 0;
            
            repeat (_count)
            {
                array_set(_names, _i, _list[| _i]);
                _i++;
            }
            
            ds_list_destroy(_list);
            _i = 0;
        }
        
        if (_count > 0)
        {
            if (depth != 0)
            {
                buffer_write(buffer, buffer_text, "{\n");
                indent += "    ";
            }
            
            var _written = false;
            
            repeat (_count)
            {
                var _name = _names[_i];
                value = variable_struct_get(arg0, _name);
                
                if (!is_method(value) || false)
                {
                    if (is_struct(_name) || is_array(_name))
                    {
                        show_error("Key type \"" + typeof(_name) + "\" not supported\n ", false);
                        _name = string(ptr(_name));
                    }
                    
                    if (depth == 0)
                    {
                        buffer_write(buffer, buffer_text, indent);
                        buffer_write(buffer, buffer_text, string(_name));
                        buffer_write(buffer, buffer_text, " = ");
                        write_value();
                        buffer_write(buffer, buffer_text, ";\n");
                    }
                    else
                    {
                        buffer_write(buffer, buffer_text, indent);
                        buffer_write(buffer, buffer_text, string(_name));
                        buffer_write(buffer, buffer_text, " : ");
                        write_value();
                        buffer_write(buffer, buffer_text, ",\n");
                    }
                    
                    _written = true;
                }
                
                _i++;
            }
            
            if (depth != 0)
            {
                indent = string_copy(indent, 1, string_length(indent) - 4);
                
                if (_written)
                    buffer_seek(buffer, buffer_seek_relative, -2);
                
                buffer_write(buffer, buffer_text, "\n" + indent + "}");
            }
        }
        else
        {
            buffer_write(buffer, buffer_text, "{}");
        }
    };
    
    static parse_array = function(arg0)
    {
        var _count = array_length(arg0);
        var _i = 0;
        
        if (_count > 0)
        {
            indent += "    ";
            buffer_write(buffer, buffer_text, "[\n");
            
            repeat (_count)
            {
                value = arg0[_i];
                buffer_write(buffer, buffer_text, indent);
                write_value();
                buffer_write(buffer, buffer_text, ",\n");
                _i++;
            }
            
            indent = string_copy(indent, 1, string_length(indent) - 4);
            buffer_seek(buffer, buffer_seek_relative, -2);
            buffer_write(buffer, buffer_text, "\n" + indent + "]");
        }
        else
        {
            buffer_write(buffer, buffer_text, "[]");
        }
    };
    
    static write_value = function()
    {
        if (is_struct(value))
        {
            depth++;
            parse_struct(value);
            depth--;
        }
        else if (is_array(value))
        {
            depth++;
            parse_array(value);
            depth--;
        }
        else if (is_string(value))
        {
            value = string_replace_all(value, "\\", "\\\\");
            value = string_replace_all(value, "\n", "\\n");
            value = string_replace_all(value, "\r", "\\r");
            value = string_replace_all(value, "\t", "\\t");
            value = string_replace_all(value, "\"", "\\\"");
            buffer_write(buffer, buffer_text, "\"");
            buffer_write(buffer, buffer_text, value);
            buffer_write(buffer, buffer_text, "\"");
        }
        else if (is_undefined(value))
        {
            buffer_write(buffer, buffer_text, "undefined");
        }
        else if (is_bool(value))
        {
            buffer_write(buffer, buffer_text, value ? "true" : "false");
        }
        else if (is_real(value))
        {
            value = string_format(value, 0, 10);
            var _length = string_length(value);
            var _i = _length;
            
            repeat (_length)
            {
                if (string_char_at(value, _i) != "0")
                    break;
                
                _i--;
            }
            
            if (string_char_at(value, _i) == ".")
                _i--;
            
            value = string_delete(value, _i + 1, _length - _i);
            buffer_write(buffer, buffer_text, value);
        }
        else if (is_method(value))
        {
            buffer_write(buffer, buffer_text, "undefined");
        }
        else
        {
            buffer_write(buffer, buffer_text, string(value));
        }
    };
    
    root = arg0;
    alphabetise = arg1;
    depth = 0;
    result = "";
    buffer = buffer_create(1024, buffer_grow, 1);
    indent = "";
    
    if (is_struct(root))
        parse_struct(root);
    else
        show_error("Value not a struct. Returning empty string\n ", false);
    
    buffer_seek(buffer, buffer_seek_start, 0);
    result = buffer_read(buffer, buffer_string);
    buffer_delete(buffer);
}
