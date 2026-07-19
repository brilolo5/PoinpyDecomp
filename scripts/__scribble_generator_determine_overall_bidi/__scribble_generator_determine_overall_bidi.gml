function __scribble_generator_determine_overall_bidi()
{
    var _glyph_grid = global.__scribble_glyph_grid;
    var _glyph_count = global.__scribble_generator_state.glyph_count;
    var _overall_bidi = global.__scribble_generator_state.overall_bidi;
    
    if (_overall_bidi != UnknownEnum.Value_3 && _overall_bidi != UnknownEnum.Value_4)
    {
        _overall_bidi = _glyph_grid[# 0, UnknownEnum.Value_17];
        
        if (_overall_bidi != UnknownEnum.Value_3 && _overall_bidi != UnknownEnum.Value_4)
        {
            var _i = 0;
            
            repeat (_glyph_count)
            {
                var _bidi = _glyph_grid[# _i, UnknownEnum.Value_17];
                
                if (_bidi != UnknownEnum.Value_1 && _bidi != UnknownEnum.Value_0)
                {
                    _overall_bidi = _bidi;
                    break;
                }
                
                _i++;
            }
            
            if (_overall_bidi != UnknownEnum.Value_3 && _overall_bidi != UnknownEnum.Value_4)
                _overall_bidi = UnknownEnum.Value_3;
        }
    }
    
    global.__scribble_generator_state.overall_bidi = _overall_bidi;
}
