function scribble_rgb_to_bgr(arg0)
{
    var _msb = arg0 >> 24;
    return make_colour_rgb(colour_get_blue(arg0), colour_get_green(arg0), colour_get_red(arg0)) | (_msb << 24);
}
