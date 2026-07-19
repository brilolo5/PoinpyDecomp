function __scribble_generator_position_glyphs()
{
    var _glyph_grid = global.__scribble_glyph_grid;
    var _word_grid = global.__scribble_word_grid;
    var _stretch_grid = global.__scribble_stretch_grid;
    var _line_grid = global.__scribble_line_grid;
    var _temp_grid = global.__scribble_temp_grid;
    var _model_max_width, _line_count, _overall_bidi;
    
    with (global.__scribble_generator_state)
    {
        _line_count = line_count;
        _overall_bidi = overall_bidi;
        _model_max_width = model_max_width;
    }
    
    var _alignment_width = (_model_max_width == infinity) ? width : _model_max_width;
    var _model_min_x = infinity;
    var _model_max_x = -infinity;
    var _model_glyph_count = 0;
    var _i = 0;
    
    repeat (_line_count)
    {
        var _line_word_start = _line_grid[# _i, UnknownEnum.Value_1];
        var _line_word_end = _line_grid[# _i, UnknownEnum.Value_2];
        
        if (_line_word_end < _line_word_start)
        {
            _i++;
        }
        else
        {
            var _line_y = _line_grid[# _i, UnknownEnum.Value_0];
            var _line_width = _line_grid[# _i, UnknownEnum.Value_3];
            var _line_height = _line_grid[# _i, UnknownEnum.Value_4];
            var _line_halign = _line_grid[# _i, UnknownEnum.Value_5];
            var _line_glyph_start = _word_grid[# _line_word_start, UnknownEnum.Value_0];
            var _line_glyph_end = _word_grid[# _line_word_end, UnknownEnum.Value_1];
            var _line_glyph_count = (1 + _line_glyph_end) - _line_glyph_start;
            ds_grid_set_grid_region(_temp_grid, _glyph_grid, _line_glyph_start, UnknownEnum.Value_3, _line_glyph_end, UnknownEnum.Value_3, 0, 0);
            ds_grid_multiply_region(_temp_grid, 0, 0, _line_glyph_count - 1, 0, -0.5);
            ds_grid_add_region(_temp_grid, 0, 0, _line_glyph_count - 1, 0, (0.5 * _line_height) + _line_y);
            ds_grid_set_grid_region(_glyph_grid, _temp_grid, 0, 0, _line_glyph_count - 1, 0, _line_glyph_start, UnknownEnum.Value_1);
            var _line_stretch_count = 0;
            var _stretch_bidi = undefined;
            var _j = _line_word_start;
            
            repeat ((1 + _line_word_end) - _line_word_start)
            {
                var _word_bidi = _word_grid[# _j, UnknownEnum.Value_5];
                
                if (_word_bidi != _stretch_bidi)
                {
                    if (_line_stretch_count > 0)
                        _stretch_grid[# _line_stretch_count - 1, UnknownEnum.Value_1] = _j - 1;
                    
                    _stretch_grid[# _line_stretch_count, UnknownEnum.Value_0] = _j;
                    _stretch_grid[# _line_stretch_count, UnknownEnum.Value_2] = _word_bidi;
                    _line_stretch_count++;
                    _stretch_bidi = _word_bidi;
                }
                
                _j++;
            }
            
            if (_line_stretch_count > 0)
                _stretch_grid[# _line_stretch_count - 1, UnknownEnum.Value_1] = _j - 1;
            
            if (_line_halign == 6 && _i >= (_line_count - 1))
                _line_halign = 3;
            
            var _glyph_index = 0;
            var _glyph_x;
            
            switch (_line_halign)
            {
                case 0:
                    if (_overall_bidi != UnknownEnum.Value_4)
                        _glyph_x = 0;
                    else
                        _glyph_x = width - _line_width;
                    
                    break;
                
                case 3:
                    if (_overall_bidi != UnknownEnum.Value_4)
                        _glyph_x = 0;
                    else
                        _glyph_x = _alignment_width - _line_width;
                    
                    break;
                
                case 1:
                    _glyph_x = -(_line_width div 2);
                    break;
                
                case 2:
                    _glyph_x = -_line_width;
                    break;
                
                case 4:
                    _glyph_x = (_alignment_width - _line_width) div 2;
                    break;
                
                case 5:
                    _glyph_x = _alignment_width - _line_width;
                    break;
                
                case 6:
                    _glyph_x = 0;
                    break;
            }
            
            var _justification_extra_spacing = 0;
            
            if (_line_halign == 6)
            {
                var _line_word_count = (1 + _line_word_end) - _line_word_start;
                
                if (_line_word_count > 1)
                    _justification_extra_spacing = (_alignment_width - _line_width) / (_line_word_count - 1);
            }
            
            _model_min_x = min(_model_min_x, _glyph_x);
            _model_max_x = max(_model_max_x, _glyph_x + _line_width);
            var _stretch_incr;
            
            if (_overall_bidi != UnknownEnum.Value_4)
            {
                _j = 0;
                _stretch_incr = 1;
            }
            else
            {
                _j = _line_stretch_count - 1;
                _stretch_incr = -1;
            }
            
            repeat (_line_stretch_count)
            {
                var _stretch_word_start = _stretch_grid[# _j, UnknownEnum.Value_0];
                var _stretch_word_end = _stretch_grid[# _j, UnknownEnum.Value_1];
                _stretch_bidi = _stretch_grid[# _j, UnknownEnum.Value_2];
                var _k, _word_incr;
                
                if (_stretch_bidi != UnknownEnum.Value_4)
                {
                    _k = _stretch_word_start;
                    _word_incr = 1;
                }
                else
                {
                    _k = _stretch_word_end;
                    _word_incr = -1;
                }
                
                repeat ((1 + _stretch_word_end) - _stretch_word_start)
                {
                    var _word_glyph_start = _word_grid[# _k, UnknownEnum.Value_0];
                    var _word_glyph_end = _word_grid[# _k, UnknownEnum.Value_1];
                    ds_grid_add_region(_glyph_grid, _word_glyph_start, UnknownEnum.Value_0, _word_glyph_end, UnknownEnum.Value_0, _glyph_x);
                    _glyph_x += _word_grid[# _k, UnknownEnum.Value_2];
                    _k += _word_incr;
                }
                
                _j += _stretch_incr;
            }
            
            _model_glyph_count += _glyph_index;
            _i++;
        }
    }
    
    if (_model_min_x == infinity)
        _model_min_x = 0;
    
    characters = _model_glyph_count;
    min_x = _model_min_x;
    max_x = max(_model_min_x, _model_max_x);
    width = (1 + max_x) - min_x;
}
