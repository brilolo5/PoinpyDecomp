function scribble_glyph_get(arg0, arg1, arg2)
{
    var _font_data = global.__scribble_font_data[? arg0];
    var _map = _font_data.glyphs_map;
    var _glyph_data = _map[? ord(arg1)];
    
    if (_glyph_data == undefined)
    {
        __scribble_error("Character \"", arg1, "\" not found for font \"", arg0, "\"");
        return undefined;
    }
    
    return _glyph_data[arg2];
}
