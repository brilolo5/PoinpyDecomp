function scribble_font_collage_glyph_copy_all(arg0, arg1, arg2)
{
    var _target_font_data = global.__scribble_font_data[? arg0];
    var _source_font_data = global.__scribble_font_data[? arg1];
    
    if (_target_font_data == undefined)
        __scribble_error("Font \"", arg0, "\" not found");
    
    if (_source_font_data == undefined)
        __scribble_error("Font \"", arg1, "\" not found");
    
    var _y_offset = __scribble_font_collage_glyph_copy_common(_target_font_data, _source_font_data);
    var _target_glyphs_map = _target_font_data.glyphs_map;
    var _source_glyphs_map = _source_font_data.glyphs_map;
    var _keys_array = ds_map_keys_to_array(_source_glyphs_map);
    var _i = 0;
    
    repeat (array_length(_keys_array))
    {
        var _key = _keys_array[_i];
        
        if (arg2 || !ds_map_exists(_target_glyphs_map, _key))
            _target_glyphs_map[? _key] = __scribble_glyph_duplicate(_source_glyphs_map[? _key], _y_offset);
        
        _i++;
    }
}
