function roomXToGui(arg0)
{
    return global.windowLeft + (((global.windowRight - global.windowLeft) * (arg0 - getViewx(global.cam))) / getVieww(global.cam));
}

function guiXToRoom(arg0)
{
    return getViewx(global.cam) + arg0;
}
