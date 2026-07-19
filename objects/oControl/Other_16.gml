if (live_call())
    return global.live_result;

var _wCenter = global.windowCenterx;
var _wMiddle = global.windowMiddley;
var _wLeft = global.windowLeft;
var _wRight = global.windowRight;
var _wTop = global.windowTop + 3;
var _wBottom = global.windowBottom;
var viewx = getViewx(global.cam);
var xcenter = global.windowCenterx;
var xLeft = xcenter - ((global.viewWidth / 4) + 5);
var xRight = xcenter + ((global.viewWidth / 4) + 4);
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
drawSetAlign(1, 1);

if (((os_type == os_ios || os_type == os_android) || 1) && global.allowPauseMenu)
    pauseButtonAlpha = deltaLerp(pauseButtonAlpha, 1, 0.5);
else
    pauseButtonAlpha = deltaLerp(pauseButtonAlpha, 0, 0.25);

texture_set_interpolation(false);
pauseButtonX = _wLeft + 8 + 1.5;
pauseButtonY = _wTop + 8 + 2 + global.notchOffset;

if (guiCursorInRange(pauseButtonX, pauseButtonY, 8) && (os_type == os_windows || os_type == os_macosx || os_type == os_linux))
    pauseButtonScale = deltaLerp(pauseButtonScale, 1.15, 0.5);
else
    pauseButtonScale = deltaLerp(pauseButtonScale, 1, 0.25);

var _pauseButtonScale = 0.1 * pauseButtonScale;
draw_sprite_ext(sUIpauseButton, 0, pauseButtonX, pauseButtonY, _pauseButtonScale, _pauseButtonScale, 0, c_white, pauseButtonAlpha);
texture_set_interpolation(true);

if (room == rmPlayableMainMenu)
{
    if (global.mainGamePaused != 1 && !instance_exists(oEndCredit))
    {
        var _equipmentUIposx = _wLeft + 16 + 4;
        var _equipmentUIposy = (_wBottom - 24) + 4 + 2;
        var _equipmentUIwidth = 28;
        var _equipmentUIheight = 28;
        var _equipmentUIleft = _equipmentUIposx - (_equipmentUIwidth / 2);
        var _equipmentUIright = _equipmentUIleft + _equipmentUIwidth;
        var _equipmentUItop = _equipmentUIposy - (_equipmentUIheight / 2);
        var _equipmentUIbottom = _equipmentUItop + _equipmentUIheight;
        draw_set_color(make_color_rgb(255, 255, 255));
        var _equipmentUIsprite = sUIequipmentCollectionBox;
        var _equipmentUIspriteWidth = sprite_get_width(_equipmentUIsprite);
        var _equipmentUIspriteHeight = sprite_get_height(_equipmentUIsprite);
        _equipmentUIspriteWidth = _equipmentUIwidth / _equipmentUIspriteWidth;
        _equipmentUIspriteHeight = _equipmentUIheight / _equipmentUIspriteHeight;
        var _equipButtonAvailable = 1;
        var _equipButtonAlpha = 1;
        
        if (_equipButtonAvailable)
            equipUIposx = lerp(equipUIposx, _equipmentUIposx, 0.5);
        else
            _equipButtonAlpha = 0.5;
        
        if (global.juicerRankProgress <= 0)
        {
            _equipButtonAvailable = 0;
            _equipButtonAlpha = 0;
        }
        
        if (checkCursorInsideAbilityButton() && (os_type == os_windows || os_type == os_macosx || os_type == os_linux))
            equipButtonScale = deltaLerp(equipButtonScale, 1.15, 0.5);
        else
            equipButtonScale = deltaLerp(equipButtonScale, 1, 0.25);
        
        var _equipButtonScale = (equipButtonScale * 1) / 10;
        draw_sprite_ext(_equipmentUIsprite, 0, equipUIposx, _equipmentUIposy, _equipButtonScale, _equipButtonScale, 0, c_white, _equipButtonAlpha);
        
        if (global.notif_equipment)
            draw_sprite_ext(_equipmentUIsprite, 1, equipUIposx, _equipmentUIposy, _equipButtonScale, _equipButtonScale, 0, c_white, _equipButtonAlpha);
        
        if (mouse_check_button_pressed(mb_left))
        {
            mouseTapRecordx = _mx;
            mouseTapRecordy = _my;
        }
        
        if (_equipButtonAvailable && !getPlayerControlLock())
        {
            if (input_check_released("ability equip") && input_player_source_get() == UnknownEnum.Value_2)
            {
                global.playerControlLock = 1;
                instance_create_depth(x, y, 0, oAbilityEquipMenu);
            }
            else if (input_check_released("select") && input_player_source_get() != UnknownEnum.Value_2)
            {
                if (mouseUIheldCount < 10)
                {
                    if (checkCursorInsideAbilityButton() && checkCursorInsideAbilityButton(mouseTapRecordx, mouseTapRecordy))
                    {
                        global.playerControlLock = 1;
                        instance_create_depth(x, y, 0, oAbilityEquipMenu);
                    }
                }
            }
        }
    }
}

if (mouse_check_button(mb_left))
    mouseUIheldCount += 1;
else
    mouseUIheldCount = 0;
