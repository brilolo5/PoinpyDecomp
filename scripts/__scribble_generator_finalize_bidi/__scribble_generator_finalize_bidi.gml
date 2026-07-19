function __scribble_generator_finalize_bidi()
{
    var _word_grid = global.__scribble_word_grid;
    var _word_count = global.__scribble_generator_state.word_count;
    var _overall_bidi = global.__scribble_generator_state.overall_bidi;
    var _i = 0;
    
    repeat (_word_count)
    {
        var _bidi = _word_grid[# _i, UnknownEnum.Value_4];
        
        if (_bidi == UnknownEnum.Value_1 || _bidi == UnknownEnum.Value_0)
        {
            var _prev_bidi = (_i > 0) ? _word_grid[# _i - 1, UnknownEnum.Value_5] : UnknownEnum.Value_1;
            var _next_bidi = (_i < (_word_count - 1)) ? _word_grid[# _i + 1, UnknownEnum.Value_5] : UnknownEnum.Value_1;
            
            if (_prev_bidi == UnknownEnum.Value_1 || _prev_bidi == UnknownEnum.Value_0)
                _prev_bidi = _next_bidi;
            
            if (_next_bidi == UnknownEnum.Value_1 || _next_bidi == UnknownEnum.Value_0)
                _next_bidi = _prev_bidi;
            
            var _new_bidi = (_prev_bidi == _overall_bidi || _next_bidi == _overall_bidi) ? _overall_bidi : _prev_bidi;
            
            if (_new_bidi == UnknownEnum.Value_1 || _new_bidi == UnknownEnum.Value_0)
                _new_bidi = UnknownEnum.Value_3;
            
            _word_grid[# _i, UnknownEnum.Value_5] = _new_bidi;
            _bidi = _new_bidi;
        }
        
        _i++;
    }
}
