function snap_from_yaml()
{
    var _string = argument[0];
    var _replace_keywords = (argument_count > 1 && argument[1] != undefined) ? argument[1] : true;
    var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
    buffer_write(_buffer, buffer_text, _string);
    buffer_seek(_buffer, buffer_seek_start, 0);
    var _tokens_array = new __snap_from_yaml_tokenizer(_buffer).result;
    buffer_delete(_buffer);
    return new __snap_from_yaml_builder(_tokens_array, _replace_keywords).result;
}

function __snap_from_yaml_tokenizer(arg0) constructor
{
    static read_chunk = function(arg0, arg1, arg2)
    {
        if (arg1 <= arg0)
            return undefined;
        
        var _value = buffer_peek(buffer, arg1, buffer_u8);
        buffer_poke(buffer, arg1, buffer_u8, 0);
        buffer_seek(buffer, buffer_seek_start, arg0);
        var _string = buffer_read(buffer, buffer_string);
        buffer_poke(buffer, arg1, buffer_u8, _value);
        buffer_seek(buffer, buffer_seek_start, arg2);
        return _string;
    };
    
    static read_chunk_and_add = function(arg0, arg1, arg2, arg3)
    {
        var _chunk = read_chunk(arg0, arg1, arg2);
        
        if (_chunk != undefined)
            array_set(result, array_length(result), [arg3, _chunk]);
    };
    
    buffer = arg0;
    var _buffer_size = buffer_get_size(arg0);
    var _tokens_array = [];
    result = _tokens_array;
    var _chunk_start = 0;
    var _chunk_end = 0;
    var _indent_search = true;
    var _json_depth = 0;
    var _scalar_first_character = false;
    var _scalar_has_content = false;
    var _in_string = false;
    var _string_start = undefined;
    var _in_comment = false;
    
    while (buffer_tell(arg0) < _buffer_size)
    {
        var _value = buffer_read(arg0, buffer_u8);
        
        if (_in_comment)
        {
            if (_value == 0 || _value == 10 || _value == 13)
            {
                array_set(_tokens_array, array_length(_tokens_array), [UnknownEnum.Value_1]);
                _chunk_start = buffer_tell(arg0);
                _chunk_end = buffer_tell(arg0);
                _in_comment = false;
            }
        }
        else if (_indent_search)
        {
            if (_value == 0)
            {
                break;
            }
            else if (_value == 10 || _value == 13)
            {
                array_set(_tokens_array, array_length(_tokens_array), [UnknownEnum.Value_1]);
                _chunk_start = buffer_tell(arg0);
                _chunk_end = buffer_tell(arg0);
            }
            else if (_value > 32)
            {
                read_chunk_and_add(_chunk_start, buffer_tell(arg0) - 1, buffer_tell(arg0), UnknownEnum.Value_0);
                buffer_seek(arg0, buffer_seek_relative, -1);
                _chunk_start = buffer_tell(arg0);
                _chunk_end = buffer_tell(arg0);
                _indent_search = false;
                _scalar_first_character = true;
                _scalar_has_content = false;
            }
        }
        else if (_scalar_first_character && _value == 45)
        {
            var _next_value = buffer_peek(arg0, buffer_tell(arg0), buffer_u8);
            
            if (_next_value == 10 || _next_value == 13)
            {
                array_set(_tokens_array, array_length(_tokens_array), [UnknownEnum.Value_2]);
                _chunk_start = buffer_tell(arg0);
                _chunk_end = buffer_tell(arg0);
                _indent_search = false;
            }
            else if (_next_value == 32)
            {
                array_set(_tokens_array, array_length(_tokens_array), [UnknownEnum.Value_2]);
                buffer_seek(arg0, buffer_seek_relative, 1);
                _chunk_start = buffer_tell(arg0);
                _chunk_end = buffer_tell(arg0);
            }
            else if (_next_value == 45)
            {
                if (buffer_tell(arg0) <= (_buffer_size - 4) && buffer_peek(arg0, buffer_tell(arg0), buffer_u32) == 589311277)
                    _in_comment = true;
            }
        }
        else if (_scalar_first_character && _value == 35)
        {
            var _next_value = buffer_peek(arg0, buffer_tell(arg0), buffer_u8);
            
            if (_next_value == 32)
                _in_comment = true;
        }
        else
        {
            _scalar_first_character = false;
            
            if (_in_string)
            {
                if (_value == 34 && buffer_peek(arg0, buffer_tell(arg0) - 2, buffer_u8) != 92)
                {
                    read_chunk_and_add(_chunk_start + 1, buffer_tell(arg0) - 1, buffer_tell(arg0), UnknownEnum.Value_5);
                    _chunk_start = buffer_tell(arg0);
                    _chunk_end = buffer_tell(arg0);
                    _in_string = false;
                    _scalar_has_content = false;
                }
            }
            else
            {
                if (_value <= 32)
                {
                    if (!_scalar_has_content)
                        _chunk_start = buffer_tell(arg0);
                }
                else
                {
                    _scalar_has_content = true;
                }
                
                if (_value == 34)
                {
                    _in_string = true;
                    _string_start = buffer_tell(arg0);
                }
                else if (_value == 35 && buffer_tell(arg0) >= 1 && buffer_peek(arg0, buffer_tell(arg0) - 2, buffer_u8) <= 32)
                {
                    read_chunk_and_add(_chunk_start, _chunk_end, buffer_tell(arg0), UnknownEnum.Value_4);
                    _chunk_start = buffer_tell(arg0);
                    _chunk_end = buffer_tell(arg0);
                    _in_comment = true;
                }
                else if (_value == 91 || _value == 93 || _value == 123 || _value == 125)
                {
                    read_chunk_and_add(_chunk_start, _chunk_end, buffer_tell(arg0), UnknownEnum.Value_4);
                    
                    if (_value == 91 || _value == 123)
                    {
                        _json_depth++;
                        array_set(_tokens_array, array_length(_tokens_array), [(_value == 91) ? UnknownEnum.Value_6 : UnknownEnum.Value_8]);
                    }
                    else if (_value == 93 || _value == 125)
                    {
                        _json_depth--;
                        array_set(_tokens_array, array_length(_tokens_array), [(_value == 93) ? UnknownEnum.Value_7 : UnknownEnum.Value_9]);
                    }
                    
                    _chunk_start = buffer_tell(arg0);
                    _chunk_end = buffer_tell(arg0);
                    _scalar_has_content = false;
                }
                else if (_json_depth > 0 && _value == 44)
                {
                    read_chunk_and_add(_chunk_start, _chunk_end, buffer_tell(arg0), UnknownEnum.Value_4);
                    array_set(_tokens_array, array_length(_tokens_array), [UnknownEnum.Value_10]);
                    _chunk_start = buffer_tell(arg0);
                    _chunk_end = buffer_tell(arg0);
                    _scalar_has_content = false;
                }
                else if (_value == 58)
                {
                    if (_json_depth > 0)
                    {
                        read_chunk_and_add(_chunk_start, _chunk_end, buffer_tell(arg0), UnknownEnum.Value_4);
                        array_set(_tokens_array, array_length(_tokens_array), [UnknownEnum.Value_11]);
                        _chunk_start = buffer_tell(arg0);
                        _chunk_end = buffer_tell(arg0);
                        _scalar_has_content = false;
                    }
                    else
                    {
                        read_chunk_and_add(_chunk_start, _chunk_end, buffer_tell(arg0), UnknownEnum.Value_4);
                        array_set(_tokens_array, array_length(_tokens_array), [UnknownEnum.Value_3]);
                        var _next_value = buffer_peek(arg0, buffer_tell(arg0), buffer_u8);
                        
                        if (_next_value == 10 || _next_value == 13)
                        {
                            _chunk_start = buffer_tell(arg0);
                            _chunk_end = buffer_tell(arg0);
                            _indent_search = false;
                        }
                        else if (_next_value == 32)
                        {
                            buffer_seek(arg0, buffer_seek_relative, 1);
                            _chunk_start = buffer_tell(arg0);
                            _chunk_end = buffer_tell(arg0);
                            _scalar_first_character = true;
                        }
                    }
                }
                else if (_value == 0 || _value == 10 || _value == 13)
                {
                    read_chunk_and_add(_chunk_start, _chunk_end, buffer_tell(arg0), UnknownEnum.Value_4);
                    array_set(_tokens_array, array_length(_tokens_array), [UnknownEnum.Value_1]);
                    _chunk_start = buffer_tell(arg0);
                    _chunk_end = buffer_tell(arg0);
                    _indent_search = true;
                }
                
                if (_value > 32)
                    _chunk_end = buffer_tell(arg0);
            }
        }
    }
}

