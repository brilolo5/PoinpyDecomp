global.oneGameTime += (currentState != "dead");
global.jumpReleaseInput = 0;
var gts = global.timeScale;
mbHeld = 0;

if ((mouse_check_button_pressed(mb_right) || device_mouse_check_button_pressed(4, mb_left)) && global.debugControl)
    debugRightClickFunction();

var _gamepad = input_player_gamepad_get();
var _padAxish = input_gamepad_value(_gamepad, 32785);
var _padAxisv = input_gamepad_value(_gamepad, 32786);
var _padAngle = point_direction(0, 0, _padAxish, _padAxisv);
var _padStickInput = (abs(_padAxish) + abs(_padAxisv)) > 1;
stickInputRelease = 0;

if (stickInputRelease_prvState != _padStickInput)
{
    stickInputRelease = 1;
    stickInputRelease_prvState = _padStickInput;
}

if (gamePadStickAimReset)
{
    var _stickAimDifference = angle_difference(gamePadStickLastAimAngle, _padAngle);
    
    if ((abs(_padAxish) + abs(_padAxisv)) <= 0.7 || abs(_stickAimDifference) > 25)
        gamePadStickAimReset = 0;
    else
        _padStickInput = 0;
}

mbHeld = (input_player_source_get() == UnknownEnum.Value_1 && input_check("jump")) || _padStickInput;
var _padAPressed = input_player_source_get() == UnknownEnum.Value_2 && input_check_pressed("jump");
var _padBPressed = input_player_source_get() == UnknownEnum.Value_2 && input_check_pressed("slam");
mousex = device_mouse_x_to_gui(0);
mousey = device_mouse_y_to_gui(0);

if (global.playerControlLock)
{
    mbHeld = 0;
    
    if (global.playerControlLockReleaseTimer > 0)
    {
        global.playerControlLockReleaseTimer -= 1;
        
        if (global.playerControlLockReleaseTimer <= 0)
            controlUnlockOnRelease = 1;
    }
    
    if (controlUnlockOnRelease)
    {
        if (!mouse_check_button(mb_left))
        {
            global.playerControlLock = 0;
            controlUnlockOnRelease = 0;
            tapTimer = 100;
        }
    }
}

stompInputCancelTime = approach(stompInputCancelTime, 0, 1);
readyToJump = (global.jumpTimes > 0 || instance_exists(oJumpOrbReplenishEffect)) && currentState != "dead" && currentState != "in cannon";

if (!mbHeld)
{
    slingPulled = 0;
    var _angDif = angle_difference(global.cannonTempSlingAngle, global.cannonAngleGoal) * 0.5;
    global.cannonTempSlingAngle -= _angDif;
}

var _windowHeight = display_get_gui_height();

if (mouse_check_button_pressed(mb_left) && mousey > (_windowHeight - (_windowHeight / 32)))
{
    readyToJump = 0;
    mbHeld = 0;
    tapTimer = 100;
    global.mobileSwipedFromBottomToPause = 1;
    exit;
}
else if (global.mobileSwipedFromBottomToPause)
{
    if (mouse_check_button_pressed(mb_left))
        global.mobileSwipedFromBottomToPause = 0;
    else
        exit;
}

