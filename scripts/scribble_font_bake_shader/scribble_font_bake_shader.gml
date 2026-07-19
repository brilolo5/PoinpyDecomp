function scribble_font_bake_shader(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10 = 2048)
{
    if (!is_string(arg0))
    {
        __scribble_error("Fonts should be specified using their name as a string.\n(Input was an invalid datatype)");
        exit;
    }
    
    if (!is_string(arg1))
    {
        __scribble_error("Fonts should be specified using their name as a string.\n(Input was an invalid datatype)");
        exit;
    }
    
    if (arg0 == arg1)
    {
        __scribble_error("Source font and new font cannot share the same name");
        return undefined;
    }
    
    var _src_font_data = global.__scribble_font_data[? arg0];
    
    if (!is_struct(_src_font_data))
    {
        __scribble_error("Source font \"", arg0, "\" not found\n\"", arg1, "\" will not be available");
        return undefined;
    }
    
    if (_src_font_data.msdf)
    {
        __scribble_error("Source font cannot be an MSDF font");
        return undefined;
    }
    
    var _src_glyphs_map = _src_font_data.glyphs_map;
    var _src_glyphs_array = array_create(ds_map_size(_src_glyphs_map));
    var _i = 0;
    var _key = ds_map_find_first(_src_glyphs_map);
    
    repeat (ds_map_size(_src_glyphs_map))
    {
        array_set(_src_glyphs_array, _i, _src_glyphs_map[? _key]);
        _i++;
        _key = ds_map_find_next(_src_glyphs_map, _key);
    }
    
    var _priority_queue = ds_priority_create();
    _i = 0;
    
    repeat (array_length(_src_glyphs_array))
    {
        var _glyph_array = _src_glyphs_array[_i];
        
        if (_glyph_array != undefined)
        {
            var _character = _glyph_array[UnknownEnum.Value_0];
            
            if (_character != " ")
            {
                var _width = _glyph_array[UnknownEnum.Value_2];
                var _height = _glyph_array[UnknownEnum.Value_3];
                var _width_ext = _width + arg3 + arg4 + arg6;
                var _height_ext = _height + arg3 + arg5 + arg7;
                var _priority = (_width_ext * arg10) + _height_ext;
                ds_priority_add(_priority_queue, _i, _priority);
            }
        }
        
        _i++;
    }
    
    var _surface_glyphs = [];
    var _added_count = 0;
    var _found;
    
    while (!ds_priority_empty(_priority_queue))
    {
        var _index = ds_priority_delete_max(_priority_queue);
        var _glyph_array = _src_glyphs_array[_index];
        var _character = _glyph_array[UnknownEnum.Value_0];
        var _width = _glyph_array[UnknownEnum.Value_2];
        var _height = _glyph_array[UnknownEnum.Value_3];
        var _width_ext = _width + arg3 + arg4 + arg6;
        var _height_ext = _height + arg3 + arg5 + arg7;
        var _l, _t, _r, _b;
        
        if (_added_count == 0)
        {
            _found = true;
            _l = arg3;
            _t = arg3;
            _r = (_l + _width_ext) - 1;
            _b = (_t + _height_ext) - 1;
        }
        else
        {
            _found = false;
            
            if (!_found)
            {
                for (var _j = 0; _j < _added_count; _j++)
                {
                    var _target_array = _surface_glyphs[_j];
                    _l = _target_array[2] + 1;
                    _t = _target_array[1];
                    _r = (_l + _width_ext) - 1;
                    _b = (_t + _height_ext) - 1;
                    
                    if (_r < arg10 && _b < arg10)
                    {
                        _found = true;
                        
                        for (var _k = 0; _k < _added_count; _k++)
                        {
                            var _check_array = _surface_glyphs[_k];
                            var _check_l = _check_array[0];
                            var _check_t = _check_array[1];
                            var _check_r = _check_array[2];
                            var _check_b = _check_array[3];
                            
                            if (_l <= _check_r && _r >= _check_l && _t <= _check_b && _b >= _check_t)
                            {
                                _found = false;
                                break;
                            }
                        }
                        
                        if (_found)
                            break;
                    }
                }
            }
            
            if (!_found)
            {
                for (var _j = 0; _j < _added_count; _j++)
                {
                    var _target_array = _surface_glyphs[_j];
                    _l = _target_array[0];
                    _t = _target_array[3] + 1;
                    _r = (_l + _width_ext) - 1;
                    _b = (_t + _height_ext) - 1;
                    
                    if (_r < arg10 && _b < arg10)
                    {
                        _found = true;
                        
                        for (var _k = 0; _k < _added_count; _k++)
                        {
                            var _check_array = _surface_glyphs[_k];
                            var _check_l = _check_array[0];
                            var _check_t = _check_array[1];
                            var _check_r = _check_array[2];
                            var _check_b = _check_array[3];
                            
                            if (_l <= _check_r && _r >= _check_l && _t <= _check_b && _b >= _check_t)
                            {
                                _found = false;
                                break;
                            }
                        }
                        
                        if (_found)
                            break;
                    }
                }
            }
        }
        
        if (_found)
        {
            array_set(_surface_glyphs, _added_count, [_l, _t, _r, _b, _index, _character]);
            _added_count++;
        }
        else
        {
            break;
        }
    }
    
    ds_priority_destroy(_priority_queue);
    
    if (!_found)
    {
        __scribble_error("No space left on ", arg10, "x", arg10, " texture page\nPlease increase the size of the texture page");
    }
    else
    {
        var _vbuff = vertex_create_buffer();
        vertex_begin(_vbuff, global.__scribble_passthrough_vertex_format);
        _i = 0;
        var _glyph_array;
        
        repeat (array_length(_surface_glyphs))
        {
            var _glyph_position = _surface_glyphs[_i];
            var _index = _glyph_position[4];
            _glyph_array = _src_glyphs_array[_index];
            var _l = _glyph_position[0] + arg4;
            var _t = _glyph_position[1] + arg5;
            var _r = _l + _glyph_array[UnknownEnum.Value_2];
            var _b = _t + _glyph_array[UnknownEnum.Value_3];
            var _u0 = _glyph_array[UnknownEnum.Value_8];
            var _v0 = _glyph_array[UnknownEnum.Value_9];
            var _u1 = _glyph_array[UnknownEnum.Value_10];
            var _v1 = _glyph_array[UnknownEnum.Value_11];
            vertex_position(_vbuff, _l, _t);
            vertex_color(_vbuff, c_white, 1);
            vertex_texcoord(_vbuff, _u0, _v0);
            vertex_position(_vbuff, _r, _t);
            vertex_color(_vbuff, c_white, 1);
            vertex_texcoord(_vbuff, _u1, _v0);
            vertex_position(_vbuff, _l, _b);
            vertex_color(_vbuff, c_white, 1);
            vertex_texcoord(_vbuff, _u0, _v1);
            vertex_position(_vbuff, _r, _t);
            vertex_color(_vbuff, c_white, 1);
            vertex_texcoord(_vbuff, _u1, _v0);
            vertex_position(_vbuff, _r, _b);
            vertex_color(_vbuff, c_white, 1);
            vertex_texcoord(_vbuff, _u1, _v1);
            vertex_position(_vbuff, _l, _b);
            vertex_color(_vbuff, c_white, 1);
            vertex_texcoord(_vbuff, _u0, _v1);
            _i++;
        }
        
        vertex_end(_vbuff);
        var _texture = _glyph_array[UnknownEnum.Value_7];
        var _surface_0 = surface_create_track(arg10, arg10);
        var _surface_1 = surface_create_track(arg10, arg10);
        surface_set_target(_surface_0);
        draw_clear_alpha(c_white, 0);
        gpu_set_blendenable(false);
        vertex_submit(_vbuff, pr_trianglelist, _texture);
        gpu_set_blendenable(true);
        surface_reset_target();
        _texture = surface_get_texture(_surface_0);
        surface_set_target(_surface_1);
        draw_clear_alpha(c_white, 0);
        var _old_filter = gpu_get_tex_filter();
        gpu_set_tex_filter(arg9);
        gpu_set_blendenable(false);
        shader_set_track(arg2);
        shader_set_uniform_f(shader_get_uniform(arg2, "u_vTexel"), texture_get_texel_width(_texture), texture_get_texel_height(_texture));
        draw_surface(_surface_0, 0, 0);
        shader_reset_track();
        gpu_set_tex_filter(_old_filter);
        gpu_set_blendenable(true);
        surface_reset_target();
        var _sprite = sprite_create_from_surface(_surface_1, 0, 0, arg10, arg10, false, false, 0, 0);
        surface_free(_surface_0);
        surface_free(_surface_1);
        vertex_delete_buffer(_vbuff);
        _texture = sprite_get_texture(_sprite, 0);
        var _sprite_uvs = sprite_get_uvs(_sprite, 0);
        var _sprite_u0 = _sprite_uvs[0];
        var _sprite_v0 = _sprite_uvs[1];
        var _sprite_u1 = _sprite_uvs[2];
        var _sprite_v1 = _sprite_uvs[3];
        var _new_font_data = new __scribble_class_font(arg1);
        var _new_glyph_map = _new_font_data.glyphs_map;
        _src_font_data.copy_to(_new_font_data);
        _new_font_data.style_regular = undefined;
        _new_font_data.style_bold = undefined;
        _new_font_data.style_italic = undefined;
        _new_font_data.style_bold_italic = undefined;
        var _array = array_create(UnknownEnum.Value_13);
        array_copy(_array, 0, _src_glyphs_map[? 32], 0, UnknownEnum.Value_13);
        _new_glyph_map[? 32] = _array;
        _i = 0;
        
        repeat (array_length(_surface_glyphs))
        {
            var _glyph_position = _surface_glyphs[_i];
            var _index = _glyph_position[4];
            var _src_glyph_array = _src_glyphs_array[_index];
            var _ord = _src_glyph_array[UnknownEnum.Value_1];
            var _l = _glyph_position[0];
            var _t = _glyph_position[1];
            var _r = _l + _src_glyph_array[UnknownEnum.Value_2] + arg4 + arg6;
            var _b = _t + _src_glyph_array[UnknownEnum.Value_3] + arg5 + arg7;
            var _u0 = lerp(_sprite_u0, _sprite_u1, _l / arg10);
            var _v0 = lerp(_sprite_v0, _sprite_v1, _t / arg10);
            var _u1 = lerp(_sprite_u0, _sprite_u1, _r / arg10);
            var _v1 = lerp(_sprite_v0, _sprite_v1, _b / arg10);
            _array = array_create(UnknownEnum.Value_13, 0);
            array_set(_array, UnknownEnum.Value_0, _src_glyph_array[UnknownEnum.Value_0]);
            array_set(_array, UnknownEnum.Value_1, _ord);
            array_set(_array, UnknownEnum.Value_2, _src_glyph_array[UnknownEnum.Value_2] + arg4 + arg6);
            array_set(_array, UnknownEnum.Value_3, _src_glyph_array[UnknownEnum.Value_3] + arg5 + arg7);
            array_set(_array, UnknownEnum.Value_4, _src_glyph_array[UnknownEnum.Value_4] - arg4);
            array_set(_array, UnknownEnum.Value_5, _src_glyph_array[UnknownEnum.Value_5] - arg5);
            array_set(_array, UnknownEnum.Value_6, _src_glyph_array[UnknownEnum.Value_6] + arg8);
            array_set(_array, UnknownEnum.Value_7, _texture);
            array_set(_array, UnknownEnum.Value_8, _u0);
            array_set(_array, UnknownEnum.Value_9, _v0);
            array_set(_array, UnknownEnum.Value_10, _u1);
            array_set(_array, UnknownEnum.Value_11, _v1);
            _new_glyph_map[? _ord] = _array;
            _i++;
        }
    }
}
