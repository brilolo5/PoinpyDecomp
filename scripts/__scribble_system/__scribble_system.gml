var _font_directory = "";

if (variable_global_exists("__scribble_lcg"))
    return undefined;

__scribble_trace("Welcome to Scribble by @jujuadams! This is version 8.0.0 alpha 6, 2021-11-18");
__scribble_trace("Verbose mode is off, set SCRIBBLE_VERBOSE to <true> to see more information");
__scribble_system_glyph_data();

if (os_type == os_ios || os_type == os_android || os_type == os_tvos)
{
    if (_font_directory != "")
    {
        __scribble_error("GameMaker's Included Files work a bit strangely on iOS and Android.\nPlease use an empty string for the font directory and place fonts in the root of Included Files");
        exit;
    }
}
else
{
}

if (_font_directory != "")
{
    var _char = string_char_at(_font_directory, string_length(_font_directory));
    
    if (_char != "\\" && _char != "/")
        _font_directory += "\\";
    
    __scribble_trace("Using font directory \"", _font_directory, "\"");
}

if (_font_directory != "" && !directory_exists(_font_directory))
    __scribble_trace("Warning! Font directory \"" + string(_font_directory) + "\" could not be found in \"" + game_save_id + "\"!");

global.__scribble_lcg = date_current_datetime() * 100;
global.__scribble_font_directory = _font_directory;
global.__scribble_font_data = ds_map_create();
global.__scribble_effects = ds_map_create();
global.__scribble_effects_slash = ds_map_create();
global.__scribble_default_font = "scribble_fallback_font";
global.__scribble_buffer = buffer_create(1024, buffer_grow, 1);
global.__scribble_glyph_grid = ds_grid_create(1000, UnknownEnum.Value_18);
global.__scribble_control_grid = ds_grid_create(1000, UnknownEnum.Value_4);
global.__scribble_word_grid = ds_grid_create(1000, UnknownEnum.Value_6);
global.__scribble_line_grid = ds_grid_create(1000, UnknownEnum.Value_7);
global.__scribble_stretch_grid = ds_grid_create(1000, UnknownEnum.Value_3);
global.__scribble_temp_grid = ds_grid_create(1000, 1);
global.__scribble_character_delay = false;
global.__scribble_character_delay_map = ds_map_create();
global.__scribble_cache_check_time = current_time;
global.__scribble_mcache_dict = ds_map_create();
global.__scribble_mcache_name_list = ds_list_create();
global.__scribble_mcache_name_index = 0;
global.__scribble_ecache_dict = ds_map_create();
global.__scribble_ecache_list = ds_list_create();
global.__scribble_ecache_list_index = 0;
global.__scribble_ecache_name_list = ds_list_create();
global.__scribble_ecache_name_index = 0;
global.__scribble_gc_vbuff_index = 0;
global.__scribble_gc_vbuff_refs = [];
global.__scribble_gc_vbuff_ids = [];
global.__scribble_generator_state = {};

if (!variable_global_exists("__scribble_colours"))
    global.__scribble_colours = ds_map_create();

if (!variable_global_exists("__scribble_typewriter_events"))
    global.__scribble_typewriter_events = ds_map_create();

