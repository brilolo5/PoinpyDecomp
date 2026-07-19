function surface_create_track(arg0, arg1)
{
    trace("Creating surface ", arg0, "x", arg1, "          ", debug_get_callstack());
    var _surface = surface_create(arg0, arg1);
    return _surface;
}
