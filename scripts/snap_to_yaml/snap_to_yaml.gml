function snap_to_yaml()
{
    var _ds = argument[0];
    var _alphabetise = (argument_count > 1 && argument[1] != undefined) ? argument[1] : false;
    return new __snap_to_yaml_parser(_ds, _alphabetise).result;
}

function __snap_to_yaml_parser(arg0, arg1) constructor
{
    static parse_struct = function(arg0)
    {
        var _names = variable_struct_get_names(arg0);
        var _count = array_length(_names);
        
        if (alphabetise)
        {
            var _list = ds_list_create();
            var _i = 0;
            
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
        }
        
        if (_count > 0)
        {
            var _written = false;
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
                    
                    if (_i > 0)
                    {
                        repeat (indent)
                            buffer_write(buffer, buffer_u16, 8224);
                    }
                    
                    buffer_write(buffer, buffer_text, string(_name));
                    buffer_write(buffer, buffer_text, ": ");
                    
                    if (is_struct(value))
                    {
                        if (variable_struct_names_count(value) > 0)
                        {
                            buffer_write(buffer, buffer_text, "\n");
                            
                            repeat (indent + 1)
                                buffer_write(buffer, buffer_u16, 8224);
                        }
                    }
                    else if (is_array(value))
                    {
                        if (array_length(value) > 0)
                        {
                            buffer_write(buffer, buffer_text, "\n");
                            
                            repeat (indent + 1)
                                buffer_write(buffer, buffer_u16, 8224);
                        }
                    }
                    
                    indent++;
                    write_value();
                    indent--;
                    buffer_write(buffer, buffer_text, "\n");
                    _written = true;
                }
                
                _i++;
            }
            
            if (_written)
                buffer_seek(buffer, buffer_seek_relative, -1);
        }
        else
        {
            buffer_write(buffer, buffer_text, "{}");
        }
    };
    
    static parse_array = function(arg0)
    {
        var _count = array_length(arg0);
        
        if (_count > 0)
        {
            var _i = 0;
            
            repeat (_count)
            {
                value = arg0[_i];
                
                if (_i > 0)
                {
                    repeat (indent)
                        buffer_write(buffer, buffer_u16, 8224);
                }
                
                buffer_write(buffer, buffer_u16, 8237);
                indent++;
                write_value();
                indent--;
                buffer_write(buffer, buffer_text, "\n");
                _i++;
            }
            
            buffer_seek(buffer, buffer_seek_relative, -1);
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
            parse_struct(value);
        }
        else if (is_array(value))
        {
            parse_array(value);
        }
        else if (is_string(value))
        {
            var _length = string_length(value);
            var _has_colon = string_pos(":", value) > 0;
            value = string_replace_all(value, "\\", "\\\\");
            value = string_replace_all(value, "\"", "\\\"");
            value = string_replace_all(value, "\n", "\\n");
            value = string_replace_all(value, "\r", "\\r");
            value = string_replace_all(value, "\t", "\\t");
            
            if (_length != string_length(value) || _has_colon)
            {
                buffer_write(buffer, buffer_text, "\"");
                buffer_write(buffer, buffer_text, value);
                buffer_write(buffer, buffer_text, "\"");
            }
            else
            {
                buffer_write(buffer, buffer_text, value);
            }
        }
        else if (is_undefined(value))
        {
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
            show_error("Functions/methods cannot be serialised\n(Please edit macro SNAP_YAML_SERIALISE_FUNCTION_NAMES to change this behaviour)\n ", true);
            buffer_write(buffer, buffer_text, "null");
        }
        else
        {
            buffer_write(buffer, buffer_text, string(value));
        }
    };
    
    root = arg0;
    alphabetise = arg1;
    result = "";
    buffer = buffer_create(1024, buffer_grow, 1);
    indent = 0;
    
    if (is_struct(root))
        parse_struct(root);
    else if (is_array(root))
        parse_array(root);
    else
        show_error("Value not struct or array. Returning empty string\n ", false);
    
    buffer_seek(buffer, buffer_seek_start, 0);
    result = buffer_read(buffer, buffer_string);
    buffer_delete(buffer);
}