function __snap_from_yaml_builder(arg0, arg1) constructor
{
    static read_to_next = function()
    {
        while (token_index < token_count)
        {
            var _type = tokens_array[token_index][0];
            
            if (_type == UnknownEnum.Value_1)
            {
                line++;
                indent = 0;
            }
            else if (_type == UnknownEnum.Value_0)
            {
                var _indent_string = tokens_array[token_index][1];
                indent = string_count(" ", _indent_string);
            }
            else
            {
                break;
            }
            
            token_index++;
        }
    };
    
    static read = function()
    {
        var _token = tokens_array[token_index];
        token_index++;
        var _type = _token[0];
        
        if (_type == UnknownEnum.Value_4 || _type == UnknownEnum.Value_5)
        {
            if (tokens_array[token_index][0] == UnknownEnum.Value_3)
            {
                var _indent_limit = indent;
                var _struct = {};
                token_index--;
                
                while (token_index < token_count)
                {
                    var _key = tokens_array[token_index][1];
                    token_index += 2;
                    var _last_line = line;
                    read_to_next();
                    
                    if (indent <= _indent_limit && line != _last_line)
                        variable_struct_set(_struct, _key, undefined);
                    else
                        variable_struct_set(_struct, _key, read());
                    
                    read_to_next();
                    
                    if (indent < _indent_limit)
                        break;
                }
                
                return _struct;
            }
            else
            {
                var _result = _token[1];
                
                if (_type == UnknownEnum.Value_5)
                {
                    _result = string_replace_all(_result, "\\\"", "\"");
                    _result = string_replace_all(_result, "\\\t", "\t");
                    _result = string_replace_all(_result, "\\\r", "\r");
                    _result = string_replace_all(_result, "\\\n", "\n");
                    _result = string_replace_all(_result, "\\\\", "\\");
                }
                else
                {
                    try
                    {
                        _result = real(_result);
                    }
                    catch (_error)
                    {
                        if (replace_keywords)
                        {
                            switch (string_lower(_result))
                            {
                                case "true":
                                    _result = true;
                                    break;
                                
                                case "false":
                                    _result = false;
                                    break;
                                
                                case "null":
                                    _result = undefined;
                                    break;
                            }
                        }
                    }
                }
                
                return _result;
            }
        }
        else if (_type == UnknownEnum.Value_2)
        {
            var _indent_limit = indent;
            var _array = [];
            token_index--;
            
            while (token_index < token_count)
            {
                if (tokens_array[token_index][0] != UnknownEnum.Value_2)
                    break;
                
                token_index++;
                var _last_line = line;
                read_to_next();
                
                if (indent <= _indent_limit && line != _last_line)
                {
                    array_set(_array, array_length(_array), undefined);
                }
                else
                {
                    indent += 2;
                    array_set(_array, array_length(_array), read());
                }
                
                read_to_next();
                
                if (indent < _indent_limit)
                    break;
            }
            
            return _array;
        }
        else if (_type == UnknownEnum.Value_6)
        {
            var _array = [];
            read_to_next();
            
            while (token_index < token_count && tokens_array[token_index][0] != UnknownEnum.Value_7)
            {
                array_set(_array, array_length(_array), read());
                read_to_next();
                
                if (tokens_array[token_index][0] == UnknownEnum.Value_10)
                {
                    token_index++;
                    read_to_next();
                }
            }
            
            token_index++;
            return _array;
        }
        else if (_type == UnknownEnum.Value_8)
        {
            var _struct = {};
            read_to_next();
            
            while (token_index < token_count && tokens_array[token_index][0] != UnknownEnum.Value_9)
            {
                var _key = read();
                read_to_next();
                
                if (tokens_array[token_index][0] == UnknownEnum.Value_11)
                {
                    token_index++;
                    read_to_next();
                }
                
                variable_struct_set(_struct, _key, read());
                read_to_next();
                
                if (tokens_array[token_index][0] == UnknownEnum.Value_10)
                {
                    token_index++;
                    read_to_next();
                }
            }
            
            token_index++;
            return _struct;
        }
        else
        {
            throw "Unexpected error";
        }
        
        return undefined;
    };
    
    tokens_array = arg0;
    replace_keywords = arg1;
    token_count = array_length(tokens_array);
    token_index = 0;
    indent = 0;
    line = 0;
    read_to_next();
    result = read();
}
