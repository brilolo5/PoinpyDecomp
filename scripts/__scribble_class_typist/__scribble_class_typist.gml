function __scribble_class_typist() constructor
{
    static in = function(arg0, arg1)
    {
        var _old_in = __in;
        __in = true;
        __backwards = false;
        __speed = arg0;
        __smoothness = arg1;
        __skip = false;
        
        if (_old_in == undefined || !_old_in)
            __reset();
        
        return self;
    };
    
    static out = function(arg0, arg1, arg2 = false)
    {
        var _old_in = __in;
        __in = false;
        __backwards = arg2;
        __speed = arg0;
        __smoothness = arg1;
        __skip = false;
        
        if (_old_in == undefined || _old_in)
            __reset();
        
        return self;
    };
    
    static skip = function()
    {
        __skip = true;
        return self;
    };
    
    static sound = function(arg0, arg1, arg2, arg3)
    {
        if (!is_array(arg0))
            arg0 = [arg0];
        
        __sound_array = arg0;
        __sound_overlap = arg1;
        __sound_pitch_min = arg2;
        __sound_pitch_max = arg3;
        __sound_per_char = false;
        return self;
    };
    
    static sound_per_char = function(arg0, arg1, arg2)
    {
        if (!is_array(arg0))
            arg0 = [arg0];
        
        __sound_array = arg0;
        __sound_pitch_min = arg1;
        __sound_pitch_max = arg2;
        __sound_per_char = true;
        return self;
    };
    
    static function_per_char = function(arg0)
    {
        __function = arg0;
        return self;
    };
    
    static pause = function()
    {
        __paused = true;
        return self;
    };
    
    static unpause = function()
    {
        if (__paused)
        {
            var _head_pos = __window_array[__window_index];
            __window_index = (__window_index + 2) % 6;
            array_set(__window_array, __window_index, _head_pos);
            array_set(__window_array, __window_index + 1, _head_pos - __smoothness);
        }
        
        __paused = false;
        return self;
    };
    
    static ease = function(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    {
        __ease_method = arg0;
        __ease_dx = arg1;
        __ease_dy = arg2;
        __ease_xscale = arg3;
        __ease_yscale = arg4;
        __ease_rotation = arg5;
        __ease_alpha_duration = arg6;
        return self;
    };
    
    static get_skip = function()
    {
        return __skip;
    };
    
    static get_state = function()
    {
        if (__last_element == undefined || __last_page == undefined || __last_character == undefined)
            return 0;
        
        if (__in == undefined)
            return 1;
        
        var _model = __last_element.ref.__get_model(true);
        
        if (!is_struct(_model))
            return 2;
        
        var _pages_array = _model.get_page_array();
        
        if (array_length(_pages_array) <= __last_page)
            return 1;
        
        var _page_data = _pages_array[__last_page];
        var _min = 0;
        var _max = _page_data.__character_count;
        
        if (_max <= _min)
            return 1;
        
        var _t = clamp((get_position() - _min) / (_max - _min), 0, 1);
        
        if (__in)
        {
            if (__delay_paused || array_length(__event_stack) > 0)
                return min(1 - (2 * math_get_epsilon()), _t);
            else
                return _t;
        }
        else
        {
            return _t + 1;
        }
    };
    
    static get_paused = function()
    {
        return __paused;
    };
    
    static get_position = function()
    {
        if (__in == undefined)
            return 0;
        
        return __window_array[__window_index];
    };
    
    static get_text_element = function()
    {
        return __last_element;
    };
    
    static __reset = function()
    {
        __last_page = 0;
        __last_character = 0;
        __last_audio_character = 0;
        __last_tick_time = -infinity;
        __window_index = 0;
        __window_array = array_create(6, -__smoothness);
        array_set(__window_array, 0, 0);
        __skip = false;
        __paused = false;
        __delay_paused = false;
        __delay_end = -1;
        __inline_speed = 1;
        __event_stack = [];
        return self;
    };
    
    static __associate = function(arg0)
    {
        if (__last_element == undefined || __last_element.ref != arg0)
        {
            __reset();
            __last_element = weak_ref_create(arg0);
        }
        else if (!weak_ref_alive(__last_element))
        {
            __scribble_trace("Warning! Typist's target text element has been garbage collected");
            __reset();
            __last_element = weak_ref_create(arg0);
        }
        else if (__last_element.ref.__page != __last_page)
        {
            __reset();
        }
        
        __last_page = __last_element.ref.__page;
        return self;
    };
    
    static __process_event_stack = function(arg0, arg1)
    {
        repeat (array_length(__event_stack))
        {
            var _event_struct = __event_stack[0];
            array_delete(__event_stack, 0, 1);
            var _event_position = _event_struct.position;
            var _event_name = _event_struct.name;
            var _event_data = _event_struct.data;
            
            switch (_event_name)
            {
                case "pause":
                    if (!__skip)
                    {
                        __paused = true;
                        return false;
                    }
                    
                    break;
                
                case "delay":
                    if (!__skip)
                    {
                        var _duration = (array_length(_event_data) >= 1) ? real(_event_data[0]) : 450;
                        __delay_paused = true;
                        __delay_end = current_time + _duration;
                        return false;
                    }
                    
                    break;
                
                case "speed":
                    if (array_length(_event_data) >= 1)
                        __inline_speed = real(_event_data[0]);
                    
                    break;
                
                case "/speed":
                    __inline_speed = 1;
                    break;
                
                case "__scribble_audio_playback__":
                    if (array_length(_event_data) >= 1)
                    {
                        var _asset = asset_get_index(_event_data[0]);
                        __scribble_trace(_asset);
                        audio_play_sound(_asset, 1, false);
                    }
                    
                    break;
                
                default:
                    var _function = global.__scribble_typewriter_events[? _event_name];
                    
                    if (is_method(_function))
                    {
                        with (arg1)
                            _function(arg0, _event_data, _event_position);
                    }
                    else if (is_real(_function) && script_exists(_function))
                    {
                        with (arg1)
                            script_execute(_function, arg0, _event_data, _event_position);
                    }
                    else
                    {
                        __scribble_trace("Warning! Event [", _event_name, "] not recognised");
                    }
                    
                    break;
            }
        }
        
        return true;
    };
    
    static __play_sound = function(arg0)
    {
        var _sound_array = __sound_array;
        
        if (is_array(_sound_array) && array_length(_sound_array) > 0)
        {
            var _play_sound = false;
            
            if (__sound_per_char)
            {
                if (floor(arg0 + 0.0001) > floor(__last_audio_character))
                    _play_sound = true;
            }
            else if (current_time >= __sound_finish_time)
            {
                _play_sound = true;
            }
            
            if (_play_sound)
            {
                __last_audio_character = arg0;
                var _inst = audio_play_sound(_sound_array[floor(__scribble_random() * array_length(_sound_array))], 0, false);
                audio_sound_pitch(_inst, lerp(__sound_pitch_min, __sound_pitch_max, __scribble_random()));
                __sound_finish_time = (current_time + (1000 * audio_sound_length(_inst))) - __sound_overlap;
            }
        }
    };
    
    static __execute_function_per_character = function(arg0)
    {
        if (is_method(__function))
            __function(arg0, __last_character - 1, self);
        else if (is_real(__function) && script_exists(__function))
            script_execute(__function, arg0, __last_character - 1, self);
    };
    
    static __tick = function(arg0, arg1)
    {
        __associate(arg0);
        
        if ((current_time - __last_tick_time) < ((0.95 * game_get_speed(gamespeed_microseconds)) / 1000))
            return undefined;
        
        __last_tick_time = current_time;
        
        if (__in == undefined)
            return undefined;
        
        var _speed = __speed * __inline_speed * (delta_time / 16666);
        var _head_pos = __window_array[__window_index];
        
        if (!__in)
        {
            var _model = __last_element.ref.__get_model(true);
            
            if (!is_struct(_model))
                return undefined;
            
            var _pages_array = _model.get_page_array();
            
            if (array_length(_pages_array) <= __last_page)
                return undefined;
            
            var _page_data = _pages_array[__last_page];
            
            if (__skip)
                array_set(__window_array, __window_index, _page_data.__character_count);
            else
                array_set(__window_array, __window_index, min(_page_data.__character_count, _head_pos + _speed));
        }
        else
        {
            var _paused = false;
            
            if (__paused)
            {
                _paused = true;
            }
            else if (__delay_paused)
            {
                if (current_time > __delay_end)
                {
                    __delay_paused = false;
                    __window_index = (__window_index + 2) % 6;
                    array_set(__window_array, __window_index, _head_pos);
                    array_set(__window_array, __window_index + 1, _head_pos - __smoothness);
                }
                else
                {
                    _paused = true;
                }
            }
            
            if (!_paused && array_length(__event_stack) > 0)
            {
                if (!__process_event_stack(arg0, arg1))
                    _paused = true;
            }
            
            if (!_paused)
            {
                var _model = __last_element.ref.__get_model(true);
                
                if (!is_struct(_model))
                    return undefined;
                
                var _pages_array = _model.get_page_array();
                
                if (array_length(_pages_array) == 0)
                    return undefined;
                
                var _page_data = _pages_array[__last_page];
                var _play_sound = false;
                var _remaining;
                
                if (__skip)
                    _remaining = _page_data.__character_count - _head_pos;
                else
                    _remaining = min(_page_data.__character_count - _head_pos, _speed);
                
                while (_remaining > 0)
                {
                    _head_pos += min(1, _remaining);
                    _remaining -= 1;
                    
                    if (_head_pos >= __last_character)
                    {
                        _play_sound = true;
                        var _found_events = __last_element.ref.events_get(__last_character);
                        __last_character++;
                        
                        if (__last_character > 1)
                            __execute_function_per_character(arg0);
                        
                        var _found_size = array_length(_found_events);
                        
                        if (_found_size > 0)
                        {
                            var _old_stack_size = array_length(__event_stack);
                            array_resize(__event_stack, _old_stack_size + _found_size);
                            array_copy(__event_stack, _old_stack_size, _found_events, 0, _found_size);
                            
                            if (!__process_event_stack(arg0, arg1))
                            {
                                _head_pos = __last_character - 1;
                                break;
                            }
                        }
                    }
                }
                
                if (_play_sound)
                    __play_sound(_head_pos);
                
                array_set(__window_array, __window_index, _head_pos);
            }
        }
        
        if (__skip)
        {
            var _i = 0;
            
            repeat (3)
            {
                array_set(__window_array, _i + 1, __window_array[_i]);
                _i += 2;
            }
        }
        else
        {
            var _i = 0;
            
            repeat (3)
            {
                array_set(__window_array, _i + 1, min(__window_array[_i + 1] + _speed, __window_array[_i]));
                _i += 2;
            }
        }
    };
    
    static __set_shader_uniforms = function()
    {
        if (__in == undefined)
        {
            shader_set_uniform_i(global.__scribble_u_iTypewriterMethod, UnknownEnum.Value_0);
            return undefined;
        }
        
        var _method = __ease_method;
        
        if (!__in)
            _method += UnknownEnum.Value_15;
        
        var _char_max = 0;
        
        if (__backwards)
        {
            var _model = __last_element.ref.__get_model(true);
            
            if (!is_struct(_model))
                return undefined;
            
            var _pages_array = _model.get_page_array();
            
            if (array_length(_pages_array) > __last_page)
            {
                var _page_data = _pages_array[__last_page];
                _char_max = _page_data.__character_count;
            }
            else
            {
                __scribble_trace("Warning! Typist page (", __last_page, ") exceeds text element page count (", array_length(_pages_array), ")");
            }
        }
        
        shader_set_uniform_i(global.__scribble_u_iTypewriterMethod, _method);
        shader_set_uniform_i(global.__scribble_u_iTypewriterCharMax, _char_max);
        shader_set_uniform_f(global.__scribble_u_fTypewriterSmoothness, __smoothness);
        shader_set_uniform_f(global.__scribble_u_vTypewriterStartPos, __ease_dx, __ease_dy);
        shader_set_uniform_f(global.__scribble_u_vTypewriterStartScale, __ease_xscale, __ease_yscale);
        shader_set_uniform_f(global.__scribble_u_fTypewriterStartRotation, __ease_rotation);
        shader_set_uniform_f(global.__scribble_u_fTypewriterAlphaDuration, __ease_alpha_duration);
        shader_set_uniform_f_array(global.__scribble_u_fTypewriterWindowArray, __window_array);
    };
    
    static __set_msdf_shader_uniforms = function()
    {
        if (__in == undefined)
        {
            shader_set_uniform_i(global.__scribble_msdf_u_iTypewriterMethod, UnknownEnum.Value_0);
            return undefined;
        }
        
        var _method = __ease_method;
        
        if (!__in)
            _method += UnknownEnum.Value_15;
        
        var _char_max = 0;
        
        if (__backwards)
        {
            var _model = __last_element.ref.__get_model(true);
            
            if (!is_struct(_model))
                return undefined;
            
            var _pages_array = _model.get_page_array();
            
            if (array_length(_pages_array) > __last_page)
            {
                var _page_data = _pages_array[__last_page];
                _char_max = _page_data.__character_count;
            }
            else
            {
                __scribble_trace("Warning! Typist page (", __last_page, ") exceeds text element page count (", array_length(_pages_array), ")");
            }
        }
        
        shader_set_uniform_i(global.__scribble_msdf_u_iTypewriterMethod, _method);
        shader_set_uniform_i(global.__scribble_msdf_u_iTypewriterCharMax, _char_max);
        shader_set_uniform_f(global.__scribble_msdf_u_fTypewriterSmoothness, __smoothness);
        shader_set_uniform_f(global.__scribble_msdf_u_vTypewriterStartPos, __ease_dx, __ease_dy);
        shader_set_uniform_f(global.__scribble_msdf_u_vTypewriterStartScale, __ease_xscale, __ease_yscale);
        shader_set_uniform_f(global.__scribble_msdf_u_fTypewriterStartRotation, __ease_rotation);
        shader_set_uniform_f(global.__scribble_msdf_u_fTypewriterAlphaDuration, __ease_alpha_duration);
        shader_set_uniform_f_array(global.__scribble_msdf_u_fTypewriterWindowArray, __window_array);
    };
    
    __last_element = undefined;
    __last_page = 0;
    __last_character = 0;
    __last_audio_character = 0;
    __last_tick_time = -infinity;
    __window_index = 0;
    __window_array = array_create(6, 0);
    __skip = false;
    __paused = false;
    __delay_paused = false;
    __delay_end = -1;
    __inline_speed = 1;
    __event_stack = [];
    __speed = 1;
    __smoothness = 0;
    __in = undefined;
    __backwards = false;
    __sound_array = undefined;
    __sound_overlap = 0;
    __sound_pitch_min = 1;
    __sound_pitch_max = 1;
    __sound_per_char = false;
    __sound_finish_time = current_time;
    __function = undefined;
    __ease_method = UnknownEnum.Value_1;
    __ease_dx = 0;
    __ease_dy = 0;
    __ease_xscale = 1;
    __ease_yscale = 1;
    __ease_rotation = 0;
    __ease_alpha_duration = 1;
}
