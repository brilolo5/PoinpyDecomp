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

if (!instance_exists(oAbilityEquipMenu) && !instance_exists(oShopMenu) && !instance_exists(oPuzzleMenu) && !instance_exists(oLeaderboardsMenu) && !instance_exists(parentEnding))
{
    var _colRed = make_color_rgb(248, 45, 97);
    _hpPosx = _wLeft + 8 + 4;
    _hpPosy = global.notchOffset + _wTop + 16 + 4 + 12;
    _hpOffsetByx = 12;
    _hpOffsetByy = 0;
    var _heartScale = 0.09;
    _heartScale = 0.1;
    var _hpPosyFinal = _hpPosy - 8;
    
    for (var i = 0; i < global.lifePoint; i += 1)
    {
        draw_sprite_ext(sUIheart, 0, _hpPosx + (i * _hpOffsetByx), _hpPosyFinal + ((i - 1) * _hpOffsetByy), _heartScale, _heartScale, 0, make_color_rgb(248, 45, 97), 1);
        draw_sprite_ext(sUIheart, 1, _hpPosx + (i * _hpOffsetByx), _hpPosyFinal + ((i - 1) * _hpOffsetByy), _heartScale, _heartScale, 0, c_white, 1);
    }
    
    if (global.rescueLife > 0)
    {
        var _cr = global.surfaceCompressionRate;
        var _heartWidth = sprite_get_width(sUIheart) * _heartScale * _cr;
        var _heartHeight = sprite_get_height(sUIheart) * _heartScale * _cr;
        
        if (!surface_exists(rescueHeartSurface))
            rescueHeartSurface = surface_create_track(_heartWidth, _heartHeight);
        
        surface_set_target(rescueHeartSurface);
        draw_clear_alpha(c_white, 0);
        draw_clear(make_color_rgb(69, 80, 97));
        var _pieVal = global.rescueLife;
        var _pieCol = make_color_rgb(176, 183, 195);
        var _rescueHeartScale = 1 / _cr;
        
        if (room == rmMainGame && !global.mainGamePaused)
        {
            _pieCol = make_color_rgb(255, 255, 255);
            _rescueHeartScale = 1 / _cr;
            global.rescueLife = approach(global.rescueLife, 0, doDeltaWithAccessibility(0.0002777777777777778));
        }
        
        drawPie((_heartWidth / 2) - (1 * (os_type == os_windows)), _heartHeight / 2, _pieVal, 1, _pieCol, 8 * _cr, 1, 90);
        gpu_set_blendmode(bm_subtract);
        draw_sprite_ext(sUIheart, 2, _heartWidth / 2, _heartHeight / 2, _heartScale * _cr, _heartScale * _cr, 0, c_white, 1);
        gpu_set_blendmode(bm_normal);
        draw_sprite_ext(sUIheart, 1, _heartWidth / 2, _heartHeight / 2, _heartScale * _cr, _heartScale * _cr, 0, c_white, 1);
        surface_reset_target();
        var i = 3;
        var _surfPosx = (_hpPosx + ((i - 1) * _hpOffsetByx)) - ((_heartWidth / 2) * _rescueHeartScale);
        var _surfPosy = (_hpPosyFinal + ((i - 1) * _hpOffsetByy)) - ((_heartHeight / 2) * _rescueHeartScale);
        draw_surface_ext(rescueHeartSurface, _surfPosx, _surfPosy, _rescueHeartScale, _rescueHeartScale, 0, c_white, 1);
    }
}

if (!instance_exists(oAbilityEquipMenu) && !instance_exists(oShopMenu) && !instance_exists(oPuzzleMenu) && !instance_exists(oOrderControl_puzzle) && !instance_exists(oLeaderboardsMenu) && !instance_exists(parentEnding) && !instance_exists(oEndCredit) && (room == rmMainGame || room == rmPlayableMainMenu))
{
    var _abilityIconx = 0;
    var _abilityIcony = 0;
    var _abilityDrawy = _hpPosy + 5;
    var _abilityIconLeft = (_wRight - 8 - 4) + 2;
    
    if (room != rmPlayableMainMenu || !global.netflixEnabled)
        _abilityDrawy -= 16;
    
    var _abilityCount = 0;
    
    for (var i = 1; i < clamp(global.equipmentUnlockedSlotNum, 0, 3); i += 1)
    {
        var _abilityInSlot = global.equipmentSlot[| i];
        _abilityCount += 1;
        _abilityIconLeft -= 16;
    }
    
    for (var i = 0; i < global.equipmentUnlockedSlotNum; i += 1)
    {
        var _equipmentIndex = i;
        var _abilityInSlot = global.equipmentSlot[| _equipmentIndex];
        
        if (_abilityInSlot >= 0)
            draw_sprite_ext(global.upgradeIcon[| _abilityInSlot], 1, _abilityIconLeft + (_abilityIconx * 16), _abilityDrawy + (_abilityIcony * 16), 0.1, 0.1, 0, c_white, 1);
        
        _abilityIconx += 1;
        
        if (_abilityIconx >= 3)
        {
            _abilityIconx = 0;
            _abilityIcony += 1;
        }
    }
}
