function snap_from_ini_string()
{
    var _string = argument[0];
    var _try_real = (argument_count > 1 && argument[1] != undefined) ? argument[1] : true;
    
    if (_try_real)
    {
        show_error("snap_from_ini_string():\nUnfortunately, the [tryReal] feature is currently broken due to beta bugs.\nHopefully they get fixed soon!\n \nIn the meantime, please set [tryReal] to <false>\n ", false);
        _try_real = false;
    }
    
    var _size = string_byte_length(_string) + 1;
    var _buffer = buffer_create(_size, buffer_grow, 1);
    buffer_write(_buffer, buffer_string, _string);
    buffer_seek(_buffer, buffer_seek_start, 0);
    var _skip_whitespace = true;
    var _in_comment = false;
    var _in_key = false;
    var _key_start = -1;
    var _key = "";
    var _in_value = false;
    var _in_string = false;
    var _seen_backslash = false;
    var _value_start = 0;
    var _last_non_whitespace = -1;
    var _in_section = false;
    var _section = undefined;
    var _section_start = 0;
    var _section_struct = undefined;
    var _root = {};
    
    repeat (_size)
    {
        var _value = buffer_read(_buffer, buffer_u8);
        
        if (_in_comment)
        {
            if (_value == 10 || _value == 13)
            {
                _in_comment = false;
                _skip_whitespace = true;
            }
        }
        else if (_value == 59 && !_in_value)
        {
            _in_comment = true;
        }
        else
        {
            if (_skip_whitespace && _value > 32)
                _skip_whitespace = false;
            
            if (!_skip_whitespace)
            {
                if (_in_value)
                {
                    if (_value == 0 || _value == 10 || _value == 13 || _value == 59 || (_in_string && _value == 34 && buffer_peek(_buffer, buffer_tell(_buffer) - 2, buffer_u8) != 92))
                    {
                        if (_value == 59)
                            _in_comment = true;
                        
                        var _old_tell = buffer_tell(_buffer);
                        
                        if (_in_string)
                            _value_start++;
                        
                        buffer_poke(_buffer, _last_non_whitespace + 1, buffer_u8, 0);
                        buffer_seek(_buffer, buffer_seek_start, _value_start);
                        _value = buffer_read(_buffer, buffer_string);
                        buffer_seek(_buffer, buffer_seek_start, _old_tell);
                        
                        if (_seen_backslash)
                        {
                            _value = string_replace_all(_value, "\\\\", "");
                            _value = string_replace_all(_value, "\\", "");
                            _value = string_replace_all(_value, "", "\\");
                        }
                        
                        if (!_in_string && _try_real)
                        {
                            try
                            {
                                _value = real(_value);
                            }
                            catch (_)
                            {
                            }
                        }
                        
                        variable_struct_set(_section_struct, _key, _value);
                        _in_value = false;
                        _in_key = true;
                        _key_start = -1;
                        _skip_whitespace = true;
                        _in_string = false;
                    }
                    else
                    {
                        if (_value_start < 0)
                        {
                            _value_start = buffer_tell(_buffer) - 1;
                            
                            if (_value == 34)
                                _in_string = true;
                        }
                        
                        if (_value > 32)
                            _last_non_whitespace = buffer_tell(_buffer) - 1;
                        
                        if (_value == 32 && buffer_peek(_buffer, buffer_tell(_buffer) - 2, buffer_u8) == 92)
                            _last_non_whitespace = buffer_tell(_buffer) - 1;
                        
                        if (_value == 92)
                            _seen_backslash = true;
                    }
                }
                else if (_value == 91)
                {
                    _in_value = false;
                    _in_key = false;
                    _in_section = true;
                    _section_start = buffer_tell(_buffer);
                }
                else if (_in_section)
                {
                    if (_value == 93)
                    {
                        buffer_poke(_buffer, buffer_tell(_buffer) - 1, buffer_u8, 0);
                        buffer_seek(_buffer, buffer_seek_start, _section_start);
                        _section = buffer_read(_buffer, buffer_string);
                        _section_struct = variable_struct_get(_root, _section);
                        
                        if (_section_struct == undefined)
                        {
                            _section_struct = {};
                            variable_struct_set(_root, _section, _section_struct);
                        }
                        
                        _in_section = false;
                        _in_key = true;
                        _key_start = -1;
                        _skip_whitespace = true;
                    }
                }
                else if (_in_key)
                {
                    if (_key_start < 0)
                        _key_start = buffer_tell(_buffer) - 1;
                    
                    if (_value == 61)
                    {
                        var _old_tell = buffer_tell(_buffer);
                        buffer_poke(_buffer, _last_non_whitespace + 1, buffer_u8, 0);
                        buffer_seek(_buffer, buffer_seek_start, _key_start);
                        _key = buffer_read(_buffer, buffer_string);
                        buffer_seek(_buffer, buffer_seek_start, _old_tell);
                        _in_key = false;
                        _skip_whitespace = true;
                        _in_value = true;
                        _value_start = -1;
                    }
                    else if (_value > 32)
                    {
                        _last_non_whitespace = buffer_tell(_buffer) - 1;
                    }
                }
            }
        }
    }
    
    buffer_delete(_buffer);
    return _root;
}
