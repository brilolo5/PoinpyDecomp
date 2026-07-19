function scribble_glyph_set(arg0, arg1, arg2, arg3, arg4 = false)
{
    if (!ds_map_exists(global.__scribble_font_data, arg0))
    {
        __scribble_error("Font \"", arg0, "\" not found");
        exit;
    }
    
    var _font_data = global.__scribble_font_data[? arg0];
    var _map = _font_data.glyphs_map;
    
    if (arg1 == -3 || arg1 == "all")
    {
        _map = _font_data.glyphs_map;
        var _key = ds_map_find_first(_map);
        
        repeat (ds_map_size(_map))
        {
            var _glyph_data = _map[? _key];
            array_set(_glyph_data, arg2, arg4 ? (_glyph_data[arg2] + arg3) : arg3);
            _key = ds_map_find_next(_map, _key);
        }
    }
    else
    {
        var _ord = ord(arg1);
        var _glyph_data = _map[? _ord];
        
        if (_glyph_data == undefined)
        {
            __scribble_error("Character \"", arg1, "\" not found for font \"", arg0, "\"");
            exit;
        }
        
        var _new_value = arg4 ? (_glyph_data[arg2] + arg3) : arg3;
        array_set(_glyph_data, arg2, _new_value);
        
        if (_ord == 32)
        {
            if (arg2 == UnknownEnum.Value_6)
                array_set(_glyph_data, UnknownEnum.Value_2, _new_value);
            
            if (arg2 == UnknownEnum.Value_2)
                array_set(_glyph_data, UnknownEnum.Value_6, _new_value);
        }
        
        return _new_value;
    }
}