global.__scribble_typewriter_events[? "pause"] = undefined;
global.__scribble_typewriter_events[? "delay"] = undefined;
global.__scribble_typewriter_events[? "speed"] = undefined;
global.__scribble_typewriter_events[? "/speed"] = undefined;
global.__scribble_effects[? "wave"] = 1;
global.__scribble_effects[? "shake"] = 2;
global.__scribble_effects[? "rainbow"] = 3;
global.__scribble_effects[? "wobble"] = 4;
global.__scribble_effects[? "pulse"] = 5;
global.__scribble_effects[? "wheel"] = 6;
global.__scribble_effects[? "cycle"] = 7;
global.__scribble_effects[? "jitter"] = 8;
global.__scribble_effects[? "blink"] = 9;
global.__scribble_effects_slash[? "/wave"] = 1;
global.__scribble_effects_slash[? "/shake"] = 2;
global.__scribble_effects_slash[? "/rainbow"] = 3;
global.__scribble_effects_slash[? "/wobble"] = 4;
global.__scribble_effects_slash[? "/pulse"] = 5;
global.__scribble_effects_slash[? "/wheel"] = 6;
global.__scribble_effects_slash[? "/cycle"] = 7;
global.__scribble_effects_slash[? "/jitter"] = 8;
global.__scribble_effects_slash[? "/blink"] = 9;
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_colour();
vertex_format_add_texcoord();
vertex_format_add_custom(vertex_type_float2, vertex_usage_color);
global.__scribble_vertex_format = vertex_format_end();
vertex_format_begin();
vertex_format_add_position();
vertex_format_add_color();
vertex_format_add_texcoord();
global.__scribble_passthrough_vertex_format = vertex_format_end();
global.__scribble_u_fTime = shader_get_uniform(__shd_scribble, "u_fTime");
global.__scribble_u_vColourBlend = shader_get_uniform(__shd_scribble, "u_vColourBlend");
global.__scribble_u_aDataFields = shader_get_uniform(__shd_scribble, "u_aDataFields");
global.__scribble_u_aBezier = shader_get_uniform(__shd_scribble, "u_aBezier");
global.__scribble_u_fBlinkState = shader_get_uniform(__shd_scribble, "u_fBlinkState");
global.__scribble_u_iTypewriterMethod = shader_get_uniform(__shd_scribble, "u_iTypewriterMethod");
global.__scribble_u_iTypewriterCharMax = shader_get_uniform(__shd_scribble, "u_iTypewriterCharMax");
global.__scribble_u_fTypewriterWindowArray = shader_get_uniform(__shd_scribble, "u_fTypewriterWindowArray");
global.__scribble_u_fTypewriterSmoothness = shader_get_uniform(__shd_scribble, "u_fTypewriterSmoothness");
global.__scribble_u_vTypewriterStartPos = shader_get_uniform(__shd_scribble, "u_vTypewriterStartPos");
global.__scribble_u_vTypewriterStartScale = shader_get_uniform(__shd_scribble, "u_vTypewriterStartScale");
global.__scribble_u_fTypewriterStartRotation = shader_get_uniform(__shd_scribble, "u_fTypewriterStartRotation");
global.__scribble_u_fTypewriterAlphaDuration = shader_get_uniform(__shd_scribble, "u_fTypewriterAlphaDuration");
global.__scribble_msdf_u_fTime = shader_get_uniform(__shd_scribble_msdf, "u_fTime");
global.__scribble_msdf_u_vColourBlend = shader_get_uniform(__shd_scribble_msdf, "u_vColourBlend");
global.__scribble_msdf_u_aDataFields = shader_get_uniform(__shd_scribble_msdf, "u_aDataFields");
global.__scribble_msdf_u_aBezier = shader_get_uniform(__shd_scribble_msdf, "u_aBezier");
global.__scribble_msdf_u_fBlinkState = shader_get_uniform(__shd_scribble_msdf, "u_fBlinkState");
global.__scribble_msdf_u_vTexel = shader_get_uniform(__shd_scribble_msdf, "u_vTexel");
global.__scribble_msdf_u_fMSDFRange = shader_get_uniform(__shd_scribble_msdf, "u_fMSDFRange");
global.__scribble_msdf_u_iTypewriterMethod = shader_get_uniform(__shd_scribble_msdf, "u_iTypewriterMethod");
global.__scribble_msdf_u_iTypewriterCharMax = shader_get_uniform(__shd_scribble_msdf, "u_iTypewriterCharMax");
global.__scribble_msdf_u_fTypewriterWindowArray = shader_get_uniform(__shd_scribble_msdf, "u_fTypewriterWindowArray");
global.__scribble_msdf_u_fTypewriterSmoothness = shader_get_uniform(__shd_scribble_msdf, "u_fTypewriterSmoothness");
global.__scribble_msdf_u_vTypewriterStartPos = shader_get_uniform(__shd_scribble_msdf, "u_vTypewriterStartPos");
global.__scribble_msdf_u_vTypewriterStartScale = shader_get_uniform(__shd_scribble_msdf, "u_vTypewriterStartScale");
global.__scribble_msdf_u_fTypewriterStartRotation = shader_get_uniform(__shd_scribble_msdf, "u_fTypewriterStartRotation");
global.__scribble_msdf_u_fTypewriterAlphaDuration = shader_get_uniform(__shd_scribble_msdf, "u_fTypewriterAlphaDuration");
global.__scribble_msdf_u_vShadowColour = shader_get_uniform(__shd_scribble_msdf, "u_vShadowColour");
global.__scribble_msdf_u_vShadowOffsetAndSoftness = shader_get_uniform(__shd_scribble_msdf, "u_vShadowOffsetAndSoftness");
global.__scribble_msdf_u_vBorderColour = shader_get_uniform(__shd_scribble_msdf, "u_vBorderColour");
global.__scribble_msdf_u_fBorderThickness = shader_get_uniform(__shd_scribble_msdf, "u_fBorderThickness");
global.__scribble_msdf_u_vOutputSize = shader_get_uniform(__shd_scribble_msdf, "u_vOutputSize");
global.__scribble_msdf_u_fMSDFThicknessOffset = shader_get_uniform(__shd_scribble_msdf, "u_fMSDFThicknessOffset");
global.__scribble_msdf_u_fSecondDraw = shader_get_uniform(__shd_scribble_msdf, "u_fSecondDraw");
scribble_msdf_thickness_offset(0);
global.__scribble_anim_shader_desync = false;
global.__scribble_anim_shader_desync_to_default = false;
global.__scribble_anim_shader_default = false;
global.__scribble_anim_shader_msdf_desync = false;
global.__scribble_anim_shader_msdf_desync_to_default = false;
global.__scribble_anim_shader_msdf_default = false;
global.__scribble_anim_properties = array_create(UnknownEnum.Value_20);
scribble_anim_reset();
global.__scribble_bezier_using = false;
global.__scribble_bezier_msdf_using = false;
global.__scribble_bezier_null_array = array_create(6, 0);
var _i = 0;

