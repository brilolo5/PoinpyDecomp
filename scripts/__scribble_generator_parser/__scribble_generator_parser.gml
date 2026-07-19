function __scribble_generator_parser()
{
    var _string_buffer = global.__scribble_buffer;
    var _glyph_grid = global.__scribble_glyph_grid;
    var _word_grid = global.__scribble_word_grid;
    var _control_grid = global.__scribble_control_grid;
    var _arabic_join_next_map = global.__scribble_glyph_data.arabic_join_next_map;
    var _arabic_join_prev_map = global.__scribble_glyph_data.arabic_join_prev_map;
    var _arabic_isolated_map = global.__scribble_glyph_data.arabic_isolated_map;
    var _arabic_initial_map = global.__scribble_glyph_data.arabic_initial_map;
    var _arabic_medial_map = global.__scribble_glyph_data.arabic_medial_map;
    var _arabic_final_map = global.__scribble_glyph_data.arabic_final_map;
    var _thai_base_map = global.__scribble_glyph_data.thai_base_map;
    var _thai_base_descender_map = global.__scribble_glyph_data.thai_base_descender_map;
    var _thai_base_ascender_map = global.__scribble_glyph_data.thai_base_ascender_map;
    var _thai_top_map = global.__scribble_glyph_data.thai_top_map;
    var _thai_lower_map = global.__scribble_glyph_data.thai_lower_map;
    var _thai_upper_map = global.__scribble_glyph_data.thai_upper_map;
    var _element = global.__scribble_generator_state.element;
    var _element_text = _element.text;
    var _starting_colour = __scribble_process_colour(_element.starting_colour);
    var _starting_halign = _element.starting_halign;
    var _starting_valign = _element.starting_valign;
    var _ignore_commands = _element.__ignore_command_tags;
    var _starting_font = _element.starting_font;
    
    if (_starting_font == undefined)
        __scribble_error("The default font has not been set\nCheck that you've added fonts to Scribble (scribble_font_add() / scribble_font_add_from_sprite() etc.)");
    
    var _font_name = _starting_font;
    var _font_data = __scribble_get_font_data(_font_name);
    var _font_glyphs_map = _font_data.glyphs_map;
    var _font_msdf_pxrange = _font_data.msdf_pxrange;
    var _font_scale_dist = _font_data.scale_dist;
    var _space_glyph_data = _font_glyphs_map[? 32];
    
    if (_space_glyph_data == undefined)
    {
        __scribble_error("The space character is missing from font definition for \"", _font_name, "\"");
        return false;
    }
    
    var _font_line_height = _space_glyph_data[UnknownEnum.Value_3];
    var _font_space_width = _space_glyph_data[UnknownEnum.Value_2];
    buffer_seek(_string_buffer, buffer_seek_start, 0);
    buffer_write(_string_buffer, buffer_string, _element_text);
    buffer_write(_string_buffer, buffer_u64, 0);
    buffer_seek(_string_buffer, buffer_seek_start, 0);
    var _element_text_length = string_length(_element_text);
    
    if (ds_grid_width(_glyph_grid) < _element_text_length)
        ds_grid_resize(_glyph_grid, _element_text_length + 1, UnknownEnum.Value_18);
    
    if (ds_grid_width(_word_grid) < _element_text_length)
        ds_grid_resize(_word_grid, _element_text_length + 1, UnknownEnum.Value_18);
    
    var _tag_start = undefined;
    var _tag_parameter_count = 0;
    var _tag_parameters = undefined;
    var _tag_command_name = "";
    var _glyph_count = 0;
    var _glyph_ord = 0;
    var _glyph_prev = undefined;
    var _glyph_prev_prev = undefined;
    var _glyph_prev_arabic_join_next = false;
    var _control_count = 0;
    var _control_page = 0;
    var _skip_write = false;
    var _state_colour = _starting_colour;
    var _state_alpha_255 = 255;
    var _state_final_colour = (_state_alpha_255 << 24) | _state_colour;
    var _state_effect_flags = 0;
    var _state_scale = 1;
    var _state_slant = false;
    var _state_cycle = false;
    var _state_halign = _starting_halign;
    var _state_command_tag_flipflop = false;
    _control_grid[# _control_count, UnknownEnum.Value_0] = -3;
    _control_grid[# _control_count, UnknownEnum.Value_1] = _state_halign;
    _control_grid[# _control_count, UnknownEnum.Value_2] = _glyph_count;
    _control_grid[# _control_count, UnknownEnum.Value_3] = _control_page;
    _control_count++;
    
    repeat (string_byte_length(_element_text))
    {
        _glyph_ord = buffer_read(_string_buffer, buffer_u8);
        
        if (_glyph_ord == 0)
            break;
        
        if ((_glyph_ord & 224) == 192)
        {
            _glyph_ord = ((_glyph_ord & 31) << 6) | (buffer_read(_string_buffer, buffer_u8) & 63);
        }
        else if ((_glyph_ord & 240) == 224)
        {
            var _glyph_ord_b = buffer_read(_string_buffer, buffer_u8);
            var _glyph_ord_c = buffer_read(_string_buffer, buffer_u8);
            _glyph_ord = ((_glyph_ord & 15) << 12) | ((_glyph_ord_b & 63) << 6) | (_glyph_ord_c & 63);
        }
        else if ((_glyph_ord & 248) == 240)
        {
            var _glyph_ord_b = buffer_read(_string_buffer, buffer_u8);
            var _glyph_ord_c = buffer_read(_string_buffer, buffer_u8);
            var _glyph_ord_d = buffer_read(_string_buffer, buffer_u8);
            _glyph_ord = ((_glyph_ord & 7) << 18) | ((_glyph_ord_b & 63) << 12) | ((_glyph_ord_c & 63) << 6) | (_glyph_ord_d & 63);
        }
        else
        {
        }
        
        if (_tag_start != undefined)
        {
            if (_glyph_ord == 93)
            {
                _tag_parameter_count++;
                buffer_poke(_string_buffer, buffer_tell(_string_buffer) - 1, buffer_u8, 0);
                buffer_seek(_string_buffer, buffer_seek_start, _tag_start);
                
                repeat (_tag_parameter_count)
                    array_set(_tag_parameters, array_length(_tag_parameters), buffer_read(_string_buffer, buffer_string));
                
                _tag_start = undefined;
                _tag_command_name = _tag_parameters[0];
                var _new_halign = undefined;
                var _new_valign = undefined;
                
                switch (_tag_command_name)
                {
                    case "":
                    case "/":
                        _state_colour = _starting_colour;
                        _state_alpha_255 = 255;
                        _state_final_colour = (_state_alpha_255 << 24) | _state_colour;
                        _state_effect_flags = 0;
                        _state_scale = 1;
                        _state_slant = false;
                        _state_cycle = false;
                        
                        if (_font_name != _starting_font)
                        {
                            _font_name = _starting_font;
                            _font_data = __scribble_get_font_data(_font_name);
                            _font_glyphs_map = _font_data.glyphs_map;
                            _font_msdf_pxrange = _font_data.msdf_pxrange;
                            _font_scale_dist = _font_data.scale_dist;
                            _space_glyph_data = _font_glyphs_map[? 32];
                            
                            if (_space_glyph_data == undefined)
                            {
                                __scribble_error("The space character is missing from font definition for \"", _font_name, "\"");
                                return false;
                            }
                            
                            _font_line_height = _space_glyph_data[UnknownEnum.Value_3];
                            _font_space_width = _space_glyph_data[UnknownEnum.Value_2];
                        }
                        
                        break;
                    
                    case "/font":
                    case "/f":
                        if (_font_name != _starting_font)
                        {
                            _font_name = _starting_font;
                            _font_data = __scribble_get_font_data(_font_name);
                            _font_glyphs_map = _font_data.glyphs_map;
                            _font_msdf_pxrange = _font_data.msdf_pxrange;
                            _font_scale_dist = _font_data.scale_dist;
                            _space_glyph_data = _font_glyphs_map[? 32];
                            
                            if (_space_glyph_data == undefined)
                            {
                                __scribble_error("The space character is missing from font definition for \"", _font_name, "\"");
                                return false;
                            }
                            
                            _font_line_height = _space_glyph_data[UnknownEnum.Value_3];
                            _font_space_width = _space_glyph_data[UnknownEnum.Value_2];
                        }
                        
                        break;
                    
                    case "/colour":
                    case "/color":
                    case "/c":
                        _state_colour = _starting_colour;
                        
                        if (!_state_cycle)
                            _state_final_colour = (_state_alpha_255 << 24) | _state_colour;
                        
                        break;
                    
                    case "/alpha":
                    case "/a":
                        _state_alpha_255 = 255;
                        
                        if (!_state_cycle)
                            _state_final_colour = (_state_alpha_255 << 24) | _state_colour;
                        
                        break;
                    
                    case "/scale":
                    case "/s":
                        _state_scale = 1;
                        break;
                    
                    case "/slant":
                        _state_slant = false;
                        break;
                    
                    case "/page":
                        _control_grid[# _control_count, UnknownEnum.Value_0] = -5;
                        _control_grid[# _control_count, UnknownEnum.Value_1] = undefined;
                        _control_grid[# _control_count, UnknownEnum.Value_2] = _glyph_count;
                        _control_grid[# _control_count, UnknownEnum.Value_3] = _control_page;
                        _control_count++;
                        _control_page++;
                        break;
                    
                    case "scale":
                        if (_tag_parameter_count <= 1)
                            __scribble_trace("Not enough parameters for [scale] tag!");
                        else
                            _state_scale = real(_tag_parameters[1]);
                        
                        break;
                    
                    case "scaleStack":
                        if (_tag_parameter_count <= 1)
                            __scribble_trace("Not enough parameters for [scaleStack] tag!");
                        else
                            _state_scale *= real(_tag_parameters[1]);
                        
                        break;
                    
                    case "slant":
                        _state_slant = true;
                        break;
                    
                    case "alpha":
                        _state_alpha_255 = floor(255 * clamp(_tag_parameters[1], 0, 1));
                        
                        if (!_state_cycle)
                            _state_final_colour = (_state_alpha_255 << 24) | _state_colour;
                        
                        break;
                    
                    case "fa_left":
                        _new_halign = 0;
                        break;
                    
                    case "fa_center":
                    case "fa_centre":
                        _new_halign = 1;
                        break;
                    
                    case "fa_right":
                        _new_halign = 2;
                        break;
                    
                    case "fa_top":
                        _new_valign = 0;
                        break;
                    
                    case "fa_middle":
                        _new_valign = 1;
                        break;
                    
                    case "fa_bottom":
                        _new_valign = 2;
                        break;
                    
                    case "js_left":
                    case "js_center":
                    case "js_centre":
                    case "js_right":
                        __scribble_error("[js_*] tags have been deprecated. Please use [pin_*]");
                        break;
                    
                    case "pin_left":
                        _new_halign = 3;
                        break;
                    
                    case "pin_center":
                    case "pin_centre":
                        _new_halign = 4;
                        break;
                    
                    case "pin_right":
                        _new_halign = 5;
                        break;
                    
                    case "fa_justify":
                        _new_halign = 6;
                        break;
                    
                    case "nbsp":
                    case "&nbsp":
                    case "nbsp;":
                    case "&nbsp;":
                        repeat ((array_length(_tag_parameters) == 2) ? real(_tag_parameters[1]) : 1)
                        {
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_4] = 160;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_6] = _font_data;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_7] = _space_glyph_data;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_2] = _state_scale * _font_space_width;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_3] = _state_scale * _font_line_height;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_8] = _state_scale * _font_space_width;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_17] = UnknownEnum.Value_1;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_12] = _state_final_colour;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_13] = _state_effect_flags;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_14] = _state_scale;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_15] = _state_slant;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_16] = _font_scale_dist;
                            _glyph_count++;
                            _glyph_prev_arabic_join_next = false;
                            _glyph_prev = 160;
                            _glyph_prev_prev = _glyph_prev;
                        }
                        
                        break;
                    
                    case "cycle":
                        var _cycle_r = (_tag_parameter_count > 1) ? max(1, real(_tag_parameters[1])) : 0;
                        var _cycle_g = (_tag_parameter_count > 2) ? max(1, real(_tag_parameters[2])) : 0;
                        var _cycle_b = (_tag_parameter_count > 3) ? max(1, real(_tag_parameters[3])) : 0;
                        var _cycle_a = (_tag_parameter_count > 4) ? max(1, real(_tag_parameters[4])) : 0;
                        _state_cycle = true;
                        _state_final_colour = (_cycle_a << 24) | (_cycle_b << 16) | (_cycle_g << 8) | _cycle_r;
                        _state_effect_flags = _state_effect_flags | (1 << global.__scribble_effects[? _tag_command_name]);
                        break;
                    
                    case "/cycle":
                        _state_cycle = false;
                        _state_final_colour = (_state_alpha_255 << 24) | _state_colour;
                        _state_effect_flags = ~(~_state_effect_flags | (1 << global.__scribble_effects_slash[? _tag_command_name]));
                        break;
                    
                    case "r":
                    case "/b":
                    case "/i":
                    case "/bi":
                        var _new_font = _font_data.style_regular;
                        
                        if (_new_font == undefined)
                        {
                            __scribble_trace("Regular style not set for font \"", _font_name, "\"");
                        }
                        else if (!ds_map_exists(global.__scribble_font_data, _new_font))
                        {
                            __scribble_trace("Font \"", _font_name, "\" not found (regular style for \"", _font_name, "\")");
                        }
                        else
                        {
                            _font_name = _new_font;
                            _font_data = __scribble_get_font_data(_font_name);
                            _font_glyphs_map = _font_data.glyphs_map;
                            _font_msdf_pxrange = _font_data.msdf_pxrange;
                            _font_scale_dist = _font_data.scale_dist;
                            _space_glyph_data = _font_glyphs_map[? 32];
                            
                            if (_space_glyph_data == undefined)
                            {
                                __scribble_error("The space character is missing from font definition for \"", _font_name, "\"");
                                return false;
                            }
                            
                            _font_line_height = _space_glyph_data[UnknownEnum.Value_3];
                            _font_space_width = _space_glyph_data[UnknownEnum.Value_2];
                        }
                        
                        break;
                    
                    case "b":
                        var _new_font = _font_data.style_bold;
                        
                        if (_new_font == undefined)
                        {
                            __scribble_trace("Bold style not set for font \"", _font_name, "\"");
                        }
                        else if (!ds_map_exists(global.__scribble_font_data, _new_font))
                        {
                            __scribble_trace("Font \"", _font_name, "\" not found (bold style for \"", _font_name, "\")");
                        }
                        else
                        {
                            _font_name = _new_font;
                            _font_data = __scribble_get_font_data(_font_name);
                            _font_glyphs_map = _font_data.glyphs_map;
                            _font_msdf_pxrange = _font_data.msdf_pxrange;
                            _font_scale_dist = _font_data.scale_dist;
                            _space_glyph_data = _font_glyphs_map[? 32];
                            
                            if (_space_glyph_data == undefined)
                            {
                                __scribble_error("The space character is missing from font definition for \"", _font_name, "\"");
                                return false;
                            }
                            
                            _font_line_height = _space_glyph_data[UnknownEnum.Value_3];
                            _font_space_width = _space_glyph_data[UnknownEnum.Value_2];
                        }
                        
                        break;
                    
                    case "i":
                        var _new_font = _font_data.style_italic;
                        
                        if (_new_font == undefined)
                        {
                            __scribble_trace("Italic style not set for font \"", _font_name, "\"");
                        }
                        else if (!ds_map_exists(global.__scribble_font_data, _new_font))
                        {
                            __scribble_trace("Font \"", _font_name, "\" not found (italic style for \"", _font_name, "\")");
                        }
                        else
                        {
                            _font_name = _new_font;
                            _font_data = __scribble_get_font_data(_font_name);
                            _font_glyphs_map = _font_data.glyphs_map;
                            _font_msdf_pxrange = _font_data.msdf_pxrange;
                            _font_scale_dist = _font_data.scale_dist;
                            _space_glyph_data = _font_glyphs_map[? 32];
                            
                            if (_space_glyph_data == undefined)
                            {
                                __scribble_error("The space character is missing from font definition for \"", _font_name, "\"");
                                return false;
                            }
                            
                            _font_line_height = _space_glyph_data[UnknownEnum.Value_3];
                            _font_space_width = _space_glyph_data[UnknownEnum.Value_2];
                        }
                        
                        break;
                    
                    case "bi":
                        var _new_font = _font_data.style_bold_italic;
                        
                        if (_new_font == undefined)
                        {
                            __scribble_trace("Bold-Italic style not set for font \"", _font_name, "\"");
                        }
                        else if (!ds_map_exists(global.__scribble_font_data, _new_font))
                        {
                            __scribble_trace("Font \"", _font_name, "\" not found (bold-italic style for \"", _font_name, "\")");
                        }
                        else
                        {
                            _font_name = _new_font;
                            _font_data = __scribble_get_font_data(_font_name);
                            _font_glyphs_map = _font_data.glyphs_map;
                            _font_msdf_pxrange = _font_data.msdf_pxrange;
                            _font_scale_dist = _font_data.scale_dist;
                            _space_glyph_data = _font_glyphs_map[? 32];
                            
                            if (_space_glyph_data == undefined)
                            {
                                __scribble_error("The space character is missing from font definition for \"", _font_name, "\"");
                                return false;
                            }
                            
                            _font_line_height = _space_glyph_data[UnknownEnum.Value_3];
                            _font_space_width = _space_glyph_data[UnknownEnum.Value_2];
                        }
                        
                        break;
                    
                    case "surface":
                        var _surface = real(_tag_parameters[1]);
                        var _surface_width = _state_scale * surface_get_width(_surface);
                        _glyph_grid[# _glyph_count, UnknownEnum.Value_4] = -2;
                        _glyph_grid[# _glyph_count, UnknownEnum.Value_6] = undefined;
                        _glyph_grid[# _glyph_count, UnknownEnum.Value_2] = _surface_width;
                        _glyph_grid[# _glyph_count, UnknownEnum.Value_3] = _state_scale * surface_get_height(_surface);
                        _glyph_grid[# _glyph_count, UnknownEnum.Value_8] = _surface_width;
                        _glyph_grid[# _glyph_count, UnknownEnum.Value_9] = _surface;
                        _glyph_grid[# _glyph_count, UnknownEnum.Value_17] = UnknownEnum.Value_1;
                        _glyph_grid[# _glyph_count, UnknownEnum.Value_12] = _state_final_colour;
                        _glyph_grid[# _glyph_count, UnknownEnum.Value_13] = _state_effect_flags;
                        _glyph_grid[# _glyph_count, UnknownEnum.Value_14] = _state_scale;
                        _glyph_grid[# _glyph_count, UnknownEnum.Value_15] = _state_slant;
                        _glyph_grid[# _glyph_count, UnknownEnum.Value_16] = _font_scale_dist;
                        _glyph_count++;
                        _glyph_prev_arabic_join_next = false;
                        _glyph_prev = -2;
                        _glyph_prev_prev = _glyph_prev;
                        break;
                    
                    default:
                        if (ds_map_exists(global.__scribble_effects, _tag_command_name))
                        {
                            _state_effect_flags = _state_effect_flags | (1 << global.__scribble_effects[? _tag_command_name]);
                        }
                        else if (ds_map_exists(global.__scribble_effects_slash, _tag_command_name))
                        {
                            _state_effect_flags = ~(~_state_effect_flags | (1 << global.__scribble_effects_slash[? _tag_command_name]));
                        }
                        else if (ds_map_exists(global.__scribble_colours, _tag_command_name))
                        {
                            _state_colour = global.__scribble_colours[? _tag_command_name] & 16777215;
                            
                            if (!_state_cycle)
                                _state_final_colour = (_state_alpha_255 << 24) | _state_colour;
                        }
                        else if (ds_map_exists(global.__scribble_typewriter_events, _tag_command_name))
                        {
                            array_delete(_tag_parameters, 0, 1);
                            _control_grid[# _control_count, UnknownEnum.Value_0] = -4;
                            _control_grid[# _control_count, UnknownEnum.Value_1] = new __scribble_class_event(_tag_command_name, _tag_parameters);
                            _control_grid[# _control_count, UnknownEnum.Value_2] = _glyph_count;
                            _control_grid[# _control_count, UnknownEnum.Value_3] = _control_page;
                            _control_count++;
                        }
                        else if (ds_map_exists(global.__scribble_font_data, _tag_command_name))
                        {
                            _font_name = _tag_command_name;
                            _font_data = __scribble_get_font_data(_font_name);
                            _font_glyphs_map = _font_data.glyphs_map;
                            _font_msdf_pxrange = _font_data.msdf_pxrange;
                            _font_scale_dist = _font_data.scale_dist;
                            _space_glyph_data = _font_glyphs_map[? 32];
                            
                            if (_space_glyph_data == undefined)
                            {
                                __scribble_error("The space character is missing from font definition for \"", _font_name, "\"");
                                return false;
                            }
                            
                            _font_line_height = _space_glyph_data[UnknownEnum.Value_3];
                            _font_space_width = _space_glyph_data[UnknownEnum.Value_2];
                        }
                        else if (asset_get_type(_tag_command_name) == 1)
                        {
                            var _sprite_index = asset_get_index(_tag_command_name);
                            var _sprite_width = _state_scale * sprite_get_width(_sprite_index);
                            var _image_index = 0;
                            var _image_speed = 0;
                            
                            switch (_tag_parameter_count)
                            {
                                case 1:
                                    _image_index = 0;
                                    _image_speed = 0.1;
                                    break;
                                
                                case 2:
                                    _image_index = real(_tag_parameters[1]);
                                    _image_speed = 0;
                                    break;
                                
                                default:
                                    _image_index = real(_tag_parameters[1]);
                                    _image_speed = real(_tag_parameters[2]);
                                    break;
                            }
                            
                            var _old_effect_flags = _state_effect_flags;
                            
                            if (_image_speed > 0)
                                _state_effect_flags |= 1;
                            
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_4] = -1;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_6] = undefined;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_2] = _sprite_width;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_3] = _state_scale * sprite_get_height(_sprite_index);
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_8] = _sprite_width;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_9] = _sprite_index;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_10] = _image_index;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_11] = _image_speed;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_17] = UnknownEnum.Value_1;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_12] = _state_final_colour;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_13] = _state_effect_flags;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_14] = _state_scale;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_15] = _state_slant;
                            _glyph_grid[# _glyph_count, UnknownEnum.Value_16] = _font_scale_dist;
                            _glyph_count++;
                            _glyph_prev_arabic_join_next = false;
                            _glyph_prev = -1;
                            _glyph_prev_prev = _glyph_prev;
                            _state_effect_flags = _old_effect_flags;
                        }
                        else if (asset_get_type(_tag_command_name) == 2)
                        {
                            _tag_command_name = "__scribble_audio_playback__";
                            _control_grid[# _control_count, UnknownEnum.Value_0] = -4;
                            _control_grid[# _control_count, UnknownEnum.Value_1] = new __scribble_class_event(_tag_command_name, _tag_parameters);
                            _control_grid[# _control_count, UnknownEnum.Value_2] = _glyph_count;
                            _control_grid[# _control_count, UnknownEnum.Value_3] = _control_page;
                            _control_count++;
                        }
                        else
                        {
                            var _first_char = string_copy(_tag_command_name, 1, 1);
                            
                            if (string_length(_tag_command_name) <= 7 && (_first_char == "$" || _first_char == "#"))
                            {
                                try
                                {
                                    _state_colour = real("0x" + string_delete(_tag_command_name, 1, 1));
                                    _state_colour = scribble_rgb_to_bgr(_state_colour);
                                }
                                catch (_)
                                {
                                    __scribble_trace("Error! \"", string_delete(_tag_command_name, 1, 2), "\" could not be converted into a hexcode");
                                    _state_colour = _starting_colour;
                                }
                                
                                if (!_state_cycle)
                                    _state_final_colour = (_state_alpha_255 << 24) | _state_colour;
                            }
                            else
                            {
                                var _second_char = string_copy(_tag_command_name, 2, 1);
                                
                                if ((_first_char == "d" || _first_char == "D") && (_second_char == "$" || _second_char == "#"))
                                {
                                    try
                                    {
                                        _state_colour = real(string_delete(_tag_command_name, 1, 2));
                                    }
                                    catch (_error)
                                    {
                                        __scribble_trace("Error! \"", string_delete(_tag_command_name, 1, 2), "\" could not be converted into a decimal");
                                        _state_colour = _starting_colour;
                                    }
                                    
                                    if (!_state_cycle)
                                        _state_final_colour = (_state_alpha_255 << 24) | _state_colour;
                                }
                                else
                                {
                                    var _command_string = string(_tag_command_name);
                                    var _j = 1;
                                    
                                    repeat (_tag_parameter_count - 1)
                                        _command_string += ("," + string(_tag_parameters[_j++]));
                                    
                                    __scribble_trace("Warning! Unrecognised command tag [" + _command_string + "]");
                                }
                            }
                        }
                        
                        break;
                }
                
                if (_new_halign != undefined && _new_halign != _state_halign)
                {
                    _state_halign = _new_halign;
                    _new_halign = undefined;
                    _control_grid[# _control_count, UnknownEnum.Value_0] = -3;
                    _control_grid[# _control_count, UnknownEnum.Value_1] = _state_halign;
                    _control_grid[# _control_count, UnknownEnum.Value_2] = _glyph_count;
                    _control_grid[# _control_count, UnknownEnum.Value_3] = _control_page;
                    _control_count++;
                }
                
                if (_new_valign != undefined)
                {
                    if (valign == undefined)
                        valign = _new_valign;
                    else if (valign != _new_valign)
                        __scribble_error("In-line vertical alignment cannot be set more than once");
                    
                    _new_valign = undefined;
                }
            }
            else if (_glyph_ord == 44)
            {
                _tag_parameter_count++;
                buffer_poke(_string_buffer, buffer_tell(_string_buffer) - 1, buffer_u8, 0);
            }
        }
        else if (_glyph_ord == 91 && !_ignore_commands && (_state_command_tag_flipflop || __scribble_buffer_peek_unicode(_string_buffer, buffer_tell(_string_buffer)) != 91))
        {
            if (_state_command_tag_flipflop)
            {
                _state_command_tag_flipflop = false;
            }
            else
            {
                _tag_start = buffer_tell(_string_buffer);
                _tag_parameter_count = 0;
                _tag_parameters = [];
            }
        }
        else if (_glyph_ord == 10 || (false && _glyph_ord == 35))
        {
            _glyph_grid[# _glyph_count, UnknownEnum.Value_4] = 10;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_6] = _font_data;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_2] = 0;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_3] = _state_scale * _font_line_height;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_8] = 0;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_17] = UnknownEnum.Value_2;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_12] = _state_final_colour;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_13] = _state_effect_flags;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_14] = _state_scale;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_15] = _state_slant;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_16] = _font_scale_dist;
            _glyph_count++;
            _glyph_prev_arabic_join_next = false;
            _glyph_prev = _glyph_ord;
            _glyph_prev_prev = _glyph_prev;
        }
        else if (_glyph_ord == 9)
        {
            _glyph_grid[# _glyph_count, UnknownEnum.Value_4] = 9;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_6] = _font_data;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_7] = _space_glyph_data;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_2] = _state_scale * 4 * _font_space_width;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_3] = _state_scale * _font_line_height;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_8] = _state_scale * 4 * _font_space_width;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_17] = UnknownEnum.Value_0;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_12] = _state_final_colour;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_13] = _state_effect_flags;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_14] = _state_scale;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_15] = _state_slant;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_16] = _font_scale_dist;
            _glyph_count++;
            _glyph_prev_arabic_join_next = false;
            _glyph_prev = 9;
            _glyph_prev_prev = _glyph_prev;
        }
        else if (_glyph_ord == 32)
        {
            _glyph_grid[# _glyph_count, UnknownEnum.Value_4] = 32;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_6] = _font_data;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_7] = _space_glyph_data;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_2] = _state_scale * _font_space_width;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_3] = _state_scale * _font_line_height;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_8] = _state_scale * _font_space_width;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_17] = UnknownEnum.Value_0;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_12] = _state_final_colour;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_13] = _state_effect_flags;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_14] = _state_scale;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_15] = _state_slant;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_16] = _font_scale_dist;
            _glyph_count++;
            _glyph_prev_arabic_join_next = false;
            _glyph_prev = 32;
            _glyph_prev_prev = _glyph_prev;
        }
        else if (_glyph_ord == 8203)
        {
            _glyph_grid[# _glyph_count, UnknownEnum.Value_4] = 8203;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_6] = _font_data;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_7] = _space_glyph_data;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_2] = 0;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_3] = _state_scale * _font_line_height;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_8] = 0;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_17] = UnknownEnum.Value_0;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_12] = _state_final_colour;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_13] = _state_effect_flags;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_14] = _state_scale;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_15] = _state_slant;
            _glyph_grid[# _glyph_count, UnknownEnum.Value_16] = _font_scale_dist;
            _glyph_count++;
        }
        else if (_glyph_ord > 32)
        {
            var _glyph_write = _glyph_ord;
            
            if (_glyph_write >= 1536 && _glyph_write <= 1791)
            {
                has_arabic = true;
                var _buffer_offset = buffer_tell(_string_buffer);
                var _glyph_next = __scribble_buffer_peek_unicode(_string_buffer, _buffer_offset);
                
                if (_glyph_write == 1604)
                {
                    var _glyph_replacement = undefined;
                    
                    switch (_glyph_next)
                    {
                        case 1570:
                            _glyph_replacement = 65269;
                            break;
                        
                        case 1571:
                            _glyph_replacement = 65271;
                            break;
                        
                        case 1573:
                            _glyph_replacement = 65273;
                            break;
                        
                        case 1575:
                            _glyph_replacement = 65275;
                            break;
                    }
                    
                    if (_glyph_replacement != undefined)
                    {
                        _glyph_write = _glyph_replacement;
                        buffer_seek(_string_buffer, buffer_seek_relative, 2);
                        _glyph_next = __scribble_buffer_peek_unicode(_string_buffer, _buffer_offset);
                    }
                }
                
                while (_glyph_next >= 1611 && _glyph_next <= 1618)
                {
                    _buffer_offset += 2;
                    _glyph_next = __scribble_buffer_peek_unicode(_string_buffer, _buffer_offset);
                }
                
                var _new_glyph = undefined;
                
                if (_glyph_prev_arabic_join_next)
                {
                    if (_arabic_join_prev_map[? _glyph_next])
                        _new_glyph = _arabic_medial_map[? _glyph_write];
                    else
                        _new_glyph = _arabic_final_map[? _glyph_write];
                }
                else if (_arabic_join_prev_map[? _glyph_next])
                {
                    _new_glyph = _arabic_initial_map[? _glyph_write];
                }
                else
                {
                    _new_glyph = _arabic_isolated_map[? _glyph_write];
                }
                
                if (_new_glyph != undefined)
                    _glyph_write = _new_glyph;
                
                if (_glyph_ord < 1611 || _glyph_ord > 1618)
                    _glyph_prev_arabic_join_next = _arabic_join_next_map[? _glyph_ord];
            }
            else
            {
                _glyph_prev_arabic_join_next = false;
                
                if (_glyph_write >= 3584 && _glyph_write <= 3711)
                {
                    has_thai = true;
                    
                    if (_thai_top_map[? _glyph_write] && _glyph_count >= 1)
                    {
                        var _base = _glyph_prev;
                        
                        if (_thai_lower_map[? _base] && _glyph_count >= 2)
                            _base = _glyph_prev_prev;
                        
                        if (_thai_base_map[? _base])
                        {
                            var _glyph_next = __scribble_buffer_peek_unicode(_string_buffer, buffer_tell(_string_buffer));
                            var _followingNikhahit = _glyph_next == 3635 || _glyph_next == 3661;
                            
                            if (_thai_base_ascender_map[? _base])
                            {
                                if (_followingNikhahit)
                                {
                                    _glyph_write += 59595;
                                    var _glyph_write_actual = _glyph_write;
                                    _glyph_write = 63249;
                                    var _glyph_data = _font_glyphs_map[? _glyph_write];
                                    
                                    if (_glyph_data == undefined)
                                        _glyph_data = _font_glyphs_map[? 63];
                                    
                                    if (_glyph_data == undefined)
                                    {
                                        __scribble_trace("Couldn't find glyph data for character code " + string(_glyph_write) + " (" + chr(_glyph_write) + ") in font \"" + string(_font_name) + "\"");
                                    }
                                    else
                                    {
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_4] = _glyph_write;
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_6] = _font_data;
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_7] = _glyph_data;
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_2] = _state_scale * _glyph_data[UnknownEnum.Value_2];
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_3] = _state_scale * _font_line_height;
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_8] = _state_scale * _glyph_data[UnknownEnum.Value_6];
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_17] = _glyph_data[UnknownEnum.Value_12];
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_12] = _state_final_colour;
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_13] = _state_effect_flags;
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_14] = _state_scale;
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_15] = _state_slant;
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_16] = _font_scale_dist;
                                        _glyph_count++;
                                        _glyph_prev = _glyph_write;
                                        _glyph_prev_prev = _glyph_prev;
                                    }
                                    
                                    _glyph_write = _glyph_write_actual;
                                    _glyph_data = _font_glyphs_map[? _glyph_write];
                                    
                                    if (_glyph_data == undefined)
                                        _glyph_data = _font_glyphs_map[? 63];
                                    
                                    if (_glyph_data == undefined)
                                    {
                                        __scribble_trace("Couldn't find glyph data for character code " + string(_glyph_write) + " (" + chr(_glyph_write) + ") in font \"" + string(_font_name) + "\"");
                                    }
                                    else
                                    {
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_4] = _glyph_write;
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_6] = _font_data;
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_7] = _glyph_data;
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_2] = _state_scale * _glyph_data[UnknownEnum.Value_2];
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_3] = _state_scale * _font_line_height;
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_8] = _state_scale * _glyph_data[UnknownEnum.Value_6];
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_17] = _glyph_data[UnknownEnum.Value_12];
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_12] = _state_final_colour;
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_13] = _state_effect_flags;
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_14] = _state_scale;
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_15] = _state_slant;
                                        _glyph_grid[# _glyph_count, UnknownEnum.Value_16] = _font_scale_dist;
                                        _glyph_count++;
                                        _glyph_prev = _glyph_write;
                                        _glyph_prev_prev = _glyph_prev;
                                    }
                                    
                                    if (_glyph_next == 3635)
                                    {
                                        _glyph_write = 3634;
                                        _glyph_data = _font_glyphs_map[? _glyph_write];
                                        
                                        if (_glyph_data == undefined)
                                            _glyph_data = _font_glyphs_map[? 63];
                                        
                                        if (_glyph_data == undefined)
                                        {
                                            __scribble_trace("Couldn't find glyph data for character code " + string(_glyph_write) + " (" + chr(_glyph_write) + ") in font \"" + string(_font_name) + "\"");
                                        }
                                        else
                                        {
                                            _glyph_grid[# _glyph_count, UnknownEnum.Value_4] = _glyph_write;
                                            _glyph_grid[# _glyph_count, UnknownEnum.Value_6] = _font_data;
                                            _glyph_grid[# _glyph_count, UnknownEnum.Value_7] = _glyph_data;
                                            _glyph_grid[# _glyph_count, UnknownEnum.Value_2] = _state_scale * _glyph_data[UnknownEnum.Value_2];
                                            _glyph_grid[# _glyph_count, UnknownEnum.Value_3] = _state_scale * _font_line_height;
                                            _glyph_grid[# _glyph_count, UnknownEnum.Value_8] = _state_scale * _glyph_data[UnknownEnum.Value_6];
                                            _glyph_grid[# _glyph_count, UnknownEnum.Value_17] = _glyph_data[UnknownEnum.Value_12];
                                            _glyph_grid[# _glyph_count, UnknownEnum.Value_12] = _state_final_colour;
                                            _glyph_grid[# _glyph_count, UnknownEnum.Value_13] = _state_effect_flags;
                                            _glyph_grid[# _glyph_count, UnknownEnum.Value_14] = _state_scale;
                                            _glyph_grid[# _glyph_count, UnknownEnum.Value_15] = _state_slant;
                                            _glyph_grid[# _glyph_count, UnknownEnum.Value_16] = _font_scale_dist;
                                            _glyph_count++;
                                            _glyph_prev = _glyph_write;
                                            _glyph_prev_prev = _glyph_prev;
                                        }
                                    }
                                    
                                    buffer_seek(_string_buffer, buffer_seek_relative, 2);
                                    _skip_write = true;
                                }
                                else
                                {
                                    _glyph_write += 59581;
                                }
                            }
                            else if (!_followingNikhahit)
                            {
                                _glyph_write += 59586;
                            }
                        }
                        
                        if (!_skip_write)
                        {
                            if (_glyph_count >= 2 && _thai_upper_map[? _glyph_prev] && _thai_base_ascender_map[? _glyph_prev])
                                _glyph_write += 59595;
                        }
                    }
                    else if (_thai_upper_map[? _glyph_write] && _glyph_count > 0 && _thai_base_ascender_map[? _glyph_prev])
                    {
                        switch (_glyph_write)
                        {
                            case 3633:
                                _glyph_write = 63248;
                                break;
                            
                            case 3636:
                                _glyph_write = 63233;
                                break;
                            
                            case 3637:
                                _glyph_write = 63234;
                                break;
                            
                            case 3638:
                                _glyph_write = 63235;
                                break;
                            
                            case 3639:
                                _glyph_write = 63236;
                                break;
                            
                            case 3661:
                                _glyph_write = 63249;
                                break;
                            
                            case 3655:
                                _glyph_write = 63250;
                                break;
                        }
                    }
                    else if (_thai_lower_map[? _glyph_write] && _glyph_count > 0 && _thai_base_descender_map[? _glyph_prev])
                    {
                        _glyph_write += 59616;
                    }
                    else
                    {
                        var _glyph_next = __scribble_buffer_peek_unicode(_string_buffer, buffer_tell(_string_buffer));
                        
                        if (_glyph_write == 3597 && _thai_lower_map[? _glyph_next])
                            _glyph_write = 63247;
                        else if (_glyph_write == 3600 && _thai_lower_map[? _glyph_next])
                            _glyph_write = 63232;
                    }
                }
            }
            
            if (_skip_write)
            {
                _skip_write = false;
            }
            else
            {
                var _glyph_data = _font_glyphs_map[? _glyph_write];
                
                if (_glyph_data == undefined)
                    _glyph_data = _font_glyphs_map[? 63];
                
                if (_glyph_data == undefined)
                {
                    __scribble_trace("Couldn't find glyph data for character code " + string(_glyph_write) + " (" + chr(_glyph_write) + ") in font \"" + string(_font_name) + "\"");
                }
                else
                {
                    _glyph_grid[# _glyph_count, UnknownEnum.Value_4] = _glyph_write;
                    _glyph_grid[# _glyph_count, UnknownEnum.Value_6] = _font_data;
                    _glyph_grid[# _glyph_count, UnknownEnum.Value_7] = _glyph_data;
                    _glyph_grid[# _glyph_count, UnknownEnum.Value_2] = _state_scale * _glyph_data[UnknownEnum.Value_2];
                    _glyph_grid[# _glyph_count, UnknownEnum.Value_3] = _state_scale * _font_line_height;
                    _glyph_grid[# _glyph_count, UnknownEnum.Value_8] = _state_scale * _glyph_data[UnknownEnum.Value_6];
                    _glyph_grid[# _glyph_count, UnknownEnum.Value_17] = _glyph_data[UnknownEnum.Value_12];
                    _glyph_grid[# _glyph_count, UnknownEnum.Value_12] = _state_final_colour;
                    _glyph_grid[# _glyph_count, UnknownEnum.Value_13] = _state_effect_flags;
                    _glyph_grid[# _glyph_count, UnknownEnum.Value_14] = _state_scale;
                    _glyph_grid[# _glyph_count, UnknownEnum.Value_15] = _state_slant;
                    _glyph_grid[# _glyph_count, UnknownEnum.Value_16] = _font_scale_dist;
                    _glyph_count++;
                    _glyph_prev = _glyph_write;
                    _glyph_prev_prev = _glyph_prev;
                }
            }
            
            if (_glyph_ord == 91)
                _state_command_tag_flipflop = true;
            
            if (global.__scribble_character_delay)
            {
                var _delay = global.__scribble_character_delay_map[? _glyph_ord];
                
                if (_delay != undefined)
                {
                    _tag_command_name = "delay";
                    _tag_parameters = [_delay];
                    _control_grid[# _control_count, UnknownEnum.Value_0] = -4;
                    _control_grid[# _control_count, UnknownEnum.Value_1] = new __scribble_class_event(_tag_command_name, _tag_parameters);
                    _control_grid[# _control_count, UnknownEnum.Value_2] = _glyph_count;
                    _control_grid[# _control_count, UnknownEnum.Value_3] = _control_page;
                    _control_count++;
                }
            }
        }
    }
    
    if (valign == undefined)
        valign = _starting_valign;
    
    _glyph_grid[# _glyph_count, UnknownEnum.Value_4] = 0;
    _glyph_grid[# _glyph_count, UnknownEnum.Value_6] = _font_data;
    _glyph_grid[# _glyph_count, UnknownEnum.Value_2] = 0;
    _glyph_grid[# _glyph_count, UnknownEnum.Value_8] = 0;
    _control_grid[# _control_count, UnknownEnum.Value_0] = 0;
    _control_grid[# _control_count, UnknownEnum.Value_1] = undefined;
    _control_grid[# _control_count, UnknownEnum.Value_2] = _glyph_count;
    _control_grid[# _control_count, UnknownEnum.Value_3] = _control_page;
    
    with (global.__scribble_generator_state)
    {
        glyph_count = _glyph_count;
        control_count = _control_count;
    }
}
