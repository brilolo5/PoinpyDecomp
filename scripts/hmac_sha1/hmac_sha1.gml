function hmac_sha1(arg0, arg1)
{
    var _hash;
    var _block_size = 64;
    var _return_size = 20;
    var _inner_pad_buffer = buffer_create(_block_size + string_byte_length(arg1), buffer_fixed, 1);
    var _outer_pad_buffer = buffer_create(_block_size + _return_size, buffer_fixed, 1);
    var _key_length = string_byte_length(arg0);
    
    if (_key_length > _block_size)
    {
        _hash = sha1_string_utf8(arg0);
        var _n = 1;
        
        repeat (_return_size)
        {
            var _ord_msf = string_byte_at(_hash, _n);
            var _ord_lsf = string_byte_at(_hash, _n + 1);
            var _value = (((_ord_msf >= 97) ? (_ord_msf - 87) : (_ord_msf - 48)) << 4) | ((_ord_lsf >= 97) ? (_ord_lsf - 87) : (_ord_lsf - 48));
            buffer_write(_inner_pad_buffer, buffer_u8, 54 ^ _value);
            buffer_write(_outer_pad_buffer, buffer_u8, 92 ^ _value);
            _n += 2;
        }
        
        _key_length = _return_size;
    }
    else
    {
        var _n = 1;
        
        repeat (_key_length)
        {
            var _value = string_byte_at(arg0, _n);
            buffer_write(_inner_pad_buffer, buffer_u8, 54 ^ _value);
            buffer_write(_outer_pad_buffer, buffer_u8, 92 ^ _value);
            _n++;
        }
    }
    
    buffer_fill(_inner_pad_buffer, _key_length, buffer_u8, 54, _block_size - _key_length);
    buffer_fill(_outer_pad_buffer, _key_length, buffer_u8, 92, _block_size - _key_length);
    buffer_seek(_inner_pad_buffer, buffer_seek_start, _block_size);
    buffer_seek(_outer_pad_buffer, buffer_seek_start, _block_size);
    buffer_write(_inner_pad_buffer, buffer_text, arg1);
    _hash = buffer_sha1(_inner_pad_buffer, 0, buffer_tell(_inner_pad_buffer));
    var n = 1;
    
    repeat (_return_size)
    {
        var _ord_msf = string_byte_at(_hash, n);
        var _ord_lsf = string_byte_at(_hash, n + 1);
        buffer_write(_outer_pad_buffer, buffer_u8, (((_ord_msf >= 97) ? (_ord_msf - 87) : (_ord_msf - 48)) << 4) | ((_ord_lsf >= 97) ? (_ord_lsf - 87) : (_ord_lsf - 48)));
        n += 2;
    }
    
    var _result = buffer_sha1(_outer_pad_buffer, 0, buffer_tell(_outer_pad_buffer));
    buffer_delete(_inner_pad_buffer);
    buffer_delete(_outer_pad_buffer);
    return _result;
}
