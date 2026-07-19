function scribble_font_scale(arg0, arg1, arg2)
{
    if (!ds_map_exists(global.__scribble_font_data, arg0))
    {
        __scribble_error("Font \"", arg0, "\" not found");
        exit;
    }
    
    var _font_data = global.__scribble_font_data[? arg0];
    var _map = _font_data.glyphs_map;
    _font_data.xscale *= arg1;
    _font_data.yscale *= arg2;
    _font_data.scale_dist = point_distance(0, 0, _font_data.xscale, _font_data.yscale);
    _map = _font_data.glyphs_map;
    var _key = ds_map_find_first(_map);
    
    repeat (ds_map_size(_map))
    {
        var _glyph_data = _map[? _key];
        array_set(_glyph_data, UnknownEnum.Value_4, array_get(_glyph_data, UnknownEnum.Value_4) * arg1);
        array_set(_glyph_data, UnknownEnum.Value_5, array_get(_glyph_data, UnknownEnum.Value_5) * arg2);
        array_set(_glyph_data, UnknownEnum.Value_2, array_get(_glyph_data, UnknownEnum.Value_2) * arg1);
        array_set(_glyph_data, UnknownEnum.Value_3, array_get(_glyph_data, UnknownEnum.Value_3) * arg2);
        array_set(_glyph_data, UnknownEnum.Value_6, array_get(_glyph_data, UnknownEnum.Value_6) * arg1);
        _key = ds_map_find_next(_map, _key);
    }
    
    _font_data.calculate_font_height();
}
