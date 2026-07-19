function string_from_file()
{
    var _filename = argument[0];
    var _remove_bom = (argument_count > 1 && argument[1] != undefined) ? argument[1] : true;
    var _buffer = buffer_load(_filename);
    
    if (_remove_bom && buffer_get_size(_buffer) >= 4 && (buffer_peek(_buffer, 0, buffer_u32) & 16777215) == 12565487)
        buffer_seek(_buffer, buffer_seek_start, 3);
    
    var _string = buffer_read(_buffer, buffer_string);
    buffer_delete(_buffer);
    return _string;
}
