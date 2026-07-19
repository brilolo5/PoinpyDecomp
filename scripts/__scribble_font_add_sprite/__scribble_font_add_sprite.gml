function __scribble_font_add_sprite(arg0, arg1, arg2, arg3)
{
    var _spritefont = font_add_sprite(arg0, arg1, arg2, arg3);
    __scribble_font_add_sprite_common(_spritefont, arg2, arg3);
    return _spritefont;
}

function __scribble_font_add_sprite_ext(arg0, arg1, arg2, arg3)
{
    var _spritefont = font_add_sprite_ext(arg0, arg1, arg2, arg3);
    __scribble_font_add_sprite_common(_spritefont, arg2, arg3);
    return _spritefont;
}

function __scribble_font_add_sprite_common(arg0, arg1, arg2)
{
    var _font_info = font_get_info(arg0);
    var _sprite_name = _font_info.name;
    
    if (ds_map_exists(global.__scribble_font_data, _sprite_name))
        __scribble_error("A spritefont for \"", _sprite_name, "\" has already been added");
    
    var _global_glyph_bidi_map = global.__scribble_glyph_data.bidi_map;
    var _sprite = asset_get_index(_sprite_name);
    
    if (global.__scribble_default_font == undefined)
        global.__scribble_default_font = _sprite_name;
    
    var _sprite_width = sprite_get_width(_sprite);
    var _sprite_height = sprite_get_height(_sprite);
    var _font_data = new __scribble_class_font(_sprite_name);
    _font_data.msdf = false;
    var _font_glyphs_map = _font_data.glyphs_map;
    var _sprite_info = sprite_get_info(_sprite);
    var _sprite_frames = _sprite_info.frames;
    var _sprite_x_offset = sprite_get_xoffset(_sprite);
    var _info_glyphs_dict = _font_info.glyphs;
    var _info_glyph_names = variable_struct_get_names(_info_glyphs_dict);
    var _i = 0;
    
    repeat (array_length(_info_glyph_names))
    {
        var _glyph = _info_glyph_names[_i];
        var _image = variable_struct_get(_info_glyphs_dict, _glyph).char;
        var _uvs = sprite_get_uvs(_sprite, _image);
        
        if (_glyph == " " && _image >= array_length(_sprite_frames))
        {
            var _space_width;
            
            if (arg1)
                _space_width = ((1 + sprite_get_bbox_right(_sprite)) - sprite_get_bbox_left(_sprite)) + arg2;
            else
                _space_width = _sprite_width + arg2;
            
            var _bidi = global.__scribble_glyph_data.bidi_map[? 32];
            
            if (_bidi == undefined)
                _bidi = UnknownEnum.Value_3;
            
            var _array = array_create(UnknownEnum.Value_13, 0);
            array_set(_array, UnknownEnum.Value_2, _space_width);
            array_set(_array, UnknownEnum.Value_3, _sprite_height);
            array_set(_array, UnknownEnum.Value_4, 0);
            array_set(_array, UnknownEnum.Value_5, 0);
            array_set(_array, UnknownEnum.Value_6, _space_width);
            array_set(_array, UnknownEnum.Value_7, _sprite_frames[0].texture);
            array_set(_array, UnknownEnum.Value_8, 0);
            array_set(_array, UnknownEnum.Value_9, 0);
            array_set(_array, UnknownEnum.Value_10, 0);
            array_set(_array, UnknownEnum.Value_11, 0);
            array_set(_array, UnknownEnum.Value_12, _bidi);
            _font_glyphs_map[? 32] = _array;
        }
        else
        {
            var _image_info = _sprite_frames[_image];
            var _index = ord(_glyph);
            var _x_offset, _glyph_separation;
            
            if (arg1)
            {
                _x_offset = -_sprite_x_offset;
                _glyph_separation = _image_info.crop_width + arg2;
            }
            else
            {
                _x_offset = _image_info.x_offset - _sprite_x_offset;
                _glyph_separation = _sprite_width + arg2;
            }
            
            var _bidi = _global_glyph_bidi_map[? _index];
            
            if (_bidi == undefined)
                _bidi = UnknownEnum.Value_3;
            
            var _array = array_create(UnknownEnum.Value_13, 0);
            array_set(_array, UnknownEnum.Value_0, _glyph);
            array_set(_array, UnknownEnum.Value_1, _index);
            array_set(_array, UnknownEnum.Value_2, _image_info.crop_width);
            array_set(_array, UnknownEnum.Value_3, _image_info.crop_height);
            array_set(_array, UnknownEnum.Value_4, _x_offset);
            array_set(_array, UnknownEnum.Value_5, _image_info.y_offset);
            array_set(_array, UnknownEnum.Value_6, _glyph_separation);
            array_set(_array, UnknownEnum.Value_7, _image_info.texture);
            array_set(_array, UnknownEnum.Value_8, _uvs[0]);
            array_set(_array, UnknownEnum.Value_9, _uvs[1]);
            array_set(_array, UnknownEnum.Value_10, _uvs[2]);
            array_set(_array, UnknownEnum.Value_11, _uvs[3]);
            array_set(_array, UnknownEnum.Value_12, _bidi);
            _font_glyphs_map[? ord(_glyph)] = _array;
        }
        
        _i++;
    }
    
    _font_data.calculate_font_height();
    return arg0;
}
