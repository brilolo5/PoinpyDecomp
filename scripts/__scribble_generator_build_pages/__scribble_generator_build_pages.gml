function __scribble_generator_build_pages()
{
    var _glyph_grid = global.__scribble_glyph_grid;
    var _word_grid = global.__scribble_word_grid;
    var _line_grid = global.__scribble_line_grid;
    var _control_grid = global.__scribble_control_grid;
    var _model_max_height, _line_count, _wrap_no_pages, _control_count;
    
    with (global.__scribble_generator_state)
    {
        var _element = element;
        _model_max_height = model_max_height;
        _line_count = line_count;
        _control_count = control_count;
        _wrap_no_pages = _element.wrap_no_pages;
    }
    
    var _simulated_model_height = _model_max_height / fit_scale;
    var _model_height = 0;
    var _page_data = __new_page();
    _page_data.__glyph_start = _word_grid[# ds_grid_get(_line_grid, 0, UnknownEnum.Value_1), UnknownEnum.Value_0];
    
    if (_line_count <= 0)
    {
        _page_data.__glyph_end = _page_data.__glyph_start;
    }
    else
    {
        var _page_start_line = 0;
        var _line_y = 0;
        var _i = 0;
        
        repeat (_line_count)
        {
            var _line_height = _line_grid[# _i, UnknownEnum.Value_4];
            
            if (_i <= _page_start_line || _wrap_no_pages || (_line_y + _line_height) < _simulated_model_height)
            {
                _line_grid[# _i, UnknownEnum.Value_0] = _line_y;
                _line_y += _line_height;
            }
            else
            {
                _page_data.__glyph_end = _word_grid[# ds_grid_get(_line_grid, _i - 1, UnknownEnum.Value_2), UnknownEnum.Value_1];
                _page_char_start = _glyph_grid[# _page_data.__glyph_start, UnknownEnum.Value_5];
                ds_grid_add_region(_glyph_grid, _page_data.__glyph_start, UnknownEnum.Value_5, _page_data.__glyph_end, UnknownEnum.Value_5, -_page_char_start);
                _page_data.__character_count = 1 + _glyph_grid[# _page_data.__glyph_end, UnknownEnum.Value_5];
                _line_grid[# _i, UnknownEnum.Value_0] = 0;
                _line_y = _line_height;
                _page_start_line = _i;
                
                if (is_infinity(_line_height))
                {
                    __scribble_error("Manual page breaks not implemented yet");
                }
                else
                {
                    _page_data = __new_page();
                    _page_data.__glyph_start = _word_grid[# ds_grid_get(_line_grid, _i, UnknownEnum.Value_1), UnknownEnum.Value_0];
                    ds_grid_add_region(_control_grid, _line_grid[# _i - 1, UnknownEnum.Value_6], UnknownEnum.Value_3, _control_count - 1, UnknownEnum.Value_3, 1);
                }
            }
            
            _model_height = max(_model_height, _line_y);
            _i++;
        }
        
        _page_data.__glyph_end = _word_grid[# ds_grid_get(_line_grid, _i - 1, UnknownEnum.Value_2), UnknownEnum.Value_1];
        var _page_char_start = _glyph_grid[# _page_data.__glyph_start, UnknownEnum.Value_5];
        ds_grid_add_region(_glyph_grid, _page_data.__glyph_start, UnknownEnum.Value_5, _page_data.__glyph_end, UnknownEnum.Value_5, -_page_char_start);
        _page_data.__character_count = 1 + _glyph_grid[# _page_data.__glyph_end, UnknownEnum.Value_5];
    }
    
    height = _model_height;
}
