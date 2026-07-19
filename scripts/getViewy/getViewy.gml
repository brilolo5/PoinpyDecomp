function getViewy(arg0 = global.cam)
{
    if (global.cam != -1)
        return camera_get_view_y(arg0);
    else
        return 0;
}
