function __scribble_generator_write_vbuffs()
{
    var _glyph_grid = global.__scribble_glyph_grid;
    var _control_grid = global.__scribble_control_grid;
    var _element = global.__scribble_generator_state.element;
    var _bezier_do, _bezier_prev_cy, _bezier_lengths, _bezier_param_increment;
    
    if (is_array(global.__scribble_generator_state.bezier_lengths_array))
    {
        _bezier_do = true;
        _bezier_lengths = global.__scribble_generator_state.bezier_lengths_array;
        var _bezier_search_index = 0;
        var _bezier_search_d0 = 0;
        var _bezier_search_d1 = _bezier_lengths[1];
        _bezier_prev_cy = -infinity;
        _bezier_param_increment = 0.05263157894736842;
    }
    else
    {
        _bezier_do = false;
    }
    
    var _control_index = 0;
    var _next_control_pos = _control_grid[# 0, UnknownEnum.Value_2];
    var _p = 0;
    
    repeat (pages)
    {
        var _page_data = pages_array[_p];
        var _page_events_dict = _page_data.__events;
        var _vbuff = undefined;
        var _last_glyph_texture = undefined;
        var _glyph_sprite_data = 0;
        var _animation_index = 0;
        var _i = _page_data.__glyph_start;
        
        repeat ((1 + _page_data.__glyph_end) - _page_data.__glyph_start)
        {
            while (_i == _next_control_pos && _p == _control_grid[# _control_index, UnknownEnum.Value_3])
            {
                if (_control_grid[# _control_index, UnknownEnum.Value_0] == -4)
                {
                    var _event_array = variable_struct_get(_page_events_dict, _animation_index);
                    
                    if (!is_array(_event_array))
                    {
                        _event_array = [];
                        variable_struct_set(_page_events_dict, _animation_index, _event_array);
                    }
                    
                    var _event = _control_grid[# _control_index, UnknownEnum.Value_1];
                    _event.position = _animation_index;
                    array_push(_event_array, _event);
                }
                
                _control_index++;
                _next_control_pos = _control_grid[# _control_index, UnknownEnum.Value_2];
            }
            
            var _glyph_ord = _glyph_grid[# _i, UnknownEnum.Value_4];
            
            if (_glyph_ord == -1)
            {
                var _glyph_x = _glyph_grid[# _i, UnknownEnum.Value_0];
                var _glyph_y = _glyph_grid[# _i, UnknownEnum.Value_1];
                var _glyph_colour = _glyph_grid[# _i, UnknownEnum.Value_12];
                var _glyph_effect_flags = _glyph_grid[# _i, UnknownEnum.Value_13];
                var _glyph_scale = _glyph_grid[# _i, UnknownEnum.Value_14];
                var _glyph_slant = _glyph_grid[# _i, UnknownEnum.Value_15];
                var _glyph_char_index = _glyph_grid[# _i, UnknownEnum.Value_5];
                _glyph_colour = !(os_type == os_windows || os_type == os_xboxone || os_type == os_uwp || os_type == os_win8native || os_type == os_winphone) ? scribble_rgb_to_bgr(_glyph_colour) : _glyph_colour;
                _animation_index++;
                var _write_scale = _glyph_scale;
                var _sprite_index = _glyph_grid[# _i, UnknownEnum.Value_9];
                var _image_index = _glyph_grid[# _i, UnknownEnum.Value_10];
                var _image_speed = _glyph_grid[# _i, UnknownEnum.Value_11];
                var _glyph_width = _glyph_grid[# _i, UnknownEnum.Value_2];
                var _glyph_height = _glyph_grid[# _i, UnknownEnum.Value_3];
                var _sprite_number = sprite_get_number(_sprite_index);
                
                if (_sprite_number >= 64)
                {
                    __scribble_trace("In-line sprites cannot have more than 64 frames (", sprite_get_name(_sprite_index), ")");
                    _sprite_number = 64;
                }
                
                if (_image_speed >= 4)
                {
                    __scribble_trace("Image speed cannot be more than 4.0 (" + string(_image_speed) + ")");
                    _image_speed = 4;
                }
                
                if (_image_speed < 0)
                {
                    __scribble_trace("Image speed cannot be less than 0.0 (" + string(_image_speed) + ")");
                    _image_speed = 0;
                }
                
                _glyph_sprite_data = (4096 * floor(1024 * _image_speed)) + (64 * _sprite_number) + _image_index;
                var _j = _image_index;
                
                repeat ((_image_speed > 0) ? _sprite_number : 1)
                {
                    var _glyph_texture = sprite_get_texture(_sprite_index, _j);
                    var _uvs = sprite_get_uvs(_sprite_index, _j);
                    var _quad_u0 = _uvs[0];
                    var _quad_v0 = _uvs[1];
                    var _quad_u1 = _uvs[2];
                    var _quad_v1 = _uvs[3];
                    var _quad_l = _glyph_x + (_uvs[4] * _glyph_scale);
                    var _quad_t = _glyph_y + (_uvs[5] * _glyph_scale);
                    var _quad_r = _quad_l + (_uvs[6] * _glyph_width);
                    var _quad_b = _quad_t + (_uvs[7] * _glyph_height);
                    var _packed_indexes = (_glyph_char_index * 1000) + 1;
                    var _quad_cx = 0.5 * (_quad_l + _quad_r);
                    var _quad_cy = 0.5 * (_quad_t + _quad_b);
                    var _slant_offset = 0.25 * _glyph_scale * _glyph_slant * (_quad_b - _quad_t);
                    var _delta_l = _quad_cx - _quad_l;
                    var _delta_t = _quad_cy - _quad_t;
                    var _delta_r = _quad_cx - _quad_r;
                    var _delta_b = _quad_cy - _quad_b;
                    var _delta_ls = _delta_l - _slant_offset;
                    var _delta_rs = _delta_r - _slant_offset;
                    
                    if (_glyph_texture != _last_glyph_texture)
                    {
                        _last_glyph_texture = _glyph_texture;
                        _vbuff = _page_data.__get_vertex_buffer(_glyph_texture, _glyph_grid[# _i, UnknownEnum.Value_6], true, self);
                    }
                    
                    if (_bezier_do)
                    {
                        var _bezier_search_d1, _bezier_search_d0, _bezier_search_index;
                        
                        if (_quad_cy > _bezier_prev_cy)
                        {
                            _bezier_search_index = 0;
                            _bezier_search_d0 = 0;
                            _bezier_search_d1 = _bezier_lengths[1];
                        }
                        
                        _bezier_prev_cx = _quad_cx;
                        var _bezier_param;
                        
                        while (true)
                        {
                            if (_quad_cx <= _bezier_search_d1)
                            {
                                _bezier_param = _bezier_param_increment * (((_quad_cx - _bezier_search_d0) / (_bezier_search_d1 - _bezier_search_d0)) + _bezier_search_index);
                                break;
                            }
                            
                            _bezier_search_index++;
                            
                            if (_bezier_search_index >= 19)
                            {
                                _bezier_param = 1;
                                break;
                            }
                            
                            _bezier_search_d0 = _bezier_search_d1;
                            _bezier_search_d1 = _bezier_lengths[_bezier_search_index + 1];
                        }
                        
                        _slant_offset = 0;
                        _quad_l = _bezier_param;
                        _quad_r = _bezier_param;
                        _quad_t = _quad_cy;
                        _quad_b = _quad_cy;
                    }
                    
                    vertex_position_3d(_vbuff, _quad_l + _slant_offset, _quad_t, _packed_indexes);
                    vertex_normal(_vbuff, _delta_ls, _glyph_sprite_data, _glyph_effect_flags);
                    vertex_argb(_vbuff, _glyph_colour);
                    vertex_texcoord(_vbuff, _quad_u0, _quad_v0);
                    vertex_float2(_vbuff, _write_scale, _delta_t);
                    vertex_position_3d(_vbuff, _quad_r, _quad_b, _packed_indexes);
                    vertex_normal(_vbuff, _delta_r, _glyph_sprite_data, _glyph_effect_flags);
                    vertex_argb(_vbuff, _glyph_colour);
                    vertex_texcoord(_vbuff, _quad_u1, _quad_v1);
                    vertex_float2(_vbuff, _write_scale, _delta_b);
                    vertex_position_3d(_vbuff, _quad_l, _quad_b, _packed_indexes);
                    vertex_normal(_vbuff, _delta_l, _glyph_sprite_data, _glyph_effect_flags);
                    vertex_argb(_vbuff, _glyph_colour);
                    vertex_texcoord(_vbuff, _quad_u0, _quad_v1);
                    vertex_float2(_vbuff, _write_scale, _delta_b);
                    vertex_position_3d(_vbuff, _quad_r, _quad_b, _packed_indexes);
                    vertex_normal(_vbuff, _delta_r, _glyph_sprite_data, _glyph_effect_flags);
                    vertex_argb(_vbuff, _glyph_colour);
                    vertex_texcoord(_vbuff, _quad_u1, _quad_v1);
                    vertex_float2(_vbuff, _write_scale, _delta_b);
                    vertex_position_3d(_vbuff, _quad_l + _slant_offset, _quad_t, _packed_indexes);
                    vertex_normal(_vbuff, _delta_ls, _glyph_sprite_data, _glyph_effect_flags);
                    vertex_argb(_vbuff, _glyph_colour);
                    vertex_texcoord(_vbuff, _quad_u0, _quad_v0);
                    vertex_float2(_vbuff, _write_scale, _delta_t);
                    vertex_position_3d(_vbuff, _quad_r + _slant_offset, _quad_t, _packed_indexes);
                    vertex_normal(_vbuff, _delta_rs, _glyph_sprite_data, _glyph_effect_flags);
                    vertex_argb(_vbuff, _glyph_colour);
                    vertex_texcoord(_vbuff, _quad_u1, _quad_v0);
                    vertex_float2(_vbuff, _write_scale, _delta_t);
                    _j++;
                    _glyph_sprite_data++;
                }
                
                _glyph_sprite_data = 0;
            }
            else if (_glyph_ord == -2)
            {
                var _glyph_x = _glyph_grid[# _i, UnknownEnum.Value_0];
                var _glyph_y = _glyph_grid[# _i, UnknownEnum.Value_1];
                var _glyph_colour = _glyph_grid[# _i, UnknownEnum.Value_12];
                var _glyph_effect_flags = _glyph_grid[# _i, UnknownEnum.Value_13];
                var _glyph_scale = _glyph_grid[# _i, UnknownEnum.Value_14];
                var _glyph_slant = _glyph_grid[# _i, UnknownEnum.Value_15];
                var _glyph_char_index = _glyph_grid[# _i, UnknownEnum.Value_5];
                _glyph_colour = !(os_type == os_windows || os_type == os_xboxone || os_type == os_uwp || os_type == os_win8native || os_type == os_winphone) ? scribble_rgb_to_bgr(_glyph_colour) : _glyph_colour;
                _animation_index++;
                var _write_scale = _glyph_scale;
                var _surface = _glyph_grid[# _i, UnknownEnum.Value_9];
                var _glyph_width = _glyph_grid[# _i, UnknownEnum.Value_2];
                var _glyph_height = _glyph_grid[# _i, UnknownEnum.Value_3];
                var _glyph_texture = surface_get_texture(_surface);
                var _quad_u0 = 0;
                var _quad_v0 = 0;
                var _quad_u1 = 1;
                var _quad_v1 = 1;
                var _quad_l = _glyph_x;
                var _quad_t = _glyph_y;
                var _quad_r = _quad_l + _glyph_width;
                var _quad_b = _quad_t + _glyph_height;
                var _packed_indexes = (_glyph_char_index * 1000) + 1;
                var _quad_cx = 0.5 * (_quad_l + _quad_r);
                var _quad_cy = 0.5 * (_quad_t + _quad_b);
                var _slant_offset = 0.25 * _glyph_scale * _glyph_slant * (_quad_b - _quad_t);
                var _delta_l = _quad_cx - _quad_l;
                var _delta_t = _quad_cy - _quad_t;
                var _delta_r = _quad_cx - _quad_r;
                var _delta_b = _quad_cy - _quad_b;
                var _delta_ls = _delta_l - _slant_offset;
                var _delta_rs = _delta_r - _slant_offset;
                
                if (_glyph_texture != _last_glyph_texture)
                {
                    _last_glyph_texture = _glyph_texture;
                    _vbuff = _page_data.__get_vertex_buffer(_glyph_texture, _glyph_grid[# _i, UnknownEnum.Value_6], true, self);
                }
                
                if (_bezier_do)
                {
                    var _bezier_search_d1, _bezier_search_d0, _bezier_search_index;
                    
                    if (_quad_cy > _bezier_prev_cy)
                    {
                        _bezier_search_index = 0;
                        _bezier_search_d0 = 0;
                        _bezier_search_d1 = _bezier_lengths[1];
                    }
                    
                    _bezier_prev_cx = _quad_cx;
                    var _bezier_param;
                    
                    while (true)
                    {
                        if (_quad_cx <= _bezier_search_d1)
                        {
                            _bezier_param = _bezier_param_increment * (((_quad_cx - _bezier_search_d0) / (_bezier_search_d1 - _bezier_search_d0)) + _bezier_search_index);
                            break;
                        }
                        
                        _bezier_search_index++;
                        
                        if (_bezier_search_index >= 19)
                        {
                            _bezier_param = 1;
                            break;
                        }
                        
                        _bezier_search_d0 = _bezier_search_d1;
                        _bezier_search_d1 = _bezier_lengths[_bezier_search_index + 1];
                    }
                    
                    _slant_offset = 0;
                    _quad_l = _bezier_param;
                    _quad_r = _bezier_param;
                    _quad_t = _quad_cy;
                    _quad_b = _quad_cy;
                }
                
                vertex_position_3d(_vbuff, _quad_l + _slant_offset, _quad_t, _packed_indexes);
                vertex_normal(_vbuff, _delta_ls, _glyph_sprite_data, _glyph_effect_flags);
                vertex_argb(_vbuff, _glyph_colour);
                vertex_texcoord(_vbuff, _quad_u0, _quad_v0);
                vertex_float2(_vbuff, _write_scale, _delta_t);
                vertex_position_3d(_vbuff, _quad_r, _quad_b, _packed_indexes);
                vertex_normal(_vbuff, _delta_r, _glyph_sprite_data, _glyph_effect_flags);
                vertex_argb(_vbuff, _glyph_colour);
                vertex_texcoord(_vbuff, _quad_u1, _quad_v1);
                vertex_float2(_vbuff, _write_scale, _delta_b);
                vertex_position_3d(_vbuff, _quad_l, _quad_b, _packed_indexes);
                vertex_normal(_vbuff, _delta_l, _glyph_sprite_data, _glyph_effect_flags);
                vertex_argb(_vbuff, _glyph_colour);
                vertex_texcoord(_vbuff, _quad_u0, _quad_v1);
                vertex_float2(_vbuff, _write_scale, _delta_b);
                vertex_position_3d(_vbuff, _quad_r, _quad_b, _packed_indexes);
                vertex_normal(_vbuff, _delta_r, _glyph_sprite_data, _glyph_effect_flags);
                vertex_argb(_vbuff, _glyph_colour);
                vertex_texcoord(_vbuff, _quad_u1, _quad_v1);
                vertex_float2(_vbuff, _write_scale, _delta_b);
                vertex_position_3d(_vbuff, _quad_l + _slant_offset, _quad_t, _packed_indexes);
                vertex_normal(_vbuff, _delta_ls, _glyph_sprite_data, _glyph_effect_flags);
                vertex_argb(_vbuff, _glyph_colour);
                vertex_texcoord(_vbuff, _quad_u0, _quad_v0);
                vertex_float2(_vbuff, _write_scale, _delta_t);
                vertex_position_3d(_vbuff, _quad_r + _slant_offset, _quad_t, _packed_indexes);
                vertex_normal(_vbuff, _delta_rs, _glyph_sprite_data, _glyph_effect_flags);
                vertex_argb(_vbuff, _glyph_colour);
                vertex_texcoord(_vbuff, _quad_u1, _quad_v0);
                vertex_float2(_vbuff, _write_scale, _delta_t);
            }
            else
            {
                _animation_index++;
                
                if (_glyph_ord > 32 && _glyph_ord != 8203)
                {
                    var _glyph_x = _glyph_grid[# _i, UnknownEnum.Value_0];
                    var _glyph_y = _glyph_grid[# _i, UnknownEnum.Value_1];
                    var _glyph_colour = _glyph_grid[# _i, UnknownEnum.Value_12];
                    var _glyph_effect_flags = _glyph_grid[# _i, UnknownEnum.Value_13];
                    var _glyph_scale = _glyph_grid[# _i, UnknownEnum.Value_14];
                    var _glyph_slant = _glyph_grid[# _i, UnknownEnum.Value_15];
                    var _glyph_char_index = _glyph_grid[# _i, UnknownEnum.Value_5];
                    _glyph_colour = !(os_type == os_windows || os_type == os_xboxone || os_type == os_uwp || os_type == os_win8native || os_type == os_winphone) ? scribble_rgb_to_bgr(_glyph_colour) : _glyph_colour;
                    var _write_scale = _glyph_scale * _glyph_grid[# _i, UnknownEnum.Value_16];
                    var _glyph_data = _glyph_grid[# _i, UnknownEnum.Value_7];
                    var _glyph_texture = _glyph_data[UnknownEnum.Value_7];
                    var _quad_u0 = _glyph_data[UnknownEnum.Value_8];
                    var _quad_v0 = _glyph_data[UnknownEnum.Value_9];
                    var _quad_u1 = _glyph_data[UnknownEnum.Value_10];
                    var _quad_v1 = _glyph_data[UnknownEnum.Value_11];
                    var _quad_l = (_glyph_data[UnknownEnum.Value_4] * _glyph_scale) + _glyph_x;
                    var _quad_t = (_glyph_data[UnknownEnum.Value_5] * _glyph_scale) + _glyph_y;
                    var _quad_r = (_glyph_data[UnknownEnum.Value_2] * _glyph_scale) + _quad_l;
                    var _quad_b = (_glyph_data[UnknownEnum.Value_3] * _glyph_scale) + _quad_t;
                    var _packed_indexes = (_glyph_char_index * 1000) + 1;
                    var _quad_cx = 0.5 * (_quad_l + _quad_r);
                    var _quad_cy = 0.5 * (_quad_t + _quad_b);
                    var _slant_offset = 0.25 * _glyph_scale * _glyph_slant * (_quad_b - _quad_t);
                    var _delta_l = _quad_cx - _quad_l;
                    var _delta_t = _quad_cy - _quad_t;
                    var _delta_r = _quad_cx - _quad_r;
                    var _delta_b = _quad_cy - _quad_b;
                    var _delta_ls = _delta_l - _slant_offset;
                    var _delta_rs = _delta_r - _slant_offset;
                    
                    if (_glyph_texture != _last_glyph_texture)
                    {
                        _last_glyph_texture = _glyph_texture;
                        _vbuff = _page_data.__get_vertex_buffer(_glyph_texture, _glyph_grid[# _i, UnknownEnum.Value_6], true, self);
                    }
                    
                    if (_bezier_do)
                    {
                        var _bezier_search_d1, _bezier_search_d0, _bezier_search_index;
                        
                        if (_quad_cy > _bezier_prev_cy)
                        {
                            _bezier_search_index = 0;
                            _bezier_search_d0 = 0;
                            _bezier_search_d1 = _bezier_lengths[1];
                        }
                        
                        _bezier_prev_cx = _quad_cx;
                        var _bezier_param;
                        
                        while (true)
                        {
                            if (_quad_cx <= _bezier_search_d1)
                            {
                                _bezier_param = _bezier_param_increment * (((_quad_cx - _bezier_search_d0) / (_bezier_search_d1 - _bezier_search_d0)) + _bezier_search_index);
                                break;
                            }
                            
                            _bezier_search_index++;
                            
                            if (_bezier_search_index >= 19)
                            {
                                _bezier_param = 1;
                                break;
                            }
                            
                            _bezier_search_d0 = _bezier_search_d1;
                            _bezier_search_d1 = _bezier_lengths[_bezier_search_index + 1];
                        }
                        
                        _slant_offset = 0;
                        _quad_l = _bezier_param;
                        _quad_r = _bezier_param;
                        _quad_t = _quad_cy;
                        _quad_b = _quad_cy;
                    }
                    
                    vertex_position_3d(_vbuff, _quad_l + _slant_offset, _quad_t, _packed_indexes);
                    vertex_normal(_vbuff, _delta_ls, _glyph_sprite_data, _glyph_effect_flags);
                    vertex_argb(_vbuff, _glyph_colour);
                    vertex_texcoord(_vbuff, _quad_u0, _quad_v0);
                    vertex_float2(_vbuff, _write_scale, _delta_t);
                    vertex_position_3d(_vbuff, _quad_r, _quad_b, _packed_indexes);
                    vertex_normal(_vbuff, _delta_r, _glyph_sprite_data, _glyph_effect_flags);
                    vertex_argb(_vbuff, _glyph_colour);
                    vertex_texcoord(_vbuff, _quad_u1, _quad_v1);
                    vertex_float2(_vbuff, _write_scale, _delta_b);
                    vertex_position_3d(_vbuff, _quad_l, _quad_b, _packed_indexes);
                    vertex_normal(_vbuff, _delta_l, _glyph_sprite_data, _glyph_effect_flags);
                    vertex_argb(_vbuff, _glyph_colour);
                    vertex_texcoord(_vbuff, _quad_u0, _quad_v1);
                    vertex_float2(_vbuff, _write_scale, _delta_b);
                    vertex_position_3d(_vbuff, _quad_r, _quad_b, _packed_indexes);
                    vertex_normal(_vbuff, _delta_r, _glyph_sprite_data, _glyph_effect_flags);
                    vertex_argb(_vbuff, _glyph_colour);
                    vertex_texcoord(_vbuff, _quad_u1, _quad_v1);
                    vertex_float2(_vbuff, _write_scale, _delta_b);
                    vertex_position_3d(_vbuff, _quad_l + _slant_offset, _quad_t, _packed_indexes);
                    vertex_normal(_vbuff, _delta_ls, _glyph_sprite_data, _glyph_effect_flags);
                    vertex_argb(_vbuff, _glyph_colour);
                    vertex_texcoord(_vbuff, _quad_u0, _quad_v0);
                    vertex_float2(_vbuff, _write_scale, _delta_t);
                    vertex_position_3d(_vbuff, _quad_r + _slant_offset, _quad_t, _packed_indexes);
                    vertex_normal(_vbuff, _delta_rs, _glyph_sprite_data, _glyph_effect_flags);
                    vertex_argb(_vbuff, _glyph_colour);
                    vertex_texcoord(_vbuff, _quad_u1, _quad_v0);
                    vertex_float2(_vbuff, _write_scale, _delta_t);
                }
            }
            
            _i++;
        }
        
        while (_i == _next_control_pos && _p == _control_grid[# _control_index, UnknownEnum.Value_3])
        {
            if (_control_grid[# _control_index, UnknownEnum.Value_0] == -4)
            {
                var _event_array = variable_struct_get(_page_events_dict, _animation_index);
                
                if (!is_array(_event_array))
                {
                    _event_array = [];
                    variable_struct_set(_page_events_dict, _animation_index, _event_array);
                }
                
                var _event = _control_grid[# _control_index, UnknownEnum.Value_1];
                _event.position = _animation_index;
                array_push(_event_array, _event);
            }
            
            _control_index++;
            _next_control_pos = _control_grid[# _control_index, UnknownEnum.Value_2];
        }
        
        characters += _page_data.__character_count;
        _p++;
    }
    
    __finalize_vertex_buffers(_element.freeze);
}
