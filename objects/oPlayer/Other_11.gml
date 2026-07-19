var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

if (mouse_check_button_pressed(mb_left))
{
    cursorx = _mx;
    cursory = _my;
}

var _cursorYoffset = -12;

if (mouse_check_button(mb_left) && !global.mobileSwipedFromBottomToPause && !global.playerControlLock && (slingLength >= slingInputThreshold || tapTimer >= tapThresholdFrames) && global.jumpTimes > 0 && readyToJump)
{
    var _cancelMarkerScale = 0.08000000000000002;
    var _pullingMarkerScale = 0.06;
    var _cancelMarkerx = mbPress_x;
    var _cancelMarkery = mbPress_y + _cursorYoffset;
    _cancelMarkerx = lerp(_cancelMarkerx, _mx, 0.075);
    _cancelMarkery = lerp(_cancelMarkery, _my - _cursorYoffset, 0.075);
    var _pullingMarkerAlpha = 1;
    var _cancelMarkerAlpha = 0.75;
    var _cursorLerpRate = 0.5;
    cursorx = deltaLerp(cursorx, _mx, _cursorLerpRate);
    cursory = deltaLerp(cursory, _my, _cursorLerpRate);
    var _cursorDir = point_direction(cursorx, cursory, _mx, _my);
    var _cursorLength = point_distance(cursorx, cursory, _mx, _my) / 4;
    _cursorLength = clamp(_cursorLength, 1, 8);
    var _cursorXscale = _cursorLength;
    var _cursorYscale = 1 - (0.65 * (_cursorXscale / 8));
    var _pullingMarkerx = cursorx;
    var _pullingMarkery = cursory + _cursorYoffset;
    _cancelMarkerScale += ((((1 - (slingLength / launchSpeed)) * 1) / 10) * 0.3);
    
    if (slingLength < slingInputThreshold && tapTimer >= tapThresholdFrames)
    {
        _cancelMarkerScale = 0.12;
        _pullingMarkerScale = 0.05;
        _pullingMarkerAlpha = 0.3;
        _cancelMarkerAlpha = 1;
    }
    
    var _slowTimerRatio = staticHoldCharge / global.staticHoldChargeMax;
    _slowTimerRatio = clamp(_slowTimerRatio * 1.5, 0, 1);
    _cancelMarkerScale *= _slowTimerRatio;
    
    if (abilityCheck(UnknownEnum.Value_11))
    {
        if (_slowTimerRatio < 1)
        {
            if (jumpMarkerShrinkStart == 0)
                playSoundAbilityTimeGrandpa();
            
            jumpMarkerShrinkStart = 1;
        }
        else
        {
            jumpMarkerShrinkStart = 0;
        }
    }
    
    draw_sprite_ext(sTouchControlMarker, 1, _cancelMarkerx, _cancelMarkery, _cancelMarkerScale, _cancelMarkerScale, 0, c_white, _cancelMarkerAlpha);
    draw_sprite_ext(sTouchControlMarker, 0, _pullingMarkerx, _pullingMarkery, _pullingMarkerScale * _cursorXscale, _pullingMarkerScale * _cursorYscale, _cursorDir, c_white, _pullingMarkerAlpha);
    
    if (slingLength < slingInputThreshold && tapTimer >= tapThresholdFrames)
    {
        var _cancelTextx = mbPress_x;
        var _cancelTexty = _cancelMarkery - 16 - 3;
        var _cancelText = loc("main game UI cancel jump");
        var _cancelTextSize = 0.7;
        scribble(_cancelText).starting_format(global.defaultFont, make_color_rgb(255, 255, 255)).line_height(10, 26).msdf_border(make_color_rgb(46, 50, 59), 3).scale_to_box(128, -1).transform(_cancelTextSize / 2, _cancelTextSize / 2, 0).align(1, 2).draw(_cancelTextx, _cancelTexty);
    }
}
