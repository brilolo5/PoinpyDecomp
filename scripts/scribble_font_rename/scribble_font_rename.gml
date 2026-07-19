function scribble_font_rename(arg0, arg1)
{
    var _data = global.__scribble_font_data[? arg0];
    global.__scribble_font_data[? arg1] = _data;
    ds_map_delete(global.__scribble_font_data, arg0);
    
    if (global.__scribble_default_font == arg0)
        global.__scribble_default_font = arg1;
}
