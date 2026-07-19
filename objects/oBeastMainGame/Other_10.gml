angerLevel4at = 0.2;

if (instance_exists(oOrderControl))
{
    if (postFailureAnger && oOrderControl.angerTimerMax < oOrderControl.angerTimerMax_default)
        angerLevel4at = 0.5;
    
    angerTimerRatio = oOrderControl.angerTimer / oOrderControl.angerTimerMax;
    angerTimerRatio = clamp(angerTimerRatio, 0, 1);
}

switch (beastGameState)
{
    case "enter intro":
        beastFaceAngleLock(true);
        beastSetAngerTick(false);
        var _ac = animcurve_get(curveBackInv);
        var _acChannel = animcurve_get_channel(_ac, "curve1");
        var _acValue = animcurve_channel_evaluate(_acChannel, gameStartBeastEnterTweenPos);
        
        if (gameStartBeastEnterTweenStart)
            gameStartBeastEnterTweenPos += doDelta(0.011111111111111112);
        
        var _offsetValue = enterIntroOffsetyDefault;
        enterIntroOffsety = _offsetValue - (_offsetValue * _acValue);
        
        if (gameStartBeastEnterTweenPos >= 1)
            beastGameStateChange("waiting");
        
        break;
    
    case "waiting":
        if (beastGameStateUpdate)
        {
            recipeStateChange("normal");
            beastGameStateUpdate = 0;
        }
        
        beastFaceAngleLock(false);
        beastSetAngerTick(true);
        var _angerTimerOf10 = angerTimerRatio;
        
        if (postFailureAnger)
        {
            if (_angerTimerOf10 >= angerLevel4at)
                waitStateLevel = 3;
            else if (_angerTimerOf10 > 0)
                waitStateLevel = 4;
            else
                waitStateLevel = 5;
        }
        else if (_angerTimerOf10 >= 0.5)
        {
            waitStateLevel = 1;
        }
        else if (_angerTimerOf10 >= angerLevel4at)
        {
            waitStateLevel = 3;
        }
        else if (_angerTimerOf10 > 0)
        {
            waitStateLevel = 4;
        }
        else
        {
            waitStateLevel = 5;
        }
        
        if (p_waitStateLevel != waitStateLevel)
        {
            switch (waitStateLevel)
            {
                case 1:
                    beastFaceStateChange("wait level 1");
                    break;
                
                case 2:
                    beastFaceStateChange("wait level 2 start");
                    playSoundBeastHungerGrumble1();
                    break;
                
                case 3:
                    beastFaceStateChange("wait level 3 start");
                    playSoundBeastHungerGrumble2();
                    break;
                
                case 4:
                    beastFaceStateChange("wait level 4 start");
                    break;
                
                case 5:
                    beastFaceStateChange("wait level 5");
                    break;
            }
            
            p_waitStateLevel = waitStateLevel;
        }
        
        break;
    
    case "ready":
        var _stillGlugging = 0;
        
        switch (faceState)
        {
            case "glug start":
            case "glug receive":
            case "glug close":
            case "glug taste":
            case "glug delicious start":
            case "glug delicious":
                _stillGlugging = 1;
                break;
            
            default:
                break;
        }
        
        if (!_stillGlugging)
        {
            beastFaceAngleLock(false);
            
            if (beastGameStateUpdate)
            {
                beastFaceStateChange("wait ready");
                recipeStateChange("ready");
                postFailureAnger = 0;
                beastGameStateUpdate = 0;
            }
        }
        
        break;
    
    case "success":
        beastFaceAngleLock(true);
        beastSetAngerTick(false);
        
        if (beastGameStateUpdate)
        {
            deliciousFaceIndex = 0;
            deliciousFaceArray = getBeastDelicousFaceSet(deliciousFaceIndex);
            deliciousFaceIndex += 1;
            beastFaceStateChange("glug start");
            recipeStateChange("success");
            postFailureAnger = 0;
            beastGameStateUpdate = 0;
        }
        
        break;
    
    case "failure":
        beastFaceAngleLock(true);
        beastSetAngerTick(false);
        
        if (beastGameStateUpdate)
        {
            beastFaceStateChange("anger flash");
            recipeStateChange("failure");
            postFailureAnger = 1;
            beastGameStateUpdate = 0;
        }
        
        break;
    
    case "magma switch":
        beastFaceAngleLock(true);
        beastSetAngerTick(false);
        postFailureAnger = 0;
        
        if (beastGameStateUpdate)
        {
            beastFaceStateChange("magma cave looking start");
            beastGameStateUpdate = 0;
        }
        
        break;
    
    case "ending":
        beastFaceAngleLock(true);
        beastSetAngerTick(false);
        
        if (beastGameStateUpdate)
        {
            beastFaceStateChange("end glug start");
            beastGameStateUpdate = 0;
        }
        
        break;
}

