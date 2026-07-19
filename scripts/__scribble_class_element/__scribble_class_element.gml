function __scribble_class_element(arg0, arg1) constructor
{
    static overwrite = function(arg0, arg1 = unique_id)
    {
        text = arg0;
        unique_id = arg1;
        var _new_cache_name = text + ":" + unique_id;
        
        if (cache_name != _new_cache_name)
        {
            flush();
            flushed = false;
            model_cache_name_dirty = true;
            cache_name = _new_cache_name;
            var _weak = global.__scribble_ecache_dict[? cache_name];
            
            if (_weak != undefined && weak_ref_alive(_weak) && !_weak.ref.flushed)
            {
                __scribble_trace("Warning! Flushing element \"", cache_name, "\" due to cache name collision (try choosing a different unique ID)");
                _weak.ref.flush();
            }
            
            global.__scribble_ecache_dict[? cache_name] = weak_ref_create(self);
            ds_list_add(global.__scribble_ecache_list, self);
            ds_list_add(global.__scribble_ecache_name_list, cache_name);
        }
        
        return self;
    };
    
    static starting_format = function(arg0, arg1)
    {
        if (is_string(arg0))
        {
            if (arg0 != starting_font)
            {
                model_cache_name_dirty = true;
                starting_font = arg0;
            }
        }
        else if (!is_undefined(arg0))
        {
            __scribble_error("Fonts should be specified using their name as a string\nUse <undefined> to not set a new font");
        }
        
        if (arg1 != undefined)
        {
            if (is_string(arg1))
            {
                arg1 = global.__scribble_colours[? arg1];
                
                if (arg1 == undefined)
                    __scribble_error("Colour name \"", arg1, "\" not recognised");
            }
            
            if (arg1 != undefined && arg1 >= 0)
            {
                if (arg1 != starting_colour)
                {
                    model_cache_name_dirty = true;
                    starting_colour = arg1 & 16777215;
                }
            }
        }
        
        return self;
    };
    
    static align = function(arg0, arg1)
    {
        if (arg0 == "pin_left")
            arg0 = 3;
        
        if (arg0 == "pin_centre")
            arg0 = 4;
        
        if (arg0 == "pin_center")
            arg0 = 4;
        
        if (arg0 == "pin_right")
            arg0 = 5;
        
        if (arg0 == "justify")
            arg0 = 6;
        
        if (arg0 != starting_halign)
        {
            model_cache_name_dirty = true;
            starting_halign = arg0;
        }
        
        if (arg1 != starting_valign)
        {
            model_cache_name_dirty = true;
            starting_valign = arg1;
        }
        
        return self;
    };
    
    static blend = function(arg0, arg1)
    {
        if (is_string(arg0))
        {
            arg0 = global.__scribble_colours[? arg0];
            
            if (arg0 == undefined)
            {
                __scribble_error("Colour name \"", arg0, "\" not recognised");
                exit;
            }
        }
        
        if (arg0 != undefined)
            blend_colour = arg0 & 16777215;
        
        if (arg1 != undefined)
            blend_alpha = arg1;
        
        return self;
    };
    
    static transform = function(arg0, arg1, arg2)
    {
        xscale = arg0;
        yscale = arg1;
        angle = arg2;
        return self;
    };
    
    static origin = function(arg0, arg1)
    {
        origin_x = arg0;
        origin_y = arg1;
        return self;
    };
    
    static wrap = function(arg0, arg1 = -1, arg2 = false)
    {
        var _wrap_no_pages = false;
        var _wrap_max_scale = 1;
        
        if (arg0 != wrap_max_width || arg1 != wrap_max_height || arg2 != wrap_per_char || _wrap_no_pages != wrap_no_pages || _wrap_max_scale != wrap_max_scale)
        {
            model_cache_name_dirty = true;
            wrap_max_width = arg0;
            wrap_max_height = arg1;
            wrap_per_char = arg2;
            wrap_no_pages = _wrap_no_pages;
            wrap_max_scale = _wrap_max_scale;
        }
        
        return self;
    };
    
    static fit_to_box = function(arg0, arg1, arg2 = false, arg3 = 1)
    {
        var _wrap_no_pages = true;
        
        if (arg0 != wrap_max_width || arg1 != wrap_max_height || arg2 != wrap_per_char || _wrap_no_pages != wrap_no_pages)
        {
            model_cache_name_dirty = true;
            wrap_max_width = arg0;
            wrap_max_height = arg1;
            wrap_per_char = arg2;
            wrap_no_pages = _wrap_no_pages;
            wrap_max_scale = arg3;
        }
        
        return self;
    };
    
    static scale_to_box = function(arg0, arg1)
    {
        scale_to_box_max_width = (arg0 == undefined || arg0 < 0) ? 0 : arg0;
        scale_to_box_max_height = (arg1 == undefined || arg1 < 0) ? 0 : arg1;
        return self;
    };
    
    static line_height = function(arg0, arg1)
    {
        if (arg0 != line_height_min)
        {
            model_cache_name_dirty = true;
            line_height_min = arg0;
        }
        
        if (arg1 != line_height_max)
        {
            model_cache_name_dirty = true;
            line_height_max = arg1;
        }
        
        return self;
    };
    
    static template = function(arg0, arg1 = false)
    {
        if (is_array(arg0))
        {
            if (!arg1 || !is_array(__template) || !array_equals(__template, arg0))
            {
                __template = arg0;
                var _i = 0;
                
                repeat (array_length(arg0))
                {
                    arg0[_i]();
                    _i++;
                }
            }
        }
        else if (!arg1 || is_array(__template) || __template != arg0)
        {
            __template = arg0;
            arg0();
        }
        
        return self;
    };
    
    static page = function(arg0)
    {
        var _model = __get_model(true);
        
        if (is_struct(_model))
        {
            if (arg0 < 0)
            {
                __scribble_trace("Warning! Cannot set a text element's page to less than 0");
                __page = 0;
            }
            else if (arg0 > (_model.get_pages() - 1))
            {
                __page = _model.get_pages() - 1;
                __scribble_trace("Warning! Page ", arg0, " is too big. Valid pages are from 0 to ", __page, " (pages are 0-indexed)");
            }
            else
            {
                __page = arg0;
            }
        }
        
        return self;
    };
    
    static ignore_command_tags = function(arg0)
    {
        if (__ignore_command_tags != arg0)
        {
            model_cache_name_dirty = true;
            __ignore_command_tags = arg0;
        }
        
        return self;
    };
    
    static bezier = function(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    {
        if (argument_count <= 0)
        {
            _bezier_array = array_create(6, 0);
        }
        else if (argument_count == 8)
        {
            if (!is_numeric(arg0) || !is_numeric(arg1) || !is_numeric(arg2) || !is_numeric(arg3) || !is_numeric(arg4) || !is_numeric(arg5) || !is_numeric(arg6) || !is_numeric(arg7))
            {
                __scribble_trace("Warning! One or more Bezier parameters were not numeric (", arg0, ", ", arg1, ", ", arg2, ", ", arg3, ", ", arg4, ", ", arg5, ", ", arg6, ", ", arg7, ")");
                arg0 = 0;
                arg1 = 0;
                arg2 = 0;
                arg3 = 0;
                arg4 = 0;
                arg5 = 0;
                arg6 = 0;
                arg7 = 0;
            }
        }
        else
        {
            __scribble_error("Wrong number of arguments (", argument_count, ") provided\nExpecting 0 or 8");
        }
        
        var _bezier_array = [arg2 - arg0, arg3 - arg1, arg4 - arg0, arg5 - arg1, arg6 - arg0, arg7 - arg1];
        
        if (!array_equals(bezier_array, _bezier_array))
        {
            model_cache_name_dirty = true;
            bezier_array = _bezier_array;
            bezier_using = true;
        }
        
        return self;
    };
    
    static reveal = function(arg0)
    {
        if (__tw_reveal != arg0)
        {
            __tw_reveal = arg0;
            array_set(__tw_reveal_window_array, 0, arg0);
        }
        
        return self;
    };
    
    static get_reveal = function()
    {
        return __tw_reveal;
    };
    
    static events_get = function()
    {
        var _position = argument[0];
        var _page = (argument_count > 1 && argument[1] != undefined) ? argument[1] : __page;
        var _model = __get_model(true);
        
        if (!is_struct(_model))
            return [];
        
        _page = _model.pages_array[_page];
        var _events = variable_struct_get(_page.__events, _position);
        
        if (!is_array(_events))
            return [];
        
        return _events;
    };
    
    static msdf_shadow = function(arg0, arg1, arg2, arg3, arg4 = 0.1)
    {
        msdf_shadow_colour = arg0;
        msdf_shadow_alpha = arg1;
        msdf_shadow_xoffset = arg2;
        msdf_shadow_yoffset = arg3;
        msdf_shadow_softness = clamp(arg4, 0, 1);
        return self;
    };
    
    static msdf_border = function(arg0, arg1)
    {
        msdf_border_colour = arg0;
        msdf_border_thickness = arg1;
        return self;
    };
    
    static msdf_feather = function(arg0)
    {
        msdf_feather_thickness = arg0;
        return self;
    };
    
    static get_bbox = function(arg0 = 0, arg1 = 0, arg2 = 0, arg3 = 0, arg4 = 0, arg5 = 0)
    {
        var _model = __get_model(true);
        var _r, _l, _b, _t, _x0, _y0, _x1, _y1, _x2, _y2, _x3, _y3;
        
        if (!is_struct(_model))
        {
            _l = arg0 - arg2;
            _t = arg1 - arg3;
            _r = arg0 + arg4;
            _b = arg1 + arg5;
            _x0 = _l;
            _y0 = _t;
            _x1 = _r;
            _y1 = _t;
            _x2 = _l;
            _y2 = _b;
            _x3 = _r;
            _y3 = _b;
        }
        else
        {
            __update_scale_to_box_scale();
            var _xscale = scale_to_box_scale * xscale;
            var _yscale = scale_to_box_scale * yscale;
            var _model_bbox = _model.get_bbox(undefined);
            var _bbox_t, _bbox_b;
            
            switch (_model.valign)
            {
                case 0:
                    _bbox_t = 0;
                    _bbox_b = _model_bbox.height;
                    break;
                
                case 1:
                    _bbox_t = -(_model_bbox.height div 2);
                    _bbox_b = -_bbox_t;
                    break;
                
                case 2:
                    _bbox_t = -_model_bbox.height;
                    _bbox_b = 0;
                    break;
            }
            
            if (_xscale == 1 && _yscale == 1 && angle == 0)
            {
                _l = ((arg0 - origin_x) + _model_bbox.left) - arg2;
                _t = ((arg1 - origin_y) + _bbox_t) - arg3;
                _r = (arg0 - origin_x) + _model_bbox.right + arg4;
                _b = (arg1 - origin_y) + _bbox_b + arg5;
                _x0 = _l;
                _y0 = _t;
                _x1 = _r;
                _y1 = _t;
                _x2 = _l;
                _y2 = _b;
                _x3 = _r;
                _y3 = _b;
            }
            else
            {
                var _matrix = matrix_build(-origin_x, -origin_y, 0, 0, 0, 0, 1, 1, 1);
                _matrix = matrix_multiply(_matrix, matrix_build(arg0, arg1, 0, 0, 0, angle, _xscale, _yscale, 1));
                _l = _model_bbox.left - arg2;
                _t = _bbox_t - arg3;
                _r = _model_bbox.right + arg4;
                _b = _bbox_b + arg5;
                var _vertex = matrix_transform_vertex(_matrix, _l, _t, 0);
                _x0 = _vertex[0];
                _y0 = _vertex[1];
                _vertex = matrix_transform_vertex(_matrix, _r, _t, 0);
                _x1 = _vertex[0];
                _y1 = _vertex[1];
                _vertex = matrix_transform_vertex(_matrix, _l, _b, 0);
                _x2 = _vertex[0];
                _y2 = _vertex[1];
                _vertex = matrix_transform_vertex(_matrix, _r, _b, 0);
                _x3 = _vertex[0];
                _y3 = _vertex[1];
                _l = min(_x0, _x1, _x2, _x3);
                _t = min(_y0, _y1, _y2, _y3);
                _r = max(_x0, _x1, _x2, _x3);
                _b = max(_y0, _y1, _y2, _y3);
            }
        }
        
        var _w = (1 + _r) - _l;
        var _h = (1 + _b) - _t;
        return 
        {
            left: _l,
            top: _t,
            right: _r,
            bottom: _b,
            width: _w,
            height: _h,
            x0: _x0,
            y0: _y0,
            x1: _x1,
            y1: _y1,
            x2: _x2,
            y2: _y2,
            x3: _x3,
            y3: _y3
        };
    };
    
    static get_width = function()
    {
        var _model = __get_model(true);
        
        if (!is_struct(_model))
            return 0;
        
        __update_scale_to_box_scale();
        return scale_to_box_scale * _model.get_width();
    };
    
    static get_height = function()
    {
        var _model = __get_model(true);
        
        if (!is_struct(_model))
            return 0;
        
        __update_scale_to_box_scale();
        return scale_to_box_scale * _model.get_height();
    };
    
    static get_page = function()
    {
        return __page;
    };
    
    static get_pages = function()
    {
        var _model = __get_model(true);
        
        if (!is_struct(_model))
            return 0;
        
        return _model.get_pages();
    };
    
    static get_page_height = function()
    {
        var _page = (argument_count > 0 && argument[0] != undefined) ? argument[0] : __page;
        var _model = __get_model(true);
        
        if (!is_struct(_model))
            return 0;
        
        return _model.get_page_height(_page);
    };
    
    static get_page_width = function()
    {
        var _page = (argument_count > 0 && argument[0] != undefined) ? argument[0] : __page;
        var _model = __get_model(true);
        
        if (!is_struct(_model))
            return 0;
        
        return _model.get_page_width(_page);
    };
    
    static on_last_page = function()
    {
        return get_page() >= (get_pages() - 1);
    };
    
    static get_wrapped = function()
    {
        var _model = __get_model(true);
        
        if (!is_struct(_model))
            return false;
        
        return _model.get_wrapped();
    };
    
    static get_line_count = function()
    {
        var _page = (argument_count > 0 && argument[0] != undefined) ? argument[0] : __page;
        var _model = __get_model(true);
        
        if (!is_struct(_model))
            return 0;
        
        return _model.get_line_count(_page);
    };
    
    static get_ltrb_array = function()
    {
        var _model = __get_model(true);
        
        if (!is_struct(_model))
            return [];
        
        return _model.get_ltrb_array();
    };
    
    static __update_scale_to_box_scale = function()
    {
        var _model = __get_model(true);
        var _xscale = 1;
        var _yscale = 1;
        
        if (scale_to_box_max_width > 0)
            _xscale = scale_to_box_max_width / _model.get_width();
        
        if (scale_to_box_max_height > 0)
            _yscale = scale_to_box_max_height / _model.get_height();
        
        scale_to_box_scale = min(1, _xscale, _yscale);
    };
    
    static draw = function(arg0, arg1, arg2 = undefined)
    {
        var _function_scope = other;
        
        if (__tw_legacy_typist_use && arg2 == undefined)
            arg2 = __tw_legacy_typist;
        
        var _model = __get_model(true);
        
        if (!is_struct(_model))
            return undefined;
        
        if ((current_time - last_drawn) > ((0.95 * game_get_speed(gamespeed_microseconds)) / 1000))
        {
            animation_time += (animation_tick_speed__ * (delta_time / 16666));
            animation_time %= 16383;
        }
        
        last_drawn = current_time;
        
        if ((global.__scribble_anim_blink_on_duration + global.__scribble_anim_blink_off_duration) > 0)
            animation_blink_state = ((animation_time + global.__scribble_anim_blink_time_offset) % (global.__scribble_anim_blink_on_duration + global.__scribble_anim_blink_off_duration)) < global.__scribble_anim_blink_on_duration;
        else
            animation_blink_state = true;
        
        if (_model.uses_standard_font)
        {
            shader_set_track(__shd_scribble);
            uiClipSetInShader(__shd_scribble);
            shader_set_uniform_f(global.__scribble_u_fTime, animation_time);
            shader_set_uniform_f(global.__scribble_u_vColourBlend, colour_get_red(blend_colour) / 255, colour_get_green(blend_colour) / 255, colour_get_blue(blend_colour) / 255, blend_alpha);
            shader_set_uniform_f(global.__scribble_u_fBlinkState, animation_blink_state);
            
            if (global.__scribble_anim_shader_desync)
            {
                global.__scribble_anim_shader_desync = false;
                global.__scribble_anim_shader_default = global.__scribble_anim_shader_desync_to_default;
                shader_set_uniform_f_array(global.__scribble_u_aDataFields, global.__scribble_anim_properties);
            }
            
            if (bezier_using)
            {
                global.__scribble_bezier_using = true;
                shader_set_uniform_f_array(global.__scribble_u_aBezier, bezier_array);
            }
            else if (global.__scribble_bezier_using)
            {
                global.__scribble_bezier_using = false;
                shader_set_uniform_f_array(global.__scribble_u_aBezier, global.__scribble_bezier_null_array);
            }
            
            if (arg2 != undefined)
            {
                with (arg2)
                {
                    __tick(other, _function_scope);
                    __set_shader_uniforms();
                }
            }
            else if (__tw_reveal != undefined)
            {
                shader_set_uniform_i(global.__scribble_u_iTypewriterMethod, UnknownEnum.Value_1);
                shader_set_uniform_i(global.__scribble_u_iTypewriterCharMax, 0);
                shader_set_uniform_f(global.__scribble_u_fTypewriterSmoothness, 0);
                shader_set_uniform_f(global.__scribble_u_vTypewriterStartPos, 0, 0);
                shader_set_uniform_f(global.__scribble_u_vTypewriterStartScale, 1, 1);
                shader_set_uniform_f(global.__scribble_u_fTypewriterStartRotation, 0);
                shader_set_uniform_f(global.__scribble_u_fTypewriterAlphaDuration, 1);
                shader_set_uniform_f_array(global.__scribble_u_fTypewriterWindowArray, __tw_reveal_window_array);
            }
            else
            {
                shader_set_uniform_i(global.__scribble_u_iTypewriterMethod, UnknownEnum.Value_0);
            }
            
            shader_reset_track();
        }
        
        if (_model.uses_msdf_font)
        {
            shader_set_track(__shd_scribble_msdf);
            uiClipSetInShader(__shd_scribble_msdf);
            shader_set_uniform_f(global.__scribble_msdf_u_fTime, animation_time);
            shader_set_uniform_f(global.__scribble_msdf_u_vColourBlend, colour_get_red(blend_colour) / 255, colour_get_green(blend_colour) / 255, colour_get_blue(blend_colour) / 255, blend_alpha);
            shader_set_uniform_f(global.__scribble_msdf_u_fBlinkState, animation_blink_state);
            
            if (global.__scribble_anim_shader_msdf_desync)
            {
                global.__scribble_anim_shader_msdf_default = global.__scribble_anim_shader_msdf_desync_to_default;
                shader_set_uniform_f_array(global.__scribble_msdf_u_aDataFields, global.__scribble_anim_properties);
            }
            
            if (bezier_using)
            {
                global.__scribble_bezier_msdf_using = true;
                shader_set_uniform_f_array(global.__scribble_msdf_u_aBezier, bezier_array);
            }
            else if (global.__scribble_bezier_msdf_using)
            {
                global.__scribble_bezier_msdf_using = false;
                shader_set_uniform_f_array(global.__scribble_msdf_u_aBezier, global.__scribble_bezier_null_array);
            }
            
            if (arg2 != undefined)
            {
                with (arg2)
                {
                    __tick(other, _function_scope);
                    __set_msdf_shader_uniforms();
                }
            }
            else if (__tw_reveal != undefined)
            {
                shader_set_uniform_i(global.__scribble_msdf_u_iTypewriterMethod, UnknownEnum.Value_1);
                shader_set_uniform_i(global.__scribble_msdf_u_iTypewriterCharMax, 0);
                shader_set_uniform_f(global.__scribble_msdf_u_fTypewriterSmoothness, 0);
                shader_set_uniform_f(global.__scribble_msdf_u_vTypewriterStartPos, 0, 0);
                shader_set_uniform_f(global.__scribble_msdf_u_vTypewriterStartScale, 1, 1);
                shader_set_uniform_f(global.__scribble_msdf_u_fTypewriterStartRotation, 0);
                shader_set_uniform_f(global.__scribble_msdf_u_fTypewriterAlphaDuration, 1);
                shader_set_uniform_f_array(global.__scribble_msdf_u_fTypewriterWindowArray, __tw_reveal_window_array);
            }
            else
            {
                shader_set_uniform_i(global.__scribble_msdf_u_iTypewriterMethod, UnknownEnum.Value_0);
            }
            
            shader_set_uniform_f(global.__scribble_msdf_u_vShadowOffsetAndSoftness, msdf_shadow_xoffset, msdf_shadow_yoffset, msdf_shadow_softness);
            shader_set_uniform_f(global.__scribble_msdf_u_vShadowColour, colour_get_red(msdf_shadow_colour) / 255, colour_get_green(msdf_shadow_colour) / 255, colour_get_blue(msdf_shadow_colour) / 255, msdf_shadow_alpha);
            shader_set_uniform_f(global.__scribble_msdf_u_vBorderColour, colour_get_red(msdf_border_colour) / 255, colour_get_green(msdf_border_colour) / 255, colour_get_blue(msdf_border_colour) / 255);
            shader_set_uniform_f(global.__scribble_msdf_u_fBorderThickness, msdf_border_thickness);
            var _surface = surface_get_target();
            var _surface_width, _surface_height;
            
            if (_surface >= 0)
            {
                _surface_width = surface_get_width(_surface);
                _surface_height = surface_get_height(_surface);
            }
            else
            {
                _surface_width = window_get_width();
                _surface_height = window_get_height();
            }
            
            shader_set_uniform_f(global.__scribble_msdf_u_vOutputSize, _surface_width, _surface_height);
            shader_reset_track();
        }
        
        _model.draw(arg0, arg1, self, msdf_border_thickness > 0 || msdf_shadow_alpha > 0);
        __scribble_gc_collect();
        return undefined;
    };
    
    static flush = function()
    {
        if (flushed)
            return undefined;
        
        ds_map_delete(global.__scribble_ecache_dict, cache_name);
        var _index = ds_list_find_index(global.__scribble_ecache_list, self);
        
        if (_index >= 0)
            ds_list_delete(global.__scribble_ecache_list, _index);
        
        flushed = true;
        return undefined;
    };
    
    static build = function(arg0)
    {
        freeze = arg0;
        __get_model(true);
        return undefined;
    };
    
    static __get_model = function(arg0)
    {
        if (flushed || text == "")
        {
            model = undefined;
        }
        else
        {
            if (model_cache_name_dirty)
            {
                model_cache_name_dirty = false;
                model_cache_name = text + ":" + string(starting_font) + ":" + string(starting_colour) + ":" + string(starting_halign) + ":" + string(starting_valign) + ":" + string(line_height_min) + ":" + string(line_height_max) + ":" + string(wrap_max_width) + ":" + string(wrap_max_height) + ":" + string(wrap_per_char) + ":" + string(wrap_no_pages) + ":" + string(wrap_max_scale) + ":" + string(bezier_array) + ":" + string(__ignore_command_tags);
            }
            
            var _weak = global.__scribble_mcache_dict[? model_cache_name];
            
            if (_weak != undefined && weak_ref_alive(_weak) && !_weak.ref.flushed)
                model = _weak.ref;
            else if (arg0)
                model = new __scribble_class_model(self, model_cache_name);
            else
                model = undefined;
        }
        
        return model;
    };
    
    static typewriter_off = function()
    {
        if (__tw_legacy_typist_use)
            __tw_legacy_typist.reset();
        
        __tw_legacy_typist_use = false;
        return self;
    };
    
    static typewriter_reset = function()
    {
        __tw_legacy_typist = scribble_typist();
        __tw_legacy_typist.__associate(self);
        return self;
    };
    
    static typewriter_in = function(arg0, arg1)
    {
        __tw_legacy_typist_use = true;
        __tw_legacy_typist.in(arg0, arg1);
        return self;
    };
    
    static typewriter_out = function(arg0, arg1, arg2 = false)
    {
        __tw_legacy_typist_use = true;
        __tw_legacy_typist.out(arg0, arg1, arg2);
        return self;
    };
    
    static typewriter_skip = function()
    {
        __tw_legacy_typist.skip();
        return self;
    };
    
    static typewriter_sound = function(arg0, arg1, arg2, arg3)
    {
        __tw_legacy_typist.sound(arg0, arg1, arg2, arg3);
        return self;
    };
    
    static typewriter_sound_per_char = function(arg0, arg1, arg2)
    {
        __tw_legacy_typist.sound_per_char(arg0, arg1, arg2);
        return self;
    };
    
    static typewriter_function = function(arg0)
    {
        __tw_legacy_typist.function_per_char(arg0);
        return self;
    };
    
    static typewriter_pause = function()
    {
        __tw_legacy_typist.pause();
        return self;
    };
    
    static typewriter_unpause = function()
    {
        __tw_legacy_typist.unpause();
        return self;
    };
    
    static typewriter_ease = function(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    {
        __tw_legacy_typist.ease(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        return self;
    };
    
    static get_typewriter_state = function()
    {
        if (!__tw_legacy_typist_use)
            return 1;
        
        return __tw_legacy_typist.get_state();
    };
    
    static get_typewriter_paused = function()
    {
        if (!__tw_legacy_typist_use)
            return false;
        
        return __tw_legacy_typist.get_paused();
    };
    
    static get_typewriter_pos = function()
    {
        if (!__tw_legacy_typist_use)
            return 0;
        
        return __tw_legacy_typist.get_position();
    };
    
    text = arg0;
    unique_id = arg1;
    cache_name = arg0 + ":" + arg1;
    var _weak = global.__scribble_ecache_dict[? cache_name];
    
    if (_weak != undefined && weak_ref_alive(_weak) && !_weak.ref.flushed)
    {
        __scribble_trace("Warning! Flushing element \"", cache_name, "\" due to cache name collision");
        _weak.ref.flush();
    }
    
    global.__scribble_ecache_dict[? cache_name] = weak_ref_create(self);
    ds_list_add(global.__scribble_ecache_list, self);
    ds_list_add(global.__scribble_ecache_name_list, cache_name);
    flushed = false;
    model_cache_name_dirty = true;
    model_cache_name = undefined;
    model = undefined;
    last_drawn = current_time;
    freeze = false;
    starting_font = global.__scribble_default_font;
    starting_colour = 16777215;
    starting_halign = 0;
    starting_valign = 0;
    blend_colour = 16777215;
    blend_alpha = 1;
    xscale = 1;
    yscale = 1;
    angle = 0;
    origin_x = 0;
    origin_y = 0;
    wrap_max_width = -1;
    wrap_max_height = -1;
    wrap_per_char = false;
    wrap_no_pages = false;
    wrap_max_scale = 1;
    scale_to_box_max_width = 0;
    scale_to_box_max_height = 0;
    scale_to_box_scale = undefined;
    line_height_min = -1;
    line_height_max = -1;
    __page = 0;
    __ignore_command_tags = false;
    __template = __scribble_config_default_template;
    bezier_array = array_create(6, 0);
    bezier_using = false;
    __tw_reveal = undefined;
    __tw_reveal_window_array = array_create(6, 0);
    __tw_legacy_typist = scribble_typist();
    __tw_legacy_typist.__associate(self);
    __tw_legacy_typist_use = false;
    animation_time = current_time;
    animation_tick_speed__ = 1;
    animation_blink_state = true;
    msdf_shadow_colour = 0;
    msdf_shadow_alpha = 0;
    msdf_shadow_xoffset = 0;
    msdf_shadow_yoffset = 0;
    msdf_shadow_softness = 0;
    msdf_border_colour = 0;
    msdf_border_thickness = 0;
    msdf_feather_thickness = 1;
    __bidi_hint = undefined;
    __scribble_config_default_template();
}
