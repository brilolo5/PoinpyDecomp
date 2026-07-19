function snap_from_binary()
{
    var _buffer = argument[0];
    var _offset = (argument_count > 1 && argument[1] != undefined) ? argument[1] : 0;
    var _destroy_buffer = (argument_count > 2 && argument[2] != undefined) ? argument[2] : false;
    var _old_tell = buffer_tell(_buffer);
    buffer_seek(_buffer, buffer_seek_start, _offset);
    var _result = new __snap_from_binary_parser(_buffer).root;
    buffer_seek(_buffer, buffer_seek_start, _old_tell);
    
    if (_destroy_buffer)
        buffer_delete(_buffer);
    
    return _result;
}

function __snap_from_binary_parser(arg0) constructor
{
    buffer = arg0;
    root = undefined;
    root_is_struct = false;
    root_array_size = 0;
    in_key = false;
    key = undefined;
    
    while (true)
    {
        if (in_key)
        {
            value = buffer_read(buffer, buffer_u8);
            
            if (value == 0)
            {
                exit;
            }
            else if (value == 3)
            {
                key = buffer_read(buffer, buffer_string);
            }
            else
            {
                show_error("Datatype for keys must be string (0x03), found " + string(value) + "\n ", false);
                key = undefined;
            }
            
            in_key = false;
        }
        else
        {
            value = buffer_read(buffer, buffer_u8);
            
            if (root == undefined)
            {
                if (value == 1)
                {
                    root = {};
                    root_is_struct = true;
                }
                else if (value == 2)
                {
                    root = [];
                }
                else
                {
                    show_error("Unexpected datatype " + string(value) + ", was looking for a struct (0x01) or array (0x02) (position = " + string(buffer_tell(buffer) - 1) + ")\n ", false);
                }
            }
            else
            {
                switch (value)
                {
                    case 0:
                        exit;
                        break;
                    
                    case 1:
                    case 2:
                        buffer_seek(buffer, buffer_seek_relative, -1);
                        value = new __snap_from_binary_parser(arg0).root;
                        break;
                    
                    case 3:
                        value = buffer_read(buffer, buffer_string);
                        break;
                    
                    case 4:
                        value = buffer_read(buffer, buffer_f64);
                        break;
                    
                    case 5:
                        value = false;
                        break;
                    
                    case 6:
                        value = true;
                        break;
                    
                    case 7:
                        value = undefined;
                        break;
                    
                    case 8:
                        value = buffer_read(buffer, buffer_s32);
                        break;
                    
                    case 9:
                        value = int64(buffer_read(buffer, buffer_u64));
                        break;
                    
                    default:
                        show_error("Unsupported datatype " + string(value) + " (position = " + string(buffer_tell(buffer) - 1) + ")\n ", false);
                        value = undefined;
                        break;
                }
                
                if (root_is_struct)
                    variable_struct_set(root, key, value);
                else
                    array_set(root, root_array_size++, value);
            }
            
            in_key = root_is_struct;
        }
    }
}
