var _center = global.windowCenterx;
var _boxWidth = global.viewWidth - 8;
var _boxLeft = _center - (_boxWidth / 2);
var _boxRight = _boxLeft + _boxWidth;
var _textWidth = _boxWidth - 12;
var _boxHeight = 48;
var _boxTop = textBoxTopTween - (_boxHeight / 2);
var _boxDefaultHeight = 48 + global.notchOffset;
var _boxFocusHeight = global.viewHeight / 3;
var _boxRecipeFocusHeight = 72 + global.notchOffset;
var _boxRecipeLowHeight = global.viewHeight - 48;
var _lerpRate = 0.1;
textBoxTopTween = lerp(textBoxTopTween, boxPosyGoal, _lerpRate);
var _boxBottom = _boxTop + _boxHeight;
var _nextInput = input_check_pressed("select");
draw_set_color(make_color_rgb(122, 131, 146));
draw_set_alpha(0.5);
draw_roundrect_ext(_boxLeft, _boxTop, _boxRight, _boxBottom, 16, 16, 0);
draw_set_alpha(1);
tapToNext += 1;

if (tapToNext && global.playerControlLock)
{
    draw_set_color(make_color_rgb(46, 50, 59));
    draw_circle(_center, _boxBottom - 4, 5, 0);
    draw_set_color(make_color_rgb(255, 255, 255));
    draw_circle(_center, _boxBottom - 4, 4, 0);
}

if (global.debugControl)
{
    if (keyboard_check_pressed(vk_left))
    {
        tutorialStep = approach(tutorialStep, 0, 1);
        microStep -= 1;
    }
    
    if (keyboard_check_pressed(vk_right))
    {
        tutorialStep = UnknownEnum.Value_5;
        microStep = 17;
        tapToNext = -60;
        global.playerControlLock = 1;
    }
}

var _checkCheckpoint;

with (oPlayer)
{
    _checkCheckpoint = instance_place(x, y, oTutorialCheckpointArea);
    var _guideStopArea = instance_place(x, y, oTutorialGuideStopArea);
    
    if (_guideStopArea)
    {
        other.guideShow = 0;
        instance_destroy(_guideStopArea);
    }
}

if (_checkCheckpoint)
{
    with (oPlayer)
    {
        playerStateChange("spin jump");
        xsp = 0;
        ysp = clamp(ysp, -10, -2);
    }
    
    switch (_checkCheckpoint.checkpointName)
    {
        case "slam":
            tutorialStep = UnknownEnum.Value_3;
            microStep = 0;
            break;
        
        case "wall bounce":
            tutorialStep = UnknownEnum.Value_2;
            microStep = 0;
            break;
        
        case "juice":
            tutorialStep = UnknownEnum.Value_5;
            microStep = 0;
            break;
    }
    
    instance_destroy(_checkCheckpoint);
}

drawSetAlign(0, 0);
var timeTillGreat = 30;
var _focusDisableTime = 90;
var _textPosy = _boxTop + (_boxHeight / 2);
var _textSize = 1;
drawSetAlign(1, 1);

