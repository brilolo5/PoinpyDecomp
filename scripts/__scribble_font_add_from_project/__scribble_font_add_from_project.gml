function __scribble_font_add_from_project(arg0)
{
    var _name = font_get_name(arg0);
    
    if (global.__scribble_default_font == undefined)
        global.__scribble_default_font = _name;
    
    var _global_glyph_bidi_map = global.__scribble_glyph_data.bidi_map;
    var _font_data = new __scribble_class_font(_name);
    _font_data.msdf = false;
    var _font_glyphs_map = _font_data.glyphs_map;
    var _asset = asset_get_index(_name);
    var _texture = font_get_texture(_asset);
    var _texture_uvs = font_get_uvs(_asset);
    var _texture_tw = texture_get_texel_width(_texture);
    var _texture_th = texture_get_texel_height(_texture);
    var _texture_w = (_texture_uvs[2] - _texture_uvs[0]) / _texture_tw;
    var _texture_h = (_texture_uvs[3] - _texture_uvs[1]) / _texture_th;
    var _font_info = font_get_info(arg0);
    var _info_glyphs_dict = _font_info.glyphs;
    var _info_glyph_names = variable_struct_get_names(_info_glyphs_dict);
    var _size = array_length(_info_glyph_names);
    var _info_glyphs_array = array_create(array_length(_info_glyph_names));
    var _i = 0;
    
    repeat (_size)
    {
        var _glyph = _info_glyph_names[_i];
        var _struct = variable_struct_get(_info_glyphs_dict, _glyph);
        array_set(_info_glyphs_array, _i, _struct);
        _i++;
    }
    
    _i = 0;
    
    repeat (_size)
    {
        var _glyph_dict = _info_glyphs_array[_i];
        var _index = _glyph_dict.char;
        var _char = chr(_index);
        var _x = _glyph_dict.x;
        var _y = _glyph_dict.y;
        var _w = _glyph_dict.w;
        var _h = _glyph_dict.h;
        var _u0 = _x * _texture_tw;
        var _v0 = _y * _texture_th;
        var _u1 = _u0 + (_w * _texture_tw);
        var _v1 = _v0 + (_h * _texture_th);
        var _bidi = _global_glyph_bidi_map[? _index];
        
        if (_bidi == undefined)
            _bidi = UnknownEnum.Value_3;
        
        var _array = array_create(UnknownEnum.Value_13, 0);
        array_set(_array, UnknownEnum.Value_0, _char);
        array_set(_array, UnknownEnum.Value_1, _index);
        array_set(_array, UnknownEnum.Value_2, _w);
        array_set(_array, UnknownEnum.Value_3, _h);
        array_set(_array, UnknownEnum.Value_4, _glyph_dict.offset);
        array_set(_array, UnknownEnum.Value_5, 0);
        array_set(_array, UnknownEnum.Value_6, _glyph_dict.shift);
        array_set(_array, UnknownEnum.Value_7, _texture);
        array_set(_array, UnknownEnum.Value_8, _u0);
        array_set(_array, UnknownEnum.Value_9, _v0);
        array_set(_array, UnknownEnum.Value_10, _u1);
        array_set(_array, UnknownEnum.Value_11, _v1);
        array_set(_array, UnknownEnum.Value_12, _bidi);
        _font_glyphs_map[? ord(_char)] = _array;
        _i++;
    }
    
    _font_data.calculate_font_height();
    var _GM_scaling = array_get(_font_glyphs_map[? 32], UnknownEnum.Value_3) / _font_info.size;
    
    if (_GM_scaling < 1)
    {
        __scribble_trace("Warning! Font \"", _name, "\" may have been scaled during compilation (font size = ", _font_info.size, ", space height = ", array_get(_font_glyphs_map[? 32], UnknownEnum.Value_3), ", scaling factor = ", _GM_scaling, ")");
        scribble_font_scale(_name, 1 / _GM_scaling, 1 / _GM_scaling);
    }
}
