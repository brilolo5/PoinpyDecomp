function snap_from_messagepack()
{
    var _buffer = argument[0];
    var _offset = (argument_count > 1 && argument[1] != undefined) ? argument[1] : 0;
    var _destroy_buffer = (argument_count > 2 && argument[2] != undefined) ? argument[2] : false;
    var _old_tell = buffer_tell(_buffer);
    buffer_seek(_buffer, buffer_seek_start, _offset);
    var _result = new __snap_from_messagepack_parser(_buffer).root;
    buffer_seek(_buffer, buffer_seek_start, _old_tell);
    
    if (_destroy_buffer)
        buffer_delete(_buffer);
    
    return _result;
}

function __snap_from_messagepack_parser(arg0) constructor
{
    static read_struct = function(arg0)
    {
        var _struct = {};
        
        repeat (arg0)
        {
            var _key = read_value();
            var _value = read_value();
            variable_struct_set(_struct, _key, _value);
        }
        
        return _struct;
    };
    
    static read_array = function(arg0)
    {
        var _array = array_create(arg0, undefined);
        var _i = 0;
        
        repeat (arg0)
        {
            array_set(_array, _i, read_value());
            _i++;
        }
        
        return _array;
    };
    
    static read_string = function(arg0)
    {
        var _null_position = buffer_tell(buffer) + arg0;
        
        if (_null_position >= buffer_get_size(buffer))
            return buffer_read(buffer, buffer_text);
        
        var _peek = buffer_peek(buffer, _null_position, buffer_u8);
        buffer_poke(buffer, _null_position, buffer_u8, 0);
        var _string = buffer_read(buffer, buffer_string);
        buffer_seek(buffer, buffer_seek_relative, -1);
        buffer_poke(buffer, _null_position, buffer_u8, _peek);
        return _string;
    };
    
    static read_bin = function(arg0)
    {
        var _array = array_create(arg0);
        var _i = 0;
        
        repeat (arg0)
        {
            array_set(_array, _i, buffer_read(buffer, buffer_u8));
            _i++;
        }
        
        return 
        {
            messagepack_datatype__: "bin",
            data: _array
        };
    };
    
    static read_ext = function(arg0)
    {
        var _type = buffer_read(buffer, buffer_s8);
        var _array = array_create(arg0);
        var _i = 0;
        
        repeat (arg0)
        {
            array_set(_array, _i, buffer_read(buffer, buffer_u8));
            _i++;
        }
        
        return 
        {
            messagepack_datatype__: "ext",
            type: _type,
            data: _array
        };
    };
    
    static buffer_read_little = function(arg0)
    {
        switch (buffer_sizeof(arg0))
        {
            case 1:
                return buffer_read(buffer, arg0);
            
            case 2:
                buffer_poke(flip_buffer, 1, buffer_u8, buffer_read(buffer, buffer_u8));
                buffer_poke(flip_buffer, 0, buffer_u8, buffer_read(buffer, buffer_u8));
                break;
            
            case 4:
                buffer_poke(flip_buffer, 3, buffer_u8, buffer_read(buffer, buffer_u8));
                buffer_poke(flip_buffer, 2, buffer_u8, buffer_read(buffer, buffer_u8));
                buffer_poke(flip_buffer, 1, buffer_u8, buffer_read(buffer, buffer_u8));
                buffer_poke(flip_buffer, 0, buffer_u8, buffer_read(buffer, buffer_u8));
                break;
            
            case 8:
                buffer_poke(flip_buffer, 7, buffer_u8, buffer_read(buffer, buffer_u8));
                buffer_poke(flip_buffer, 6, buffer_u8, buffer_read(buffer, buffer_u8));
                buffer_poke(flip_buffer, 5, buffer_u8, buffer_read(buffer, buffer_u8));
                buffer_poke(flip_buffer, 4, buffer_u8, buffer_read(buffer, buffer_u8));
                buffer_poke(flip_buffer, 3, buffer_u8, buffer_read(buffer, buffer_u8));
                buffer_poke(flip_buffer, 2, buffer_u8, buffer_read(buffer, buffer_u8));
                buffer_poke(flip_buffer, 1, buffer_u8, buffer_read(buffer, buffer_u8));
                buffer_poke(flip_buffer, 0, buffer_u8, buffer_read(buffer, buffer_u8));
                break;
        }
        
        return buffer_peek(flip_buffer, 0, arg0);
    };
    
    static read_value = function()
    {
        var _byte = buffer_read(buffer, buffer_u8);
        
        if (_byte <= 127)
        {
            return int64(_byte & 127);
        }
        else if (_byte <= 143)
        {
            return read_struct(_byte & 15);
        }
        else if (_byte <= 159)
        {
            return read_array(_byte & 15);
        }
        else if (_byte <= 191)
        {
            return read_string(_byte & 31);
        }
        else if (_byte >= 224 && _byte <= 255)
        {
            return -(_byte & 31);
        }
        else
        {
            switch (_byte)
            {
                case 192:
                    return undefined;
                
                case 193:
                    show_debug_message("snap_from_binary(): WARNING! Datatype 0xc1 found, but this value should never be used");
                    break;
                
                case 194:
                    return bool(false);
                
                case 195:
                    return bool(true);
                
                case 196:
                    return read_bin(buffer_read(buffer, buffer_u8));
                
                case 197:
                    return read_bin(buffer_read_little(3));
                
                case 198:
                    return read_bin(buffer_read_little(5));
                
                case 199:
                    return read_ext(buffer_read(buffer, buffer_u8));
                
                case 200:
                    return read_ext(buffer_read_little(3));
                
                case 201:
                    return read_ext(buffer_read_little(5));
                
                case 202:
                    return buffer_read_little(8);
                
                case 203:
                    return buffer_read_little(9);
                
                case 204:
                    return buffer_read(buffer, buffer_u8);
                
                case 205:
                    return buffer_read_little(3);
                
                case 206:
                    return buffer_read_little(5);
                
                case 207:
                    return buffer_read_little(12);
                
                case 208:
                    return buffer_read(buffer, buffer_s8);
                
                case 209:
                    return buffer_read_little(4);
                
                case 210:
                    return buffer_read_little(6);
                
                case 211:
                    return buffer_read_little(12);
                
                case 212:
                    return read_ext(1);
                
                case 213:
                    return read_ext(2);
                
                case 214:
                    return read_ext(4);
                
                case 215:
                    return read_ext(8);
                
                case 216:
                    return read_ext(16);
                
                case 217:
                    return read_string(buffer_read(buffer, buffer_u8));
                
                case 218:
                    return read_string(buffer_read_little(3));
                
                case 219:
                    return read_string(buffer_read_little(5));
                
                case 220:
                    return read_array(buffer_read_little(3));
                
                case 221:
                    return read_array(buffer_read_little(5));
                
                case 222:
                    return read_struct(buffer_read_little(3));
                
                case 223:
                    return read_struct(buffer_read_little(5));
                
                default:
                    show_debug_message("snap_from_binary(): WARNING! Unsupported datatype " + string(_byte) + " found");
                    break;
            }
        }
        
        return undefined;
    };
    
    buffer = arg0;
    flip_buffer = buffer_create(8, buffer_fixed, 1);
    root = read_value();
    buffer_delete(flip_buffer);
}