switch (tutorialStep)
{
    case UnknownEnum.Value_0:
        switch (microStep)
        {
            case 0:
                global.jumpTimesMax = 1;
                global.jumpTimes = 1;
                var _text = loc("welcome 1");
                boxPosyGoal = _boxFocusHeight;
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                global.playerControlLock = 1;
                
                if (tapToNext && _nextInput)
                {
                    tapToNext = -60;
                    microStep = 1;
                }
                
                break;
            
            case 1:
                boxPosyGoal = _boxFocusHeight;
                global.playerControlLock = 1;
                _text = loc("welcome 2");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    tutorialStep = UnknownEnum.Value_1;
                    microStep = 0;
                    global.playerControlLockReleaseTimer = _focusDisableTime;
                }
                
                break;
        }
        
        break;
    
    case UnknownEnum.Value_1:
        switch (microStep)
        {
            case 0:
                if (global.playerControlLock)
                {
                    boxPosyGoal = _boxFocusHeight;
                }
                else
                {
                    boxPosyGoal = _boxDefaultHeight;
                    tutorialAnimationAlpha = lerp(tutorialAnimationAlpha, 1, 0.025);
                    
                    if (tutorialAnimationAlpha > 0.95)
                    {
                        tutorialAnimationAlpha = 1;
                        tutorialAnimationFrame += 0.16666666666666666;
                    }
                }
                
                var _text = loc("swipe jump");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                tapToNext = -1;
                
                if (!guideShow)
                    guideDisappearAlpha = lerp(guideDisappearAlpha, 0, 0.025);
                
                var _guideAlpha = tutorialAnimationAlpha * guideDisappearAlpha;
                var _guidex = _center;
                var _guidey = (_textPosy + 64) - (8 * tutorialAnimationAlpha);
                var _guideScale = 0.15000000000000002;
                draw_sprite_ext(sTutorialFingerSwipeBlue, tutorialAnimationFrame, _guidex, _guidey, _guideScale, _guideScale, 0, c_white, _guideAlpha);
                break;
        }
        
        break;
    
    case UnknownEnum.Value_3:
        switch (microStep)
        {
            case 0:
                tapToNext = -60;
                microStep = 1;
            
            case 1:
                boxPosyGoal = _boxFocusHeight;
                global.playerControlLock = 1;
                var _text = loc("great");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    microStep = 2;
                    stepChecker = 0;
                    tapToNext = -60;
                }
                
                break;
            
            case 2:
                boxPosyGoal = _boxFocusHeight;
                _text = loc("slam 1");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    microStep = 3;
                    global.playerControlLock = 1;
                    global.playerControlLockReleaseTimer = _focusDisableTime;
                    tutorialAnimationAlpha = 0;
                    tutorialAnimationFrame = 0;
                    guideShow = 1;
                    guideDisappearAlpha = 1;
                }
                
                break;
            
            case 3:
                if (global.playerControlLock)
                {
                    boxPosyGoal = _boxFocusHeight;
                    tutorialAnimationIndex = sTutorialFingerSwipeBlue;
                }
                else
                {
                    boxPosyGoal = _boxDefaultHeight;
                    tutorialAnimationAlpha = lerp(tutorialAnimationAlpha, 1, 0.025);
                    
                    if (tutorialAnimationAlpha > 0.95)
                    {
                        tutorialAnimationAlpha = 1;
                        tutorialAnimationFrame += 0.16666666666666666;
                        var _tutAnimFrameNumber = sprite_get_number(tutorialAnimationIndex);
                        
                        if (tutorialAnimationFrame > _tutAnimFrameNumber)
                        {
                            tutorialAnimationFrame = 0;
                            tutorialAnimationIndex = (tutorialAnimationIndex == 450) ? 456 : 450;
                        }
                    }
                }
                
                tapToNext = -1;
                _text = loc("slam 2");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (!guideShow)
                    guideDisappearAlpha = lerp(guideDisappearAlpha, 0, 0.025);
                
                var _guideAlpha = tutorialAnimationAlpha * guideDisappearAlpha;
                var _guideScale = 0.15000000000000002;
                
                if (_guideAlpha >= 0.95)
                    gpu_set_blendmode_ext(bm_one, bm_inv_src_alpha);
                
                draw_sprite_ext(tutorialAnimationIndex, tutorialAnimationFrame, _center, (_textPosy + 64) - (8 * tutorialAnimationAlpha), _guideScale, _guideScale, 0, c_white, _guideAlpha);
                gpu_set_blendmode(bm_normal);
        }
        
        break;
    
    case UnknownEnum.Value_2:
        switch (microStep)
        {
            case 0:
                global.playerControlLock = 1;
                microStep += 1;
                tapToNext = -60;
            
            case 1:
                boxPosyGoal = _boxFocusHeight;
                var _text = loc("great");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    microStep = 2;
                    tapToNext = -60;
                    global.playerControlLock = 1;
                }
                
                break;
            
            case 2:
                boxPosyGoal = _boxFocusHeight;
                _text = loc("bounce 1");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    microStep = 3;
                    global.playerControlLock = 1;
                    global.playerControlLockReleaseTimer = _focusDisableTime;
                }
                
                break;
            
            case 3:
                if (global.playerControlLock)
                    boxPosyGoal = _boxFocusHeight;
                else
                    boxPosyGoal = _boxDefaultHeight;
                
                tapToNext = -1;
                _text = loc("bounce 2");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                break;
        }
        
        break;
    
    case UnknownEnum.Value_4:
        switch (microStep)
        {
            case 0:
                global.playerControlLock = 1;
                microStep += 1;
                tapToNext = -60;
            
            case 1:
                boxPosyGoal = _boxFocusHeight;
                var _text = loc("nice");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    microStep = 2;
                    tapToNext = -60;
                    global.playerControlLock = 1;
                }
                
                break;
            
            case 2:
                boxPosyGoal = _boxFocusHeight;
                _text = loc("orb 1");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    tapToNext = -60;
                    microStep = 3;
                    global.playerControlLock = 1;
                }
                
                break;
            
            case 3:
                boxPosyGoal = _boxFocusHeight;
                _text = loc("orb 2");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    tapToNext = -60;
                    microStep = 4;
                    global.playerControlLock = 1;
                    global.playerControlLockReleaseTimer = _focusDisableTime;
                    tutorialAnimationAlpha = 0;
                    tutorialAnimationFrame = 0;
                    guideShow = 1;
                    guideDisappearAlpha = 1;
                }
                
                break;
            
            case 4:
                if (global.playerControlLock)
                {
                    boxPosyGoal = _boxFocusHeight;
                    tutorialAnimationIndex = sTutorialFingerSwipeBlue;
                }
                else
                {
                    boxPosyGoal = _boxDefaultHeight;
                    tutorialAnimationAlpha = lerp(tutorialAnimationAlpha, 1, 0.025);
                    
                    if (tutorialAnimationAlpha > 0.95)
                    {
                        tutorialAnimationAlpha = 1;
                        tutorialAnimationFrame += 0.16666666666666666;
                    }
                    
                    var _tutAnimFrameNumber = sprite_get_number(tutorialAnimationIndex);
                    
                    if (tutorialAnimationFrame > _tutAnimFrameNumber)
                    {
                        tutorialAnimationFrame = 0;
                        tutorialAnimationIndex = (tutorialAnimationIndex == 450) ? 452 : 450;
                    }
                }
                
                _text = loc("orb 3");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                tapToNext = -1;
                
                if (!guideShow)
                    guideDisappearAlpha = lerp(guideDisappearAlpha, 0, 0.025);
                
                var _guideAlpha = tutorialAnimationAlpha * guideDisappearAlpha;
                var _guideScale = 0.15000000000000002;
                draw_sprite_ext(tutorialAnimationIndex, tutorialAnimationFrame, _center, (_textPosy + 64) - (8 * tutorialAnimationAlpha), _guideScale, _guideScale, 0, c_white, _guideAlpha);
                break;
        }
        
        break;
    
    case UnknownEnum.Value_5:
        switch (microStep)
        {
            case 0:
                global.playerControlLock = 1;
                microStep += 1;
                tapToNext = -60;
            
            case 1:
                boxPosyGoal = _boxFocusHeight;
                var _text = loc("great");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    microStep = 2;
                    tapToNext = -60;
                    global.playerControlLock = 1;
                }
                
                break;
            
            case 2:
                boxPosyGoal = _boxFocusHeight;
                _text = loc("juice now");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    tapToNext = -60;
                    microStep = 3;
                    global.playerControlLock = 1;
                    instance_create_depth(x, y, depth, oTutorialOrderControl);
                }
                
                break;
            
            case 3:
                boxPosyGoal = _boxRecipeFocusHeight;
                _text = loc("juice recipe");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    tapToNext = -60;
                    microStep += 1;
                    global.playerControlLock = 1;
                }
                
                break;
            
            case 4:
                boxPosyGoal = _boxRecipeFocusHeight;
                _text = loc("juice get these");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    tapToNext = -60;
                    microStep += 1;
                    global.playerControlLock = 1;
                }
                
                break;
            
            case 5:
                boxPosyGoal = _boxRecipeFocusHeight;
                _text = loc("juice land");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    tapToNext = -60;
                    microStep += 1;
                    global.playerControlLock = 1;
                    global.playerControlLockReleaseTimer = _focusDisableTime;
                    global.jumpTimesMax = 2;
                    global.jumpTimes = global.jumpTimesMax;
                    stepChecker = 0;
                }
                
                break;
            
            case 6:
                if (global.playerControlLock)
                    boxPosyGoal = _boxRecipeFocusHeight;
                else
                    boxPosyGoal = _boxRecipeLowHeight;
                
                tapToNext = -1;
                
                if (oTutorialOrderControl.orderComplete && !prvStateChecker)
                    stepChecker += 1;
                
                prvStateChecker = oTutorialOrderControl.orderComplete;
                
                if (stepChecker >= 3)
                {
                    tapToNext = -60;
                    microStep += 1;
                    global.playerControlLock = 1;
                }
                
                var _progressString = string(stepChecker) + "/" + string(3);
                _text = loc("juice get and land") + "\n" + _progressString;
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                break;
            
            case 7:
                if (instance_exists(oTutorialOrderControl))
                    instance_destroy(oTutorialOrderControl);
                
                boxPosyGoal = _boxFocusHeight;
                _text = loc("juice done compliment");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    tapToNext = -60;
                    microStep += 1;
                    global.playerControlLock = 1;
                }
                
                break;
            
            case 8:
                boxPosyGoal = _boxFocusHeight;
                _text = loc("juice harder");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    tapToNext = -60;
                    microStep += 1;
                    global.playerControlLock = 1;
                    global.playerControlLockReleaseTimer = _focusDisableTime;
                    stepChecker = 0;
                    
                    with (instance_create_depth(x, y, depth, oTutorialOrderControl))
                    {
                        global.difficultyLevel = 2;
                        orderRandomize(recipeDataGrid);
                    }
                    
                    prvStateChecker = oTutorialOrderControl.orderComplete;
                }
                
                break;
            
            case 9:
                if (global.playerControlLock)
                    boxPosyGoal = _boxFocusHeight;
                else
                    boxPosyGoal = _boxRecipeLowHeight;
                
                tapToNext = -1;
                
                if (oTutorialOrderControl.orderComplete && !prvStateChecker)
                    stepChecker += 1;
                
                prvStateChecker = oTutorialOrderControl.orderComplete;
                
                if (stepChecker >= 3)
                {
                    tapToNext = -60;
                    microStep += 1;
                    global.playerControlLock = 1;
                }
                
                _progressString = string(stepChecker) + "/" + string(3);
                _text = loc("juice get and land plural") + "\n" + _progressString;
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                break;
            
            case 10:
                if (instance_exists(oTutorialOrderControl))
                    instance_destroy(oTutorialOrderControl);
                
                boxPosyGoal = _boxFocusHeight;
                _text = loc("very good");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    tapToNext = -60;
                    microStep += 1;
                    global.playerControlLock = 1;
                }
                
                break;
            
            case 11:
                boxPosyGoal = _boxFocusHeight;
                _text = loc("timer intro");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    tapToNext = -180;
                    microStep += 1;
                    global.playerControlLock = 1;
                    
                    with (instance_create_depth(x, y, depth, oTutorialOrderControl))
                    {
                        timerBegin = 2;
                        global.difficultyLevel = 2;
                        orderRandomize(recipeDataGrid);
                    }
                }
                
                break;
            
            case 12:
                boxPosyGoal = _boxRecipeFocusHeight;
                _text = loc("timer explain 1");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    tapToNext = -60;
                    microStep += 1;
                    global.playerControlLock = 1;
                }
                
                break;
            
            case 13:
                boxPosyGoal = _boxRecipeFocusHeight;
                _text = loc("timer explain 2");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    tapToNext = -60;
                    microStep += 1;
                    global.playerControlLock = 1;
                    global.playerControlLockReleaseTimer = _focusDisableTime;
                    stepChecker = 0;
                    
                    with (oTutorialOrderControl)
                    {
                        timerBegin = 0;
                        angerTimer = angerTimerMax + 120;
                    }
                    
                    prvStateChecker = oTutorialOrderControl.orderComplete;
                }
                
                break;
            
            case 14:
                if (global.playerControlLock)
                {
                    boxPosyGoal = _boxRecipeFocusHeight;
                }
                else
                {
                    boxPosyGoal = _boxRecipeLowHeight;
                    oTutorialOrderControl.timerBegin = 1;
                }
                
                tapToNext = -1;
                
                if (oTutorialOrderControl.orderComplete && !prvStateChecker && oTutorialOrderControl.angerTimer > 0)
                    stepChecker += 1;
                
                prvStateChecker = oTutorialOrderControl.orderComplete;
                
                if (oTutorialOrderControl.angerTimer <= 0)
                {
                    microStep = "timer ran out 1";
                    tapToNext = -60;
                    global.playerControlLock = 1;
                }
                else if (stepChecker >= 3)
                {
                    tapToNext = -60;
                    microStep += 1;
                    global.playerControlLock = 1;
                    
                    if (instance_exists(oTutorialOrderControl))
                        instance_destroy(oTutorialOrderControl);
                }
                
                _progressString = string(stepChecker) + "/" + string(3);
                _text = loc("juice get and land plural") + "\n" + _progressString;
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                break;
            
            case "timer ran out 1":
                with (oTutorialOrderControl)
                {
                    timerBegin = 0;
                    angerTimer = angerTimerMax + 120;
                }
                
                boxPosyGoal = _boxFocusHeight;
                _text = loc("timer fail 1");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    tapToNext = -60;
                    microStep = "timer ran out 2";
                    global.playerControlLock = 1;
                }
                
                break;
            
            case "timer ran out 2":
                boxPosyGoal = _boxFocusHeight;
                _text = loc("timer fail 2");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    tapToNext = -60;
                    microStep = 14;
                    global.playerControlLock = 1;
                    global.playerControlLockReleaseTimer = _focusDisableTime;
                }
                
                break;
            
            case 15:
                boxPosyGoal = _boxFocusHeight;
                _text = loc("well done");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    tapToNext = -60;
                    microStep += 1;
                    global.playerControlLock = 1;
                }
                
                break;
            
            case 16:
                boxPosyGoal = _boxFocusHeight;
                _text = loc("covers everything");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    tapToNext = -60;
                    microStep += 1;
                    global.playerControlLock = 1;
                }
                
                break;
            
            case 17:
                boxPosyGoal = _boxFocusHeight;
                _text = loc("good luck");
                drawTextOutlined(_center, _textPosy, _text, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, _textSize, _textWidth);
                
                if (tapToNext && _nextInput)
                {
                    global.playerControlLockReleaseTimer = 180;
                    saveGame();
                    instance_destroy();
                    instance_create_depth(0, 0, 0, oTransitionEffectTest);
                    global.mainGamePaused = -1;
                }
                
                break;
        }
        
        break;
}
