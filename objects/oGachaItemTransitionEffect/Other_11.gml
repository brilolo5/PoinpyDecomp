var _mousex = device_mouse_x_to_gui(0);
var _mousey = device_mouse_y_to_gui(0);
var _wCenter = global.windowCenterx;
var _wMiddle = global.windowMiddley;
var _wLeft = global.windowLeft;
var _wRight = global.windowRight;
var _wTop = global.windowTop;
var _wBottom = global.windowBottom;
ysp += grav;
gx += xsp;
gy += ysp;
drawSpriteSetSize(sprite_index, 0, gx, gy, 32, 32);

if (gy > (_wBottom - 32))
{
    global.notif_equipment = 1;
    instance_destroy();
}
