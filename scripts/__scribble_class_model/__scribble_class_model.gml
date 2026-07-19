function __scribble_class_model(arg0, arg1) constructor
{
    static draw = function(arg0, arg1, arg2, arg3)
    {
        if (flushed)
            return undefined;
        
        if (arg2 == undefined)
            return undefined;
        
        last_drawn = current_time;
        var _page_data = pages_array[arg2.__page];
        var _model_w = width;
        var _model_h = height;
        var _xscale, _yscale, _x_offset, _y_offset, _angle;
        
        with (arg2)
        {
            __update_scale_to_box_scale();
            _x_offset = -origin_x;
            _y_offset = -origin_y;
            _xscale = xscale * scale_to_box_scale;
            _yscale = yscale * scale_to_box_scale;
            _angle = angle;
        }
        
        _xscale *= fit_scale;
        _yscale *= fit_scale;
        var _left = _x_offset;
        var _top = _y_offset;
        
        if (valign == 1)
            _top -= (_model_h div 2);
        
        if (valign == 2)
            _top -= _model_h;
        
        var _old_matrix = matrix_get(2);
        
        if (_xscale == 1 && _yscale == 1 && _angle == 0)
        {
            _matrix = matrix_build(_left + arg0, _top + arg1, 0, 0, 0, 0, 1, 1, 1);
        }
        else
        {
            _matrix = matrix_build(_left, _top, 0, 0, 0, 0, 1, 1, 1);
            _matrix = matrix_multiply(_matrix, matrix_build(arg0, arg1, 0, 0, 0, _angle, _xscale, _yscale, 1));
        }
        
        var _matrix = matrix_multiply(_matrix, _old_matrix);
        matrix_set(2, _matrix);
        _page_data.__submit(arg2, arg3);
        matrix_set(2, _old_matrix);
    };
    
    static flush = function()
    {
        if (flushed)
            return undefined;
        
        reset();
        ds_map_delete(global.__scribble_mcache_dict, cache_name);
        flushed = true;
    };
    
    static reset = function()
    {
        var _i = 0;
        
        repeat (array_length(pages_array))
        {
            pages_array[_i].__flush();
            _i++;
        }
        
        characters = 0;
        lines = 0;
        pages = 0;
        width = 0;
        height = 0;
        min_x = 0;
        max_x = 0;
        valign = undefined;
        fit_scale = 1;
        pages_array = [];
        character_array = undefined;
        glyph_ltrb_array = undefined;
    };
    
    static get_bbox = function(arg0)
    {
        if (arg0 != undefined && arg0 >= 0)
        {
            var _page_data = pages_array[arg0];
            return 
            {
                left: _page_data.min_x,
                top: 0,
                right: _page_data.max_x,
                bottom: _page_data.height,
                width: _page_data.width,
                height: _page_data.height
            };
        }
        else
        {
            return 
            {
                left: min_x,
                top: 0,
                right: max_x,
                bottom: height,
                width: width,
                height: height
            };
        }
    };
    
    static get_width = function(arg0)
    {
        if (arg0 != undefined && arg0 >= 0)
            return fit_scale * pages_array[arg0].width;
        else
            return fit_scale * width;
    };
    
    static get_height = function(arg0)
    {
        if (arg0 != undefined && arg0 >= 0)
            return fit_scale * pages_array[arg0].height;
        else
            return fit_scale * height;
    };
    
    static get_page_array = function()
    {
        return pages_array;
    };
    
    static get_pages = function()
    {
        return pages;
    };
    
    static get_page_height = function(arg0)
    {
        if (arg0 == undefined || arg0 < 0)
            arg0 = 0;
        
        return pages_array[arg0].height;
    };
    
    static get_page_width = function(arg0)
    {
        if (arg0 == undefined || arg0 < 0)
            arg0 = 0;
        
        return pages_array[arg0].width;
    };
    
    static get_wrapped = function()
    {
        return wrapped;
    };
    
    static get_line_count = function(arg0)
    {
        if (arg0 == undefined || arg0 < 0)
            arg0 = 0;
        
        return pages_array[arg0].lines;
    };
    
    static get_ltrb_array = function()
    {
        __scribble_error("SCRIBBLE_CREATE_GLYPH_LTRB_ARRAY is not enabled\nPlease set this macro to <true> to use this function");
        return [];
        return glyph_ltrb_array;
    };
    
    static __new_page = function()
    {
        var _page_data = new __scribble_class_page();
        array_set(pages_array, pages, _page_data);
        pages++;
        return _page_data;
    };
    
    static __finalize_vertex_buffers = function(arg0)
    {
        var _i = 0;
        
        repeat (array_length(pages_array))
        {
            pages_array[_i].__finalize_vertex_buffers(arg0);
            _i++;
        }
    };
    
    cache_name = arg1;
    var _weak = global.__scribble_mcache_dict[? cache_name];
    
    if (_weak != undefined && weak_ref_alive(_weak) && !_weak.ref.flushed)
    {
        __scribble_trace("Warning! Rebuilding model \"", cache_name, "\"");
        _weak.ref.flush();
    }
    
    global.__scribble_mcache_dict[? cache_name] = weak_ref_create(self);
    ds_list_add(global.__scribble_mcache_name_list, cache_name);
    last_drawn = current_time;
    flushed = false;
    uses_standard_font = false;
    uses_msdf_font = false;
    characters = 0;
    lines = 0;
    pages = 0;
    width = 0;
    height = 0;
    min_x = 0;
    max_x = 0;
    valign = undefined;
    fit_scale = 1;
    wrapped = false;
    has_arabic = false;
    has_thai = false;
    pages_array = [];
    character_array = undefined;
    glyph_ltrb_array = undefined;
    
    with (global.__scribble_generator_state)
    {
        element = arg0;
        glyph_count = 0;
        control_count = 0;
        word_count = 0;
        line_count = 0;
        line_height_min = 0;
        line_height_max = 0;
        model_max_width = 0;
        model_max_height = 0;
        overall_bidi = arg0.__bidi_hint;
        bezier_lengths_array = undefined;
    }
    
    __scribble_generator_model_limits_and_bezier_curves();
    __scribble_generator_line_heights();
    __scribble_generator_parser();
    __scribble_generator_determine_overall_bidi();
    __scribble_generator_build_words();
    __scribble_generator_finalize_bidi();
    __scribble_generator_build_lines();
    __scribble_generator_build_pages();
    __scribble_generator_position_glyphs();
    __scribble_generator_write_vbuffs();
    ds_grid_clear(global.__scribble_control_grid, 0);
}
