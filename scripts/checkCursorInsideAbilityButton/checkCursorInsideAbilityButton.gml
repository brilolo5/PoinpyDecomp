function checkCursorInsideAbilityButton(arg0 = device_mouse_x_to_gui(0), arg1 = device_mouse_y_to_gui(0))
{
    var _wCenter = global.windowCenterx;
    var _wMiddle = global.windowMiddley;
    var _wLeft = global.windowLeft;
    var _wRight = global.windowRight;
    var _wTop = global.windowTop;
    var _wBottom = global.windowBottom;
    var _equipmentUIposx = _wLeft + 16 + 4;
    var _equipmentUIposy = (_wBottom - 24) + 4 + 2;
    var _equipmentUIwidth = 28 - (10 * (os_type == os_windows || os_type == os_macosx || os_type == os_linux));
    var _equipmentUIheight = 28 - (10 * (os_type == os_windows || os_type == os_macosx || os_type == os_linux));
    return inRectArea(arg0, arg1, _equipmentUIposx, _equipmentUIposy, _equipmentUIwidth, _equipmentUIheight);
}
