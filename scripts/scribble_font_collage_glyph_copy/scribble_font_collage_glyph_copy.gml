function scribble_font_collage_glyph_copy(arg0, arg1, arg2)
{
    var _target_font_data = global.__scribble_font_data[? arg0];
    var _source_font_data = global.__scribble_font_data[? arg1];
    
    if (_target_font_data == undefined)
        __scribble_error("Font \"", arg0, "\" not found");
    
    if (_source_font_data == undefined)
        __scribble_error("Font \"", arg1, "\" not found");
    
    var _y_offset = __scribble_font_collage_glyph_copy_common(_target_font_data, _source_font_data);
    var _target_glyphs_map = _target_font_data.glyphs_map;
    var _source_glyphs_map = _source_font_data.glyphs_map;
    var _glyphs_array = array_create(argument_count - 3);
    var _i = 0;
    
    repeat (argument_count - 3)
    {
        array_set(_glyphs_array, _i, argument[_i + 3]);
        _i++;
    }
    
    var _work_array = __scribble_prepare_collage_work_array(_glyphs_array);
    _i = 0;
    
    repeat (array_length(_work_array))
    {
        var _glyph_range_array = _work_array[_i];
        var _ord = _glyph_range_array[0];
        
        repeat ((1 + _glyph_range_array[1]) - _ord)
        {
            var _source_glyph_data = _source_glyphs_map[? _ord];
            
            if (_source_glyph_data == undefined)
                __scribble_trace("Warning! Glyph ", _ord, " (", chr(_ord), ") not found in source font");
            else if (arg2 || !ds_map_exists(_target_glyphs_map, _ord))
                _target_glyphs_map[? _ord] = __scribble_glyph_duplicate(_source_glyph_data, _y_offset);
            
            _ord++;
        }
        
        _i++;
    }
}

function __scribble_font_collage_glyph_copy_common(arg0, arg1)
{
    if (arg0.msdf || arg1.msdf)
    {
        if (arg0.msdf == false)
            __scribble_error("Cannot mix standard/sprite fonts with MSDF fonts (target is not an MSDF font)");
        
        if (arg1.msdf == false)
            __scribble_error("Cannot mix standard/sprite fonts with MSDF fonts (source is not an MSDF font)");
        
        if (arg1.msdf_pxrange == undefined)
            __scribble_error("Source font's MSDF pxrange must be defined before copying glyphs");
        
        if (arg0.msdf_pxrange != undefined && arg0.msdf_pxrange != arg1.msdf_pxrange)
            __scribble_error("MSDF font pxrange must match (target = ", arg0.msdf_pxrange, " vs. source = ", arg1.msdf_pxrange, ")");
    }
    
    arg0.msdf = arg1.msdf;
    arg0.msdf_pxrange = arg1.msdf_pxrange;
    
    if (arg0.height > arg1.height)
        return (arg0.height - arg1.height) div 2;
    
    if (arg0.height < arg1.height)
    {
        var _glyphs_map = arg0.glyphs_map;
        
        if (ds_map_size(_glyphs_map) > 0)
        {
            var _y_offset = (arg1.height - arg0.height) div 2;
            var _glyphs_array = ds_map_values_to_array(_glyphs_map);
            var _i = 0;
            
            repeat (array_length(_glyphs_array))
            {
                array_set(array_get(_glyphs_array, _i), UnknownEnum.Value_5, array_get(array_get(_glyphs_array, _i), UnknownEnum.Value_5) + _y_offset);
                _i++;
            }
        }
        
        arg0.height = arg1.height;
    }
    
    return 0;
}
