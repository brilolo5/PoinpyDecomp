function getVieww(arg0)
{
    if (global.cam != -1)
        return camera_get_view_width(arg0);
    else
        return 0;
}
