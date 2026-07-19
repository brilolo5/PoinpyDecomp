function getViewh(arg0)
{
    if (global.cam != -1)
        return camera_get_view_height(arg0);
    else
        return 0;
}
