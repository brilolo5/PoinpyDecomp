function surface_resize_track(arg0, arg1, arg2)
{
    trace("Resizing surface ", arg0, " (", surface_get_width(arg0), "x", surface_get_height(arg0), ") to ", arg1, "x", arg2);
    var _result = surface_resize(arg0, arg1, arg2);
    return _result;
}
