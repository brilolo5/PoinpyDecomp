if (instance_exists(oPlayer))
    playerHorizontalFrameNum = floor(oPlayer.x / 160);

if (room == rmMainGame)
    playerHorizontalFrameNum = 0;

if (prv_playerHorizontalFrameNum != playerHorizontalFrameNum)
{
    with (oPlayer)
        xsp = clamp(xsp, -3, 3);
}

prv_playerHorizontalFrameNum = playerHorizontalFrameNum;
var camGoalPosx = x;
var camGoalPosy = y;
var _camFocusLerpRateV = 0.15;
var _camFocusLerpRateH = 0.15;
var _inputUp = keyboard_check(vk_up);
var _inputDown = keyboard_check(vk_down);

if (keyboard_check(ord("A")) || puzzleScrollExit)
{
    camManualControl = 0;
    puzzleScrollMode = 0;
    puzzleScrollExit = 0;
    playerControlLockTimer(5);
}

var _puzzleScrollInput = puzzleScrollUpInput || puzzleScrollDownInput;

if (_puzzleScrollInput && instance_exists(oMagma))
{
    if (oMagma.puzzleMagmaSetInPlace > 0)
        _puzzleScrollInput = 0;
}

if (_puzzleScrollInput)
{
    camManualControl = 1;
    playerControlLock();
    puzzleScrollMode = 1;
    var _puzzleScrollSpeed = doDelta(4);
    
    if (puzzleScrollInputPressed)
        _puzzleScrollSpeed = doDelta(2);
    
    if (puzzleScrollUpInput)
        camPosy -= _puzzleScrollSpeed;
    else if (puzzleScrollDownInput)
        camPosy += _puzzleScrollSpeed;
    
    var target = instance_position(x, y, oCameraActivateArea);
    
    if (target)
    {
        var _topLimit = target.topLimit + (global.viewHeight / 2);
        var _bottomLimit = target.bottomLimit - (global.viewHeight / 2);
        
        if (target.focusPointV != -1)
        {
            _camFocusLerpRateV = target.lerpRateV;
            camGoalPosy = target.focusPointV;
        }
        else
        {
            camGoalPosy = clamp(camGoalPosy, _topLimit, _bottomLimit);
            
            if (!inRange_values(camPosy, _topLimit, _bottomLimit))
            {
                _camFocusLerpRateV = target.lerpRateV;
                var _maxCamSpeed = 10;
            }
        }
        
        if (!puzzleScrollInputPressed)
        {
            var _camPosyClamp = clamp(camPosy, _topLimit, _bottomLimit);
            camPosy = deltaLerp(camPosy, _camPosyClamp, 0.2);
        }
    }
}

puzzleScrollInputPressed = 0;

if (device_mouse_check_button(2, mb_left) && !device_mouse_check_button(3, mb_left))
{
    var _inputPosyMean = mean(device_mouse_y_to_gui(0), device_mouse_y_to_gui(1), device_mouse_y_to_gui(2));
    
    if (_inputPosyMean > (global.windowBottom / 2))
        _inputDown = 1;
    else
        _inputUp = 1;
}

if (global.debugControl && (_inputUp || _inputDown))
{
    camDebugLock = 1;
    camPosy -= doDelta(_inputUp * 10);
    camPosy += doDelta(_inputDown * 10);
    
    with (oResultsScreen)
        instance_destroy();
    
    if (instance_exists(oPlayer))
        oPlayer.y = y;
    
    global.debugNoDamage = 1;
    
    if (instance_exists(oOrderControl))
        oOrderControl.angerTimer = 999999;
}
else
{
    camDebugLock = 0;
}

