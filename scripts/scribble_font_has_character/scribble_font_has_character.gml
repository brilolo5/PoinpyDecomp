function scribble_font_has_character(arg0, arg1)
{
    return ds_map_exists(__scribble_get_font_data(arg0).glyphs_map, ord(arg1));
}
