function drawSpriteTile(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
{
    var _w = ((1 + arg4) - arg2) / arg6;
    var _h = ((1 + arg5) - arg3) / arg7;
    var _sprite_w = sprite_get_width(arg0);
    var _sprite_h = sprite_get_height(arg0);
    var _tile_offset_x = arg8;
    var _tile_offset_y = arg9;
    var _part_offset_x = _tile_offset_x % _sprite_w;
    var _part_offset_y = _tile_offset_y % _sprite_h;
    
    if (_tile_offset_x > 0)
        _part_offset_x -= _sprite_w;
    
    if (_tile_offset_y > 0)
        _part_offset_y -= _sprite_h;
    
    var _y1 = _part_offset_y;
    
    while (_y1 < _h)
    {
        var _part_y = 0;
        var _y2 = _y1 + _sprite_h;
        
        if (_y1 < 0)
        {
            _part_y = -_y1;
            _y1 = 0;
        }
        
        if (_y2 > _h)
            _y2 = _h;
        
        var _part_h = _y2 - _y1;
        var _x1 = _part_offset_x;
        
        while (_x1 < _w)
        {
            var _part_x = 0;
            var _x2 = _x1 + _sprite_w;
            
            if (_x1 < 0)
            {
                _part_x = -_x1;
                _x1 = 0;
            }
            
            if (_x2 > _w)
                _x2 = _w;
            
            var _part_w = _x2 - _x1;
            draw_sprite_part_ext(arg0, arg1, _part_x, _part_y, _part_w, _part_h, arg2 + (arg6 * _x1), arg3 + (arg7 * _y1), arg6, arg7, arg10, arg11);
            _x1 = _x2;
        }
        
        _y1 = _y2;
    }
}
