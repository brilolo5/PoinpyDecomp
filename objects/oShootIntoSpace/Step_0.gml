magmaVolumeDown = function(arg0)
{
    with (oMagma)
        audioSetVolumeTarget(_magmaSound, 0.5, arg0);
};

var _viewx = getViewx(global.cam);
var _viewy = getViewy(global.cam);
y = oCamera.y;

switch (sequenceIndex)
{
    case "initial pause":
        if (sequenceInitialize())
            loadInTimer = 60;
        
        if (loadInTimer > 0)
        {
            loadInTimer -= doDelta(1);
            
            if (loadInTimer <= 0)
            {
                TextureManagerGoto("final area");
                
                with (oGameBackground)
                    bgArea = UnknownEnum.Value_6;
            }
        }
        
        sequenceTimer += doDelta(0.005555555555555556);
        
        if (sequenceTimer >= 1)
        {
            sequenceIndex = "shake 1";
            sequenceTimer = 0;
            sequenceInit = 1;
            
            with (oInvisWall)
                instance_destroy();
        }
        
        break;
    
    case "shake 1":
        if (sequenceInitialize())
        {
            beastFaceStateChange("magma shaking");
            _rumbleSound = playSoundMagmaLaunchSequence();
        }
        
        sequenceTimer += doDelta(0.004166666666666667);
        var _flarey = getViewy(global.cam) + global.viewHeight;
        magmaParticleSpawnTimer += (global.timeScale / 18);
        
        if (magmaParticleSpawnTimer > 1)
        {
            magmaParticleSpawnTimer -= 1;
            var _widthCut = 96;
            var _flarePosx = lerp(bbox_left + _widthCut, bbox_right - _widthCut, (sin(global.timeScaledTime * 16541) + 1) / 2);
            generateEffect(_flarePosx, _flarey, "magma flare", 90 + random_range(-45, 45));
        }
        
        screenShake(1, 2);
        
        if (sequenceTimer >= 1)
        {
            sequenceIndex = "launch";
            sequenceTimer = 0;
            sequenceInit = 1;
            instance_create_depth(x, y + 160, 0, oMagma);
        }
        
        break;
    
    case "launch":
        if (sequenceInitialize())
        {
            beastFaceStateChange("magma rising");
            playSoundMagmaLaunchBurst();
            oPlayer.currentState = "shot into space";
            screenShake(7, 7);
        }
        
        launchSeq_ScrollingUp(scrollSpeedDefault);
        screenShake(0.75, 2);
        sequenceTimer += doDelta(0.004166666666666667);
        
        if (sequenceTimer >= 1)
        {
            sequenceIndex = "launch - bg darken";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "launch - bg darken":
        if (sequenceInitialize())
        {
        }
        
        launchSeq_ScrollingUp(scrollSpeedDefault);
        screenShake(0.75, 2);
        shadeAlpha = sequenceTimer;
        sequenceTimer += doDelta(0.005555555555555556);
        
        if (sequenceTimer >= 1)
        {
            sequenceIndex = "launch - pitch black";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "launch - pitch black":
        if (sequenceInitialize())
        {
        }
        
        launchSeq_ScrollingUp(scrollSpeedDefault);
        screenShake(0.75, 2);
        shadeAlpha = 1;
        sequenceTimer += doDelta(0.005555555555555556);
        
        if (sequenceTimer >= 1)
        {
            sequenceIndex = "launch - twinkle star fall 1";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "launch - twinkle star fall 1":
        if (sequenceInitialize())
        {
            with (oBeastMainGame)
            {
                var _offsety = -abs(beastDrawy - getViewy());
                beastEffect(sStarFruit_00, -48, _offsety, 0, 0.1, 0, 0, 1, 1, 0, 1, 3000, 1);
            }
            
            beastFaceStateChange("magma look at star above");
            playSfxWorld(sfx_ending_magmaStarV2_01);
        }
        
        launchSeq_ScrollingUp(scrollSpeedDefault);
        screenShake(0.75, 2);
        shadeAlpha = 1;
        sequenceTimer += doDelta(0.005555555555555556);
        
        if (sequenceTimer >= 1)
        {
            sequenceIndex = "launch - twinkle star fall 2";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "launch - twinkle star fall 2":
        if (sequenceInitialize())
        {
            playSfxWorld(sfx_ending_magmaStarV2_02);
            beastFaceStateChange("magma look at star above");
            
            with (oBeastMainGame)
            {
                var _offsety = -abs(beastDrawy - getViewy());
                beastEffect(sStarFruit_00, 32, _offsety, 0, 0.1, 0, 0, 1, 1, 0, 1, 3000, 1);
            }
        }
        
        launchSeq_ScrollingUp(scrollSpeedDefault);
        screenShake(0.75, 2);
        shadeAlpha = 1;
        sequenceTimer += doDelta(0.005555555555555556);
        
        if (sequenceTimer >= 1)
        {
            sequenceIndex = "launch - twinkle star fall 3";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "launch - twinkle star fall 3":
        if (sequenceInitialize())
        {
            playSfxWorld(sfx_ending_magmaStarV2_03);
            beastFaceStateChange("magma look at star above");
            
            with (oBeastMainGame)
            {
                var _offsety = -abs(beastDrawy - getViewy());
                beastEffect(sStarFruit_00, 0, _offsety, 0, 0.1, 0, 0, 1, 1, 0, 0.9, 3000, 2);
            }
        }
        
        launchSeq_ScrollingUp(scrollSpeedDefault);
        screenShake(0.75, 2);
        shadeAlpha = 1;
        sequenceTimer += doDelta(0.004761904761904762);
        
        if (sequenceTimer >= 1)
        {
            sequenceIndex = "launch - twinkle stars eat";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "launch - twinkle stars eat":
        if (sequenceInitialize())
        {
            beastFaceStateChange("magma glug start");
            playSoundBeastStarFruitEatOpen();
        }
        
        launchSeq_ScrollingUp(scrollSpeedDefault);
        screenShake(0.75, 2);
        shadeAlpha = 1;
        sequenceTimer += doDelta(1/120);
        
        if (sequenceTimer >= 1)
        {
            sequenceIndex = "launch - twinkle stars mouth close";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "launch - twinkle stars mouth close":
        if (sequenceInitialize())
        {
            beastFaceStateChange("magma glug close");
            playSoundBeastStarFruitEatClose();
        }
        
        launchSeq_ScrollingUp(scrollSpeedDefault);
        screenShake(0.75, 2);
        shadeAlpha = 1;
        
        if (sequenceTimer >= 1)
        {
            sequenceIndex = "launch - moment of clarity";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "launch - moment of clarity":
        if (sequenceInitialize())
        {
            with (oLevelBuilder)
                finalAreaTransition = UnknownEnum.Value_3;
        }
        
        launchSeq_ScrollingUp(scrollSpeedDefault);
        screenShake(0.75, 2);
        sequenceTimer += doDelta(0.041666666666666664);
        
        if (sequenceTimer >= 1)
        {
            sequenceIndex = "launch - bg clear";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "launch - bg clear":
        if (sequenceInitialize())
        {
            with (oLevelBuilder)
                finalAreaTransition = UnknownEnum.Value_3;
        }
        
        oDraw.wallGlow = approach(oDraw.wallGlow, 1, doDelta(0.005555555555555556));
        launchSeq_ScrollingUp(scrollSpeedDefault);
        screenShake(0.75, 2);
        shadeAlpha = 1 - sequenceTimer;
        sequenceTimer += doDelta(0.005555555555555556);
        
        if (sequenceTimer >= 1)
        {
            sequenceIndex = "launch - space view";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "launch - space view":
        if (sequenceInitialize())
        {
            playSoundMagmaLaunchEnd(_rumbleSound);
            beastStateChanged = 0;
        }
        
        oDraw.wallGlow = approach(oDraw.wallGlow, 1, doDelta(0.005555555555555556));
        launchSeq_ScrollingUp(scrollSpeedDefault);
        magmaVolumeDown(240);
        screenShake(0.75, 2);
        
        if (!beastStateChanged && sequenceTimer > 0.5)
        {
            beastStateChanged = 1;
            beastGameStateChange("waiting");
        }
        
        shadeAlpha = 0;
        sequenceTimer += doDelta(0.006666666666666667);
        
        if (sequenceTimer >= 1)
        {
            sequenceIndex = "launch - end?";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        break;
    
    case "launch - end?":
        if (sequenceInitialize())
        {
            with (oLevelBuilder)
                finalAreaTransition = UnknownEnum.Value_4;
        }
        
        instance_activate_object(oSpaceShaftEnd);
        scrollSpeed = scrollSpeedDefault;
        
        if (instance_exists(oSpaceShaftEnd))
        {
            screenShake(1, 3);
            
            if (!startSlowingDown)
                startSlowingDown = 1;
            
            scrollSpeed = min(abs((oSpaceShaftEnd.bbox_top - y) * 0.05), scrollSpeed);
            scrollSpeed = clamp(scrollSpeed, 0.05, 28);
        }
        
        launchSeq_ScrollingUp(scrollSpeed);
        
        if (instance_exists(oSpaceShaftEnd))
        {
            if (y <= (oSpaceShaftEnd.y + 0.5))
            {
                drawFakeWall = 0;
                audioEvent("magma launch sequence - end");
                oPlayer.currentState = "spin jump";
                oPlayer.ysp = -5;
                sequenceIndex = "kill";
                sequenceTimer = 0;
                sequenceInit = 1;
                oCamera.camManualControl = 0;
                playerControlLockRelease();
                sequenceIndex = "final area entered";
            }
        }
        
        break;
    
    case "final area entered":
        if (sequenceInitialize())
        {
            areaTextTimer = 180;
            global.finalStretchSequence = UnknownEnum.Value_3;
            global.finalMixReached = 1;
            instance_create_depth(getViewx(global.cam), getViewy(global.cam), 0, oFinalAreaMusicStarter);
            magmaVolumeDown(60);
        }
        
        with (oBeastMainGame)
            beastForcePos = 0;
        
        areaTextTimer -= 1;
        
        if (areaTextTimer <= 0)
        {
            sequenceIndex = "inactive";
            sequenceTimer = 0;
            sequenceInit = 1;
        }
        
        skipHold = 1;
        break;
    
    case "inactive":
        shadeAlpha = 0;
        
        with (oBeastMainGame)
            beastForcePos = 0;
        
        instance_destroy();
        break;
}
