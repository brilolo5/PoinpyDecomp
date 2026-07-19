function roomYToGui(arg0)
{
    return global.windowTop + (((global.windowBottom - global.windowTop) * (arg0 - getViewy(global.cam))) / getViewh(global.cam));
}

function guiYToRoom(arg0)
{
    return getViewy(global.cam) + arg0;
}
