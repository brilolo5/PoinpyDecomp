function __scribble_generator_build_lines()
{
    var _word_grid = global.__scribble_word_grid;
    var _line_grid = global.__scribble_line_grid;
    var _control_grid = global.__scribble_control_grid;
    var _model_max_width, _model_max_height, _word_count, _line_height_min, _line_height_max, _wrap_no_pages, _wrap_max_scale;
    
    with (global.__scribble_generator_state)
    {
        var _element = element;
        _word_count = word_count;
        _line_height_min = line_height_min;
        _line_height_max = line_height_max;
        _model_max_width = model_max_width;
        _model_max_height = model_max_height;
        _wrap_no_pages = _element.wrap_no_pages;
        _wrap_max_scale = _element.wrap_max_scale;
    }
    
    var _fit_to_box_iterations = 0;
    var _lower_limit = undefined;
    var _upper_limit = undefined;
    var _line_count;
    
    repeat (8)
    {
        var _state_halign = 0;
        var _control_index = 0;
        var _line_y = 0;
        _line_count = 0;
        var _line_word_start = 0;
        var _word_x = 0;
        var _simulated_model_max_width = _model_max_width / fit_scale;
        var _simulated_model_max_height = _model_max_height / fit_scale;
        var _next_control_pos = _control_grid[# 0, UnknownEnum.Value_2];
        var _force_break = false;
        var _i = 0;
        
        repeat (_word_count)
        {
            var _word_width = _word_grid[# _i, UnknownEnum.Value_2];
            var _word_start_glyph = _word_grid[# _i, UnknownEnum.Value_0];
            
            while (_word_start_glyph == _next_control_pos)
            {
                switch (_control_grid[# _control_index, UnknownEnum.Value_0])
                {
                    case -3:
                        if (_i != _line_word_start)
                            _force_break = true;
                        
                        _state_halign = _control_grid[# _control_index, UnknownEnum.Value_1];
                        break;
                }
                
                _control_index++;
                _next_control_pos = _control_grid[# _control_index, UnknownEnum.Value_2];
            }
            
            if (_word_grid[# _i, UnknownEnum.Value_5] == UnknownEnum.Value_2)
                _force_break = true;
            
            if (!_force_break && (_word_x + _word_width) < _simulated_model_max_width)
            {
                _word_x += _word_grid[# _i, UnknownEnum.Value_2];
            }
            else
            {
                _force_break = false;
                var _line_word_end = _i - 1;
                var _line_height = clamp(ds_grid_get_max(_word_grid, _line_word_start, UnknownEnum.Value_3, _line_word_end, UnknownEnum.Value_3), _line_height_min, _line_height_max);
                _line_grid[# _line_count, UnknownEnum.Value_1] = _line_word_start;
                _line_grid[# _line_count, UnknownEnum.Value_2] = _line_word_end;
                _line_grid[# _line_count, UnknownEnum.Value_3] = _word_x;
                _line_grid[# _line_count, UnknownEnum.Value_4] = _line_height;
                _line_grid[# _line_count, UnknownEnum.Value_5] = _state_halign;
                _line_grid[# _line_count, UnknownEnum.Value_6] = _control_index - 1;
                _line_count++;
                _line_y += _line_height;
                _line_word_start = _i;
                _word_x = is_infinity(_word_width) ? 0 : _word_width;
            }
            
            _i++;
        }
        
        if (_line_word_start != (_i - 1) || _word_grid[# _line_word_start, UnknownEnum.Value_4] != UnknownEnum.Value_0)
        {
            var _line_word_end = _i - 1;
            var _line_height = clamp(ds_grid_get_max(_word_grid, _line_word_start, UnknownEnum.Value_3, _line_word_end, UnknownEnum.Value_3), _line_height_min, _line_height_max);
            _line_grid[# _line_count, UnknownEnum.Value_1] = _line_word_start;
            _line_grid[# _line_count, UnknownEnum.Value_2] = _line_word_end;
            _line_grid[# _line_count, UnknownEnum.Value_3] = _word_x;
            _line_grid[# _line_count, UnknownEnum.Value_4] = clamp(ds_grid_get_max(_word_grid, _line_word_start, UnknownEnum.Value_3, _line_word_end, UnknownEnum.Value_3), _line_height_min, _line_height_max);
            _line_grid[# _line_count, UnknownEnum.Value_5] = _state_halign;
            _line_grid[# _line_count, UnknownEnum.Value_6] = _control_index - 1;
            _line_count++;
            _line_y += _line_height;
        }
        
        if (!_wrap_no_pages || false)
            break;
        
        _fit_to_box_iterations++;
        
        if (_line_y < _simulated_model_max_height)
        {
            if (fit_scale >= _wrap_max_scale)
                break;
            
            _lower_limit = fit_scale;
        }
        else
        {
            _upper_limit = fit_scale;
        }
        
        if (_fit_to_box_iterations >= 7)
        {
            if (fit_scale == _lower_limit)
                break;
            
            fit_scale = _lower_limit;
        }
        else if (_lower_limit == undefined)
        {
            fit_scale *= 0.5;
        }
        else if (_upper_limit == undefined)
        {
            fit_scale = min(_wrap_max_scale, 2 * fit_scale);
        }
        else
        {
            fit_scale = _lower_limit + (0.5 * (_upper_limit - _lower_limit));
        }
    }
    
    width = ds_grid_get_max(_line_grid, 0, UnknownEnum.Value_3, _line_count - 1, UnknownEnum.Value_3);
    
    with (global.__scribble_generator_state)
    {
        word_count = _word_count;
        line_count = _line_count;
    }
}
