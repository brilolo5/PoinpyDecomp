function __scribble_font_add_msdf_from_project(arg0)
{
    var _name = sprite_get_name(arg0);
    
    if (ds_map_exists(global.__scribble_font_data, _name))
    {
        __scribble_error("Font \"", _name, "\" has already been defined");
        return undefined;
    }
    
    if (global.__scribble_default_font == undefined)
        global.__scribble_default_font = _name;
    
    var _global_glyph_bidi_map = global.__scribble_glyph_data.bidi_map;
    var _font_data = new __scribble_class_font(_name);
    _font_data.msdf = true;
    var _font_glyphs_map = _font_data.glyphs_map;
    var _sprite_width = sprite_get_width(arg0);
    var _sprite_height = sprite_get_height(arg0);
    var _sprite_uvs = sprite_get_uvs(arg0, 0);
    var _texture = sprite_get_texture(arg0, 0);
    var _texel_w = texture_get_texel_width(_texture);
    var _texel_h = texture_get_texel_height(_texture);
    _sprite_uvs[0] -= _texel_w * _sprite_uvs[4];
    _sprite_uvs[1] -= _texel_h * _sprite_uvs[5];
    _sprite_uvs[2] += _texel_w * _sprite_width * (1 - _sprite_uvs[6]);
    _sprite_uvs[3] += _texel_h * _sprite_height * (1 - _sprite_uvs[7]);
    var _json_buffer = buffer_load(global.__scribble_font_directory + _name + ".json");
    
    if (_json_buffer < 0)
        _json_buffer = buffer_load(global.__scribble_font_directory + _name);
    
    if (_json_buffer < 0)
        __scribble_error("Could not find \"", global.__scribble_font_directory + _name + ".json\"\nPlease add it to the project's Included Files");
    
    var _json_string = buffer_read(_json_buffer, buffer_text);
    buffer_delete(_json_buffer);
    var _json = json_decode(_json_string);
    var _metrics_map = _json[? "metrics"];
    var _json_glyph_list = _json[? "glyphs"];
    var _atlas_map = _json[? "atlas"];
    var _em_size = _atlas_map[? "size"];
    var _msdf_pxrange = _atlas_map[? "distanceRange"];
    var _json_line_height = _em_size * _metrics_map[? "lineHeight"];
    _font_data.msdf_pxrange = _msdf_pxrange;
    var _size = ds_list_size(_json_glyph_list);
    var _i = 0;
    
    repeat (_size)
    {
        var _json_glyph_map = _json_glyph_list[| _i];
        var _plane_map = _json_glyph_map[? "planeBounds"];
        _atlas_map = _json_glyph_map[? "atlasBounds"];
        var _index = _json_glyph_map[? "unicode"];
        var _char = chr(_index);
        var _tex_r, _tex_l, _tex_b, _tex_t;
        
        if (_atlas_map != undefined)
        {
            _tex_l = _atlas_map[? "left"] + 1;
            _tex_t = (_sprite_height - _atlas_map[? "top"]) + 1;
            _tex_r = _atlas_map[? "right"] - 1;
            _tex_b = _sprite_height - _atlas_map[? "bottom"] - 1;
        }
        else
        {
            _tex_l = 0;
            _tex_t = 0;
            _tex_r = 0;
            _tex_b = 0;
        }
        
        var _w = _tex_r - _tex_l;
        var _h = _tex_b - _tex_t;
        var _xoffset, _yoffset, _xadvance;
        
        if (_plane_map != undefined)
        {
            _xoffset = _em_size * _plane_map[? "left"];
            _yoffset = _em_size - (_em_size * _plane_map[? "top"]);
            _xadvance = round(_em_size * _json_glyph_map[? "advance"]);
        }
        else
        {
            _xoffset = 0;
            _yoffset = 0;
            _xadvance = round(_em_size * _json_glyph_map[? "advance"]);
        }
        
        var _u0 = lerp(_sprite_uvs[0], _sprite_uvs[2], _tex_l / _sprite_width);
        var _v0 = lerp(_sprite_uvs[1], _sprite_uvs[3], _tex_t / _sprite_height);
        var _u1 = lerp(_sprite_uvs[0], _sprite_uvs[2], _tex_r / _sprite_width);
        var _v1 = lerp(_sprite_uvs[1], _sprite_uvs[3], _tex_b / _sprite_height);
        var _bidi = _global_glyph_bidi_map[? _index];
        
        if (_bidi == undefined)
            _bidi = UnknownEnum.Value_3;
        
        _array = array_create(UnknownEnum.Value_13, undefined);
        array_set(_array, UnknownEnum.Value_0, _char);
        array_set(_array, UnknownEnum.Value_1, _index);
        array_set(_array, UnknownEnum.Value_2, _w);
        array_set(_array, UnknownEnum.Value_3, _h);
        array_set(_array, UnknownEnum.Value_4, _xoffset);
        array_set(_array, UnknownEnum.Value_5, _yoffset);
        array_set(_array, UnknownEnum.Value_6, _xadvance);
        array_set(_array, UnknownEnum.Value_7, _texture);
        array_set(_array, UnknownEnum.Value_8, _u0);
        array_set(_array, UnknownEnum.Value_9, _v0);
        array_set(_array, UnknownEnum.Value_10, _u1);
        array_set(_array, UnknownEnum.Value_11, _v1);
        array_set(_array, UnknownEnum.Value_12, _bidi);
        _font_glyphs_map[? _index] = _array;
        _i++;
    }
    
    var _array = _font_glyphs_map[? 32];
    
    if (_array == undefined)
    {
        __scribble_error("Space character not found in character string for MSDF font \"", _name, "\"");
    }
    else
    {
        array_set(_array, UnknownEnum.Value_2, _array[UnknownEnum.Value_6]);
        array_set(_array, UnknownEnum.Value_3, _json_line_height);
    }
    
    ds_map_destroy(_json);
    _font_data.calculate_font_height();
}
