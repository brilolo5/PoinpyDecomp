function scribble_font_collage_clear(arg0)
{
    var _font_data = global.__scribble_font_data[? arg0];
    
    if (_font_data == undefined)
        __scribble_error("Font \"", arg0, "\" not found");
    
    _font_data.clear();
}