repeat (1000)
{
    if (!font_exists(_i))
        break;
    
    var _skip = false;
    var _tags = asset_get_tags(_i, 7);
    var _j = 0;
    
    repeat (array_length(_tags))
    {
        if (string_lower(_tags[_j]) == "scribble skip")
        {
            _skip = true;
            break;
        }
        
        _j++;
    }
    
    var _name = font_get_name(_i);
    
    if (string_copy(_name, 1, 9) == "__newfont")
        _skip = true;
    
    if (!_skip)
        __scribble_font_add_from_project(_i);
    
    _i++;
}

var _assets = [];
var _array = tag_get_assets("Scribble MSDF");
array_copy(_assets, array_length(_assets), _array, 0, array_length(_array));
_array = tag_get_assets("scribble MSDF");
array_copy(_assets, array_length(_assets), _array, 0, array_length(_array));
_array = tag_get_assets("Scribble msdf");
array_copy(_assets, array_length(_assets), _array, 0, array_length(_array));
_array = tag_get_assets("scribble msdf");
array_copy(_assets, array_length(_assets), _array, 0, array_length(_array));
_array = tag_get_assets("scribblemsdf");
array_copy(_assets, array_length(_assets), _array, 0, array_length(_array));
_i = 0;

repeat (array_length(_assets))
{
    var _asset = _assets[_i];
    
    if (asset_get_type(_asset) != 1)
        __scribble_error("\"scribble msdf\" tag should only be applied to sprite assets (\"", _asset, "\" had the tag)");
    else
        __scribble_font_add_msdf_from_project(asset_get_index(_asset));
    
    _i++;
}

function __scribble_trace()
{
    var _string = "Scribble: ";
    var _i = 0;
    
    repeat (argument_count)
    {
        if (is_real(argument[_i]))
            _string += string_format(argument[_i], 0, 4);
        else
            _string += string(argument[_i]);
        
        _i++;
    }
    
    show_debug_message(_string);
}

function __scribble_error()
{
    var _string = "";
    var _i = 0;
    
    repeat (argument_count)
    {
        _string += string(argument[_i]);
        _i++;
    }
    
    show_debug_message("Scribble: " + string_replace_all(_string, "\n", "\n          "));
    show_error("Scribble:\n" + _string + "\n ", true);
}

function __scribble_get_font_data(arg0)
{
    var _data = global.__scribble_font_data[? arg0];
    
    if (_data == undefined)
        __scribble_error("Font \"", arg0, "\" not recognised");
    
    return _data;
}

function __scribble_process_colour(arg0)
{
    if (is_string(arg0))
    {
        if (!ds_map_exists(global.__scribble_colours, arg0))
            __scribble_error("Colour \"", arg0, "\" not recognised. Please add it to __scribble_config_colours()");
        
        return global.__scribble_colours[? arg0] & 16777215;
    }
    else
    {
        return arg0;
    }
}

function __scribble_random()
{
    global.__scribble_lcg = (48271 * global.__scribble_lcg) % 2147483647;
    return global.__scribble_lcg / 2147483648;
}