switch (faceState)
{
    case "wait level 1 anger":
        beastFaceSpriteSet(sBeastPart_FaceGeneralAnger);
        beastBreathe(0.025, 0.005);
        drawBeastFace(0);
        break;
    
    case "wait level 1":
        beastFaceSpriteSet(sBeastPart_FaceWaitLevel1);
        beastBreathe(0.025, 0.005);
        drawBeastFace(0);
        break;
    
    case "wait level 2 start":
        beastFaceSpriteSet(sBeastPart_FaceWaitLevel2_Start);
        beastBreathe(0.05, 0.005);
        
        if (drawBeastFace_AnimLoopEnd(-1, 1))
            beastFaceStateChange("wait level 2");
        
        break;
    
    case "wait level 2":
        beastFaceSpriteSet(sBeastPart_FaceWaitLevel2);
        beastBreathe(0.05, 0.005);
        drawBeastFace(0);
        break;
    
    case "wait level 3 start":
        beastFaceSpriteSet(sBeastPart_FaceWaitLevel3_Start);
        beastBreathe(0.08333333333333333, 0.0075);
        
        if (drawBeastFace_AnimLoopEnd(-1, 1))
        {
            beastFaceStateChange("wait level 3");
            generateBeastEffect("frown breath x2");
        }
        
        break;
    
    case "wait level 3":
        beastFaceSpriteSet(sBeastPart_FaceWaitLevel3);
        beastBreathe(0.08333333333333333, 0.0075);
        drawBeastFace(0);
        break;
    
    case "wait level 4 start":
    case "wait level 4":
        beastFaceSpriteSet(sBeastPart_FaceWaitLevel4_Smooth);
        angerLevel4ratio = clamp((angerLevel4at - angerTimerRatio) / angerLevel4at, 0, 1);
        shrinkScaleOffset = angerLevel4ratio * 0.15;
        var _frameNum = sprite_get_number(sBeastPart_FaceWaitLevel4_Smooth) - 1 - 5;
        var _frame = _frameNum * angerLevel4ratio;
        drawBeastFace(_frame);
        break;
    
    case "wait level 5":
        if (beastFaceStateInitialize())
            shrinkScaleOffset = 0.3;
        
        beastFaceSpriteSet(sBeastPart_FaceWaitLevel4);
        shrinkScaleOffset = lerp(shrinkScaleOffset, 0.1, 0.1);
        drawBeastFace(0);
        break;
    
    case "wait ready":
        shrinkScaleOffset = lerp(shrinkScaleOffset, 0, 0.1);
        beastFaceSpriteSet(sBeastPart_FaceWaitJuiceReady);
        drawBeastFace_AnimLoopEnd(0.2, -1);
        break;
    
    case "anger flash":
        if (faceStateInit)
        {
            shrinkScaleOffset = 0.15;
            faceStateInit = 0;
            playSoundBeastAnger();
        }
        
        timeScaleChange(0, 1, 1);
        var _rectLeft = getViewx(global.cam);
        var _rectTop = getViewy(global.cam);
        var _rectRight = _rectLeft + global.viewWidth;
        var _rectBottom = _rectTop + global.viewHeight;
        angerFlashDarkAlpha = approach(angerFlashDarkAlpha, 0.75, 0.3);
        draw_set_color(make_color_rgb(46, 50, 59));
        draw_set_alpha(angerFlashDarkAlpha);
        draw_rectangle(_rectLeft, _rectTop, _rectRight, _rectBottom, 0);
        draw_set_alpha(1);
        
        if (faceStateTimer > 0.2)
            beastFlash = beastAnimCurveStepAndGet(curveAngerFlashTwice, "curve1", 1/30);
        
        beastFaceSpriteSet(sBeastPart_FaceWaitLevel5);
        shrinkScaleOffset = lerp(shrinkScaleOffset, 0.2, 0.2);
        
        if (beastFlash > 0)
            shader_set_track(shaderWhiteFlash);
        
        drawBeastFace(0);
        shader_reset_track();
        
        if (beastFaceStateTimer(78))
        {
            beastFaceStateChange("anger burst");
            shrinkScaleOffset = 0.2;
            instance_create_layer(beastBasex, beastBasey, "control", oBeastFireEffect);
            playSoundBeastFlames();
        }
        
        break;
    
    case "anger burst":
        var _shrinkGoal = 0.075;
        shrinkScaleOffset = lerp(shrinkScaleOffset, _shrinkGoal, 0.3);
        beastFaceSpriteSet(sBeastPart_FaceWaitLevel4_Burst);
        drawBeastFace(0);
        drawSetInterpolation(false);
        draw_sprite_ext(faceSprite, 1, faceDrawx, faceDrawy, faceXscale, faceYscale, image_angle, c_white, image_alpha);
        drawSetInterpolation(true);
        
        if (beastFaceStateTimer(120))
        {
            beastFaceStateChange("post anger breather");
            shrinkScaleOffset = _shrinkGoal;
        }
        
        break;
    
    case "post anger breather":
        _shrinkGoal = 0;
        shrinkScaleOffset = lerp(shrinkScaleOffset, _shrinkGoal, 0.075);
        beastFaceSpriteSet(sBeastPart_FacePostAngerBreather);
        drawBeastFace_AnimLoopEnd(0.12, 1);
        
        if (beastFaceStateTimer(120))
        {
            beastGameStateChange("waiting");
            breatheValue = 0;
            shrinkScaleOffset = _shrinkGoal;
        }
        
        break;
    
    case "breather into wait level 1":
        shrinkScaleOffset = lerp(shrinkScaleOffset, 0, 0.1);
        beastFaceSpriteSet(sBeastPart_FaceGeneralAnger);
        drawBeastFace(0);
        
        if (beastFaceStateTimer(30))
        {
            beastGameStateChange("waiting");
            breatheValue = 0;
        }
        
        break;
    
    case "glug start":
        beastFaceSpriteSet(sBeastPart_FaceGlug_Start);
        
        if (drawBeastFace_AnimLoopEnd(-1, 1))
            beastFaceStateChange("glug receive");
        
        break;
    
    case "glug receive":
        shrinkScaleOffset = lerp(shrinkScaleOffset, 0, 0.2);
        beastFaceSpriteSet(sBeastPart_FaceGlug_Receiving);
        drawBeastFace(0);
        
        if (!instance_exists(oJuiceHomingParticleEmitter))
        {
            if (beastFaceStateTimer(9))
                beastFaceStateChange("glug close");
        }
        
        break;
    
    case "glug close":
        beastFaceSpriteSet(sBeastPart_FaceGlug_Close);
        
        if (drawBeastFace_AnimLoopEnd(-1, 1))
        {
            beastFaceStateChange("glug taste");
            playSoundBeastEatFinish();
        }
        
        break;
    
    case "glug taste":
        beastFaceSpriteSet(sBeastPart_FaceGlug_Taste);
        drawBeastFace_AnimLoopEnd(-1, -1);
        
        if (beastFaceStateTimer(60))
            beastFaceStateChange("glug delicious start");
        
        break;
    
    case "glug delicious start":
        springWobbleValue = lerp(springWobbleValue, -2, 0.1);
        shrinkScaleOffset = (1 - springWobbleValue) * 0.025;
        beastFaceSpriteSet(deliciousFaceArray[0]);
        
        if (drawBeastFace_AnimLoopEnd(0.2, 1))
        {
            beastFaceStateChange("glug delicious");
            generateBeastEffect("delicious sparkle");
            playSoundEndingBeastDeliciousSparkle();
        }
        
        break;
    
    case "glug delicious":
        var _tension = 0.4;
        var _dampening = 0.25;
        var _displacement = 1 - springWobbleValue;
        springWobbleSpeed += ((_displacement * _tension) - (_dampening * springWobbleSpeed));
        springWobbleValue += springWobbleSpeed;
        shrinkScaleOffset = (1 - springWobbleValue) * 0.1;
        beastFaceSpriteSet(deliciousFaceArray[1]);
        drawBeastFace_AnimLoopEnd(0.2, deliciousFaceArray[2]);
        
        if (beastFaceStateTimer(120))
        {
            if (beastGameState != "ready")
            {
                beastGameStateChange("waiting");
            }
            else
            {
                beastFaceStateChange("wait ready");
                recipeStateChange("ready");
            }
        }
        
        break;
    
    case "magma cave looking start":
        beastFaceSpriteSet(sBeastPart_FaceMagmaSwitchRoomLookAround_Start);
        
        if (drawBeastFace_AnimLoopEnd(0.15, 1))
            beastFaceStateChange("magma cave looking");
        
        break;
    
    case "magma cave looking":
        beastFaceSpriteSet(sBeastPart_FaceMagmaSwitchRoomLookAround);
        
        if (drawBeastFace_AnimLoopEnd(0.15, -1) && switchRoomEntered)
            beastFaceStateChange("magma looking at switch");
        
        break;
    
    case "magma looking at switch":
        beastFaceSpriteSet(sBeastPart_FaceMagmaSwitchLook);
        drawBeastFace_AnimLoopEnd(0.15, 1);
        break;
    
    case "magma switch case stomped":
        beastFaceSpriteSet(sBeastPart_FaceMagmaSwitch_closeThenOpenOneEye);
        drawBeastFace_AnimLoopEnd(0.2, 1);
        break;
    
    case "magma switch case shattered":
        beastFaceSpriteSet(sBeastPart_FaceMagmaSwitchShattered);
        
        if (drawBeastFace_AnimLoopEnd(0.2, 1))
            beastFaceStateChange("magma switch case shattered - worried blinks");
        
        break;
    
    case "magma switch case shattered - worried blinks":
        beastFaceSpriteSet(sBeastPart_FaceMagmaSwitch_WorriedBlinks);
        drawBeastFace_AnimLoopEnd(0.2, -1);
        break;
    
    case "magma shaking":
        if (beastFaceStateInitialize())
            generateBeastEffect("worried sweat");
        
        beastFaceSpriteSet(sBeastPart_FaceMagmaSwitchActivated_Shaking);
        drawBeastFace_AnimLoopEnd(0.15, 1);
        break;
    
    case "magma rising":
        beastFaceSpriteSet(sBeastPart_FaceMagmaRise);
        drawBeastFace_AnimLoopEnd(0.15, -1);
        break;
    
    case "magma look at star above":
        beastFaceSpriteSet(sBeastPart_FaceWaitJuiceReady);
        drawBeastFace_AnimLoopEnd(0.2, -1);
        break;
    
    case "magma glug start":
        beastFaceSpriteSet(sBeastPart_FaceGlug_Start);
        
        if (drawBeastFace_AnimLoopEnd(0.1, 1))
            beastFaceStateChange("magma glug receive");
        
        break;
    
    case "magma glug receive":
        shrinkScaleOffset = lerp(shrinkScaleOffset, 0, 0.2);
        beastFaceSpriteSet(sBeastPart_FaceGlug_Receiving);
        drawBeastFace(0);
        break;
    
    case "magma glug close":
        beastFaceSpriteSet(sBeastPart_FaceGlug_Close);
        
        if (drawBeastFace_AnimLoopEnd(0.1, 1))
            beastFaceStateChange("magma glug taste");
        
        break;
    
    case "magma glug taste":
        if (beastFaceStateInitialize())
            playSoundBeastStarFruitChew();
        
        beastFaceSpriteSet(sBeastPart_FaceGlug_Taste);
        drawBeastFace_AnimLoopEnd(-1, -1);
        
        if (beastFaceStateTimer(90))
            beastFaceStateChange("magma glug delicious start");
        
        break;
    
    case "magma glug delicious start":
        if (beastFaceStateInitialize())
        {
        }
        
        springWobbleValue = lerp(springWobbleValue, -2, 0.1);
        shrinkScaleOffset = (1 - springWobbleValue) * 0.025;
        beastFaceSpriteSet(sBeastPart_FaceGlug_Delicious_Start);
        drawBeastFace(0);
        
        if (beastFaceStateTimer(60))
        {
            beastFaceStateChange("magma glug delicious");
            generateBeastEffect("super delicious sparkle");
            sequenceProceeded = 0;
        }
        
        break;
    
    case "magma glug delicious":
        if (beastFaceStateInitialize())
            playSoundEndingBeastDeliciousSparkle();
        
        _tension = 0.4;
        _dampening = 0.25;
        _displacement = 1 - springWobbleValue;
        springWobbleSpeed += ((_displacement * _tension) - (_dampening * springWobbleSpeed));
        springWobbleValue += springWobbleSpeed;
        shrinkScaleOffset = (1 - springWobbleValue) * 0.1;
        beastFaceSpriteSet(sBeastPart_FaceGlug_Delicious);
        drawBeastFace(0);
        
        if (beastFaceStateTimer(60) && !sequenceProceeded)
        {
            sequenceProceeded = 1;
            
            with (oShootIntoSpace)
                sequenceTimer = 1;
        }
        
        break;
    
    case "end glug start":
        beastFaceSpriteSet(sBeastPart_FaceGlug_Start);
        
        if (drawBeastFace_AnimLoopEnd(-1, 1))
        {
            beastFaceStateChange("end glug receive");
            playSoundBeastStarFruitEatOpen();
        }
        
        break;
    
    case "end glug receive":
        shrinkScaleOffset = lerp(shrinkScaleOffset, 0, 0.2);
        beastFaceSpriteSet(sBeastPart_FaceGlug_Receiving);
        drawBeastFace(0);
        
        if (!instance_exists(oJuiceHomingParticleEmitter))
        {
            if (beastFaceStateTimer(90))
            {
                beastFaceStateChange("end glug close");
                playSoundBeastStarFruitEatClose();
            }
        }
        
        break;
    
    case "end glug close":
        beastFaceSpriteSet(sBeastPart_FaceGlug_Close);
        
        if (drawBeastFace_AnimLoopEnd(-1, 1))
        {
            beastFaceStateChange("end glug taste");
            playSoundBeastStarFruitChew();
        }
        
        break;
    
    case "end glug taste":
        beastFaceSpriteSet(sBeastPart_FaceGlug_Taste);
        drawBeastFace_AnimLoopEnd(-1, -1);
        
        if (beastFaceStateTimer(180))
            beastFaceStateChange("end glug delicious start");
        
        break;
    
    case "end glug delicious start":
        springWobbleValue = lerp(springWobbleValue, -2, 0.1);
        shrinkScaleOffset = (1 - springWobbleValue) * 0.025;
        beastFaceSpriteSet(sBeastPart_FaceGlug_Delicious_Start);
        drawBeastFace(0);
        
        if (beastFaceStateTimer(30))
        {
            beastFaceStateChange("end glug delicious");
            generateBeastEffect("super delicious sparkle");
        }
        
        break;
    
    default:
        break;
}

if (keyboard_check_pressed(ord("8")))
{
    var _offsety = -abs(beastDrawy - getViewy());
    beastEffect(sStarFruit_00, 0, _offsety, 0, 0.1, 0, 0, 1, 1, 0, 0.8, 3600, 2);
}