if (!camDebugLock && !camManualControl)
{
    camGoalPosx = (playerHorizontalFrameNum * 160) + 80;
    
    if (instance_exists(oPlayer))
    {
        camGoalPosy = oPlayer.y + oPlayer.cy + cameraPosy_offset;
        
        if (room == rmMainGame)
            camGoalPosy = clamp(camGoalPosy, camGoalPosy, global.unloadLevelArea_y - 160 - (global.viewHeight / 2));
        
        if (horizontalFollow)
            camGoalPosx = oPlayer.x;
    }
    
    var _maxCamSpeed = 16;
    
    with (oPlayer)
    {
        var target = instance_position(x, y, oCameraFocusArea);
        
        if (target)
        {
            with (oCamera)
            {
                switch (target.focusType)
                {
                    case "point focus":
                        camGoalPosx = target.focusPoint_x;
                        camGoalPosy = target.focusPoint_y;
                        _camFocusLerpRateV = target.focusLerpRate;
                        break;
                    
                    case "free - limit bottom":
                        camGoalPosx = target.focusPoint_x;
                        camGoalPosy = clamp(camGoalPosy, camGoalPosy, target.focusPoint_y - (global.viewHeight / 2));
                        camPosy = clamp(camPosy, camPosy, target.focusPoint_y - (global.viewHeight / 2));
                        _camFocusLerpRateV = target.focusLerpRate;
                        break;
                    
                    case "free - limit top":
                        camGoalPosx = target.focusPoint_x;
                        var _focusPointy = target.focusPoint_y + (global.viewHeight / 2);
                        camGoalPosy = clamp(camGoalPosy, _focusPointy, 9999);
                        camPosy = clamp(camPosy, _focusPointy, camPosy);
                        _camFocusLerpRateV = target.focusLerpRate;
                        break;
                    
                    case "free - limit both in area":
                        var _topLimit = target.bbox_top + (global.viewHeight / 2);
                        var _bottomLimit = target.bbox_bottom - (global.viewHeight / 2);
                        camGoalPosy = clamp(camGoalPosy, _topLimit, _bottomLimit);
                        camPosy = clamp(camPosy, _topLimit, _bottomLimit);
                        _camFocusLerpRateV = target.focusLerpRate;
                        break;
                }
            }
        }
        
        target = instance_position(x, y, oCameraActivateArea);
        
        if (target && target.bbox_bottom >= bbox_bottom)
        {
            with (oCamera)
            {
                var _topLimit = target.topLimit + (global.viewHeight / 2);
                var _bottomLimit = target.bottomLimit - (global.viewHeight / 2);
                
                if (target.focusPointV != -1)
                {
                    _camFocusLerpRateV = target.lerpRateV;
                    camGoalPosy = target.focusPointV;
                }
                else
                {
                    camGoalPosy = clamp(camGoalPosy, _topLimit, _bottomLimit);
                    
                    if (!inRange_values(camPosy, _topLimit, _bottomLimit))
                    {
                        _camFocusLerpRateV = target.lerpRateV;
                        _maxCamSpeed = 10;
                    }
                }
            }
        }
    }
    
    introOffsety = deltaLerp(introOffsety, 0, 0.05);
    camGoalPosy += (introOffsety * introOffsetyAmount);
    _maxCamSpeed = doDelta(_maxCamSpeed);
    var camPosyChangeSpeed = (camGoalPosy - camPosy) * _camFocusLerpRateV;
    camPosyChangeSpeed = doDelta(camPosyChangeSpeed);
    camPosyChangeSpeed = clamp(camPosyChangeSpeed, -_maxCamSpeed, _maxCamSpeed);
    camPosy += camPosyChangeSpeed;
    camPosx = deltaLerp(camPosx, camGoalPosx, _camFocusLerpRateH);
}

frameTimer -= 1;

if (frameTimer <= 0)
{
    if (screenShakeTimer)
    {
        screenShakeTimer -= 1;
        var _shakeDirection = random(360);
        
        if (global.screenshakeEnabled)
        {
            screenShakePosx = lengthdir_x(screenShakeAmount, _shakeDirection);
            screenShakePosy = lengthdir_y(screenShakeAmount, _shakeDirection);
        }
    }
    
    frameTimer += 1;
}

if (!screenShakeTimer)
{
    screenShakePosx = 0;
    screenShakePosy = 0;
    screenShakeAmount = 0;
}

y = camPosy + screenShakePosy;
x = camPosx + screenShakePosx;
camx = oCamera.x - (camera_get_view_width(global.cam) / 2);
camy = oCamera.y - (camera_get_view_height(global.cam) / 2);
camera_set_view_pos(global.cam, camx, camy);