function __scribble_array_find_index(arg0, arg1)
{
    var _i = 0;
    
    repeat (array_length(arg0))
    {
        if (arg0[_i] == arg1)
            return _i;
        
        _i++;
    }
    
    return -1;
}

function __scribble_prepare_collage_work_array(arg0)
{
    var _output_array = [];
    var _i = 0;
    
    repeat (array_length(arg0))
    {
        var _glyph_to_copy = arg0[_i];
        
        if (is_string(_glyph_to_copy))
        {
            var _j = 1;
            
            repeat (string_length(_glyph_to_copy))
            {
                var _ord = ord(string_char_at(_glyph_to_copy, _j));
                array_push(_output_array, [_ord, _ord]);
                _j++;
            }
            
            _glyph_to_copy = undefined;
        }
        
        if (is_numeric(_glyph_to_copy))
            _glyph_to_copy = [_glyph_to_copy, _glyph_to_copy];
        
        if (is_array(_glyph_to_copy))
            array_push(_output_array, _glyph_to_copy);
        
        _i++;
    }
    
    return _output_array;
}

function __scribble_glyph_duplicate(arg0, arg1 = 0)
{
    var _new = array_create(UnknownEnum.Value_13);
    array_copy(_new, 0, arg0, 0, UnknownEnum.Value_13);
    array_set(_new, UnknownEnum.Value_5, array_get(_new, UnknownEnum.Value_5) + arg1);
    return _new;
}

function __scribble_buffer_read_unicode(arg0)
{
    var _value = buffer_read(arg0, buffer_u8);
    
    if ((_value & 224) == 192)
    {
        _value = (_value & 31) << 6;
        _value += (buffer_read(arg0, buffer_u8) & 63);
    }
    else if ((_value & 240) == 224)
    {
        _value = (_value & 15) << 12;
        _value += ((buffer_read(arg0, buffer_u8) & 63) << 6);
        _value += (buffer_read(arg0, buffer_u8) & 63);
    }
    else if ((_value & 248) == 240)
    {
        _value = (_value & 7) << 18;
        _value += ((buffer_read(arg0, buffer_u8) & 63) << 12);
        _value += ((buffer_read(arg0, buffer_u8) & 63) << 6);
        _value += (buffer_read(arg0, buffer_u8) & 63);
    }
    
    return _value;
}

function __scribble_buffer_peek_unicode(arg0, arg1)
{
    var _value = buffer_peek(arg0, arg1, buffer_u8);
    
    if ((_value & 224) == 192)
    {
        _value = (_value & 31) << 6;
        _value += (buffer_peek(arg0, arg1 + 1, buffer_u8) & 63);
    }
    else if ((_value & 240) == 224)
    {
        _value = (_value & 15) << 12;
        _value += ((buffer_peek(arg0, arg1 + 1, buffer_u8) & 63) << 6);
        _value += (buffer_peek(arg0, arg1 + 2, buffer_u8) & 63);
    }
    else if ((_value & 248) == 240)
    {
        _value = (_value & 7) << 18;
        _value += ((buffer_peek(arg0, arg1 + 1, buffer_u8) & 63) << 12);
        _value += ((buffer_peek(arg0, arg1 + 2, buffer_u8) & 63) << 6);
        _value += (buffer_peek(arg0, arg1 + 3, buffer_u8) & 63);
    }
    
    return _value;
}

function __scribble_buffer_write_unicode(arg0, arg1)
{
    if (arg1 <= 127)
    {
        buffer_write(arg0, buffer_u8, arg1);
    }
    else if (arg1 <= 2047)
    {
        buffer_write(arg0, buffer_u8, 192 | (arg1 & 31));
        buffer_write(arg0, buffer_u8, 128 | ((arg1 >> 5) & 63));
    }
    else if (arg1 <= 65535)
    {
        buffer_write(arg0, buffer_u8, 192 | (arg1 & 15));
        buffer_write(arg0, buffer_u8, 128 | ((arg1 >> 4) & 63));
        buffer_write(arg0, buffer_u8, 128 | ((arg1 >> 10) & 63));
    }
    else if (arg1 <= 65536)
    {
        buffer_write(arg0, buffer_u8, 192 | (arg1 & 7));
        buffer_write(arg0, buffer_u8, 128 | ((arg1 >> 3) & 63));
        buffer_write(arg0, buffer_u8, 128 | ((arg1 >> 9) & 63));
        buffer_write(arg0, buffer_u8, 128 | ((arg1 >> 15) & 63));
    }
}
