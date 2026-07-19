function snap_to_xml()
{
    var _ds = argument[0];
    var _alphabetise = (argument_count > 1 && argument[1] != undefined) ? argument[1] : false;
    return new __snap_to_xml_parser(_ds, _alphabetise).result;
}

function __snap_to_xml_parser(arg0, arg1) constructor
{
    var _names;
    var _i;
    var _count;
    static write_node = function(arg0, arg1)
    {
        buffer_write(buffer, buffer_text, indent);
        buffer_write(buffer, buffer_text, "<");
        buffer_write(buffer, buffer_text, arg0);
        var _attribute_struct = variable_struct_get(arg1, "_attr");
        
        if (is_struct(_attribute_struct))
        {
            _names = variable_struct_get_names(_attribute_struct);
            _count = array_length(_names);
            _i = 0;
            
            repeat (_count)
            {
                var _key = _names[_i];
                var _value = variable_struct_get(_attribute_struct, _key);
                
                if (!is_method(_value) || false)
                {
                    buffer_write(buffer, buffer_text, " ");
                    buffer_write(buffer, buffer_text, _key);
                    buffer_write(buffer, buffer_text, "=\"");
                    buffer_write(buffer, buffer_text, string(_value));
                    buffer_write(buffer, buffer_text, "\"");
                }
                else
                {
                    show_error("Functions/methods cannot be serialised\n(Please edit macro SNAP_XML_SERIALISE_FUNCTION_NAMES to change this behaviour)\n ", true);
                }
                
                _i++;
            }
        }
        
        buffer_write(buffer, buffer_text, ">");
        _names = variable_struct_get_names(arg1);
        _count = array_length(_names);
        var _content = variable_struct_get(arg1, "_text");
        
        if (_content != undefined)
        {
            buffer_write(buffer, buffer_text, string(_content));
        }
        else if (_count > 0)
        {
            if (alphabetise)
            {
                var _list = ds_list_create();
                _i = 0;
                
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
            
            var _old_indent = indent;
            indent += "    ";
            _i = 0;
            
            repeat (_count)
            {
                var _key = _names[_i];
                
                if (_key != "_attr" && _key != "_text")
                {
                    var _value = variable_struct_get(arg1, _key);
                    
                    if (is_struct(_value))
                    {
                        buffer_write(buffer, buffer_u8, 13);
                        write_node(_key, _value);
                    }
                    else if (is_array(_value))
                    {
                        var _j = 0;
                        
                        repeat (array_length(_value))
                        {
                            buffer_write(buffer, buffer_u8, 13);
                            write_node(_key, _value[_j]);
                            _j++;
                        }
                    }
                }
                
                _i++;
            }
            
            indent = _old_indent;
            buffer_write(buffer, buffer_u8, 13);
            buffer_write(buffer, buffer_text, indent);
        }
        
        buffer_write(buffer, buffer_text, "</");
        buffer_write(buffer, buffer_text, arg0);
        buffer_write(buffer, buffer_text, ">");
    };
    
    alphabetise = arg1;
    result = "";
    buffer = buffer_create(1024, buffer_grow, 1);
    indent = "";
    var _prolog_struct = variable_struct_get(arg0, "_prolog");
    
    if (is_struct(_prolog_struct))
    {
        var _attribute_struct = variable_struct_get(_prolog_struct, "_attr");
        
        if (is_struct(_attribute_struct))
        {
            _names = variable_struct_get_names(_attribute_struct);
            _count = array_length(_names);
            
            if (_count > 0)
            {
                buffer_write(buffer, buffer_text, "<?xml");
                _i = 0;
                
                repeat (_count)
                {
                    var _key = _names[_i];
                    var _value = variable_struct_get(_attribute_struct, _key);
                    
                    if (!is_method(_value) || false)
                    {
                        buffer_write(buffer, buffer_text, " ");
                        buffer_write(buffer, buffer_text, _key);
                        buffer_write(buffer, buffer_text, "=\"");
                        buffer_write(buffer, buffer_text, string(_value));
                        buffer_write(buffer, buffer_text, "\"");
                    }
                    else
                    {
                        show_error("Functions/methods cannot be serialised\n(Please edit macro SNAP_XML_SERIALISE_FUNCTION_NAMES to change this behaviour)\n ", true);
                    }
                    
                    _i++;
                }
                
                buffer_write(buffer, buffer_text, "?>\n");
            }
        }
    }
    
    _names = variable_struct_get_names(arg0);
    _count = array_length(_names);
    _i = 0;
    
    repeat (_count)
    {
        var _key = _names[_i];
        var _value = variable_struct_get(arg0, _key);
        
        if (_key != "_prolog")
        {
            if (!is_method(_value) || false)
                write_node(_key, _value);
            else
                show_error("Functions/methods cannot be serialised\n(Please edit macro SNAP_XML_SERIALISE_FUNCTION_NAMES to change this behaviour)\n ", true);
        }
        
        _i++;
    }
    
    buffer_seek(buffer, buffer_seek_start, 0);
    result = buffer_read(buffer, buffer_string);
    buffer_delete(buffer);
}
