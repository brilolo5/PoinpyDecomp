function __scribble_generator_build_words()
{
    var _glyph_grid = global.__scribble_glyph_grid;
    var _word_grid = global.__scribble_word_grid;
    var _control_grid = global.__scribble_control_grid;
    var _glyph_count, _overall_bidi, _wrap_per_char;
    
    with (global.__scribble_generator_state)
    {
        var _element = element;
        _glyph_count = glyph_count;
        _overall_bidi = overall_bidi;
        _wrap_per_char = _element.wrap_per_char;
    }
    
    var _word_index = -1;
    var _word_glyph_start = 0;
    var _word_glyph_end = undefined;
    var _word_width = undefined;
    var _word_bidi = undefined;
    var _glyph_prev_whitespace = undefined;
    var _i = 0;
    
    repeat (_glyph_count + 1)
    {
        var _glyph_bidi_raw = _glyph_grid[# _i, UnknownEnum.Value_17];
        var _glyph_bidi = _glyph_bidi_raw;
        var _new_word = false;
        
        switch (_glyph_bidi)
        {
            case UnknownEnum.Value_0:
                if (_word_bidi == undefined || _word_bidi == _overall_bidi)
                    _glyph_bidi = _overall_bidi;
                
                _glyph_prev_whitespace = true;
                break;
            
            case UnknownEnum.Value_1:
                if (_word_bidi != UnknownEnum.Value_0 && _word_bidi != undefined)
                    _glyph_bidi = _word_bidi;
                
                if (_glyph_bidi == UnknownEnum.Value_3 || _glyph_bidi == UnknownEnum.Value_4)
                {
                    _word_bidi = _glyph_bidi;
                    _word_grid[# _word_index, UnknownEnum.Value_4] = _glyph_bidi;
                    _word_grid[# _word_index, UnknownEnum.Value_5] = _glyph_bidi;
                }
                
                break;
            
            case UnknownEnum.Value_2:
                _new_word = true;
                break;
        }
        
        if (_glyph_bidi != _word_bidi || _i == _glyph_count)
            _new_word = true;
        
        if (_glyph_bidi_raw != UnknownEnum.Value_0 && _glyph_prev_whitespace)
        {
            _new_word = true;
            _glyph_prev_whitespace = false;
        }
        
        if (_wrap_per_char && _glyph_bidi_raw != UnknownEnum.Value_1)
            _new_word = true;
        
        if (_new_word)
        {
            if (_word_index >= 0)
            {
                _word_glyph_end = _i - 1;
                
                if (_word_bidi == UnknownEnum.Value_4)
                {
                    ds_grid_add_region(_glyph_grid, _word_glyph_start, UnknownEnum.Value_0, _word_glyph_end, UnknownEnum.Value_0, abs(_word_width));
                    ds_grid_set_region(_glyph_grid, _word_glyph_start, UnknownEnum.Value_5, _word_glyph_end, UnknownEnum.Value_5, _word_glyph_start);
                }
                
                _word_grid[# _word_index, UnknownEnum.Value_1] = _word_glyph_end;
                _word_grid[# _word_index, UnknownEnum.Value_2] = abs(_word_width);
                _word_grid[# _word_index, UnknownEnum.Value_3] = ds_grid_get_max(_glyph_grid, _word_glyph_start, UnknownEnum.Value_3, _word_glyph_end, UnknownEnum.Value_3);
                
                if (_i == _glyph_count)
                    break;
            }
            
            _word_index++;
            _word_glyph_start = _i;
            _word_bidi = _glyph_bidi;
            _word_width = 0;
            _word_grid[# _word_index, UnknownEnum.Value_0] = _word_glyph_start;
            _word_grid[# _word_index, UnknownEnum.Value_4] = _word_bidi;
            _word_grid[# _word_index, UnknownEnum.Value_5] = _word_bidi;
        }
        
        if (_word_bidi != UnknownEnum.Value_4)
        {
            _glyph_grid[# _i, UnknownEnum.Value_0] = _word_width;
            _word_width += _glyph_grid[# _i, UnknownEnum.Value_8];
            _glyph_grid[# _i, UnknownEnum.Value_5] = _i;
        }
        else
        {
            _word_width -= _glyph_grid[# _i, UnknownEnum.Value_8];
            _glyph_grid[# _i, UnknownEnum.Value_0] = _word_width;
        }
        
        _i++;
    }
    
    _word_index++;
    _word_grid[# _word_index, UnknownEnum.Value_0] = _glyph_count;
    _word_grid[# _word_index, UnknownEnum.Value_1] = _glyph_count;
    _word_grid[# _word_index, UnknownEnum.Value_2] = 0;
    _word_grid[# _word_index, UnknownEnum.Value_3] = 0;
    _word_grid[# _word_index, UnknownEnum.Value_4] = UnknownEnum.Value_1;
    _word_grid[# _word_index, UnknownEnum.Value_5] = UnknownEnum.Value_1;
    
    with (global.__scribble_generator_state)
        word_count = _word_index;
}