if (!global.playerControlLock && !((currentState == "slamming" || currentState == "slamming - invincible") && !abilityCheck(UnknownEnum.Value_11)) && currentState != "dead")
{
    if (readyToJump)
    {
        if (mouse_check_button_pressed(mb_left))
        {
            mbPress_x = mousex;
            mbPress_y = mousey;
            tapTimer = 0;
        }
        
        if (mbHeld)
        {
            staticHoldCharge -= doDelta(1);
            
            if (staticHoldCharge)
            {
                if (global.timeScale_noDelta > 0.5)
                    global.timeScale_noDelta = 0.5;
                
                if (abilityCheck(UnknownEnum.Value_11))
                {
                    var _targetTimescale = 0;
                    var _shift = (global.timeScale - _targetTimescale) * 0.4;
                    timeScaleChange(_targetTimescale, 1, _shift);
                }
                else
                {
                    var _targetTimescale = 0.05;
                    var _shift = (global.timeScale - _targetTimescale) * 0.1;
                    timeScaleChange(0.05, 1, _shift);
                }
            }
            else
            {
                var _shift = (1 - global.timeScale) * 0.01;
                timeScaleChange(1, 1, _shift);
            }
            
            slingDirection = point_direction(mbPress_x, mbPress_y, mousex, mousey) + (180 * !global.invertSwipe);
            slingLength = clamp(point_distance(mbPress_x, mbPress_y, mousex, mousey) / 4, 0, launchSpeed);
            
            if (_padStickInput)
            {
                slingDirection = _padAngle;
                slingLength = launchSpeed;
            }
            
            var _slingDirection = slingDirection;
            slingDirection %= 360;
            tapTimer += doDelta(1);
            
            if (slingLength >= 4)
            {
                global.cannonTempSlingAngle = _slingDirection - 90;
                slingLength = launchSpeed;
                
                if (slingPulled == 0)
                {
                    audioEvent("sling trajectory drawn");
                    var _slingPullSound = playSfxWorld(sfx_player_readyJump_pullback);
                    haptic("click 2");
                    slingPulled = 1;
                }
            }
            else
            {
                slingLength = 0;
                slingPulled = 0;
            }
            
            xspSet = lengthdir_x(slingLength, slingDirection);
            yspSet = lengthdir_y(slingLength, slingDirection);
        }
        
        if (mouse_check_button_released(mb_left) || (_padAPressed && _padStickInput))
        {
            gamePadStickAimReset = 1;
            gamePadStickLastAimAngle = _padAngle;
            playerControlInputRelease();
            
            if (slingLength >= 4)
            {
                playSoundPlayerJump();
                var _spinSound = playSfxWorld(sfx_player_spin_med, true, true);
                audioSetSlowmo(_spinSound);
                audioSystemStopAsset(sfx_player_post_wall_flying_lp);
            }
            
            slingLength = 0;
        }
        
        if (_padBPressed)
            playerSlam();
        
        noJumpLeftFeedback = 0;
        noJumpLeftFeedback_triggerCount = 0;
    }
    else
    {
        if (_padBPressed)
            playerSlam();
        
        if (mouse_check_button_pressed(mb_left))
        {
            mbPress_x = mousex;
            mbPress_y = mousey;
            tapTimer = 0;
        }
        
        if (mbHeld)
        {
            tapTimer += doDelta(1);
            slingLength = clamp(point_distance(mbPress_x, mbPress_y, mousex, mousey) / 4, 0, launchSpeed);
            
            if (_padStickInput)
            {
                slingDirection = _padAngle;
                slingLength = launchSpeed;
            }
            
            if (slingLength >= 2 && !noJumpLeftFeedback)
            {
                if (noJumpLeftFeedback_triggerCount < noJumpLeftFeedback_triggerMax)
                {
                    var _noJumpPauseFrames = 15;
                    var _framesToReturnToNormalTime = 30;
                    _noJumpPauseFrames /= (noJumpLeftFeedback_triggerCount + 1);
                    _framesToReturnToNormalTime /= (noJumpLeftFeedback_triggerCount + 1);
                    timeScaleChange(0.1, _noJumpPauseFrames, 1);
                    timeScaleChange(1, _noJumpPauseFrames + _framesToReturnToNormalTime, 1 / _framesToReturnToNormalTime);
                }
                
                instance_create_depth(x, y, 0, effectNoJumpsLeft);
                noJumpLeftFeedback = 1;
                noJumpLeftFeedback_triggerCount += 1;
            }
        }
        
        if (mouse_check_button_released(mb_left) || stickInputRelease)
        {
            noJumpLeftFeedback = 0;
            
            if (tapTimer < tapThresholdFrames && slingLength < slingInputThreshold)
                playerSlam();
            
            staticHoldCharge = global.staticHoldChargeMax;
            slingLength = 0;
        }
        
        slingPulled = 0;
    }
}

if (currentState == "ground")
    staticHoldCharge = global.staticHoldChargeMax;
