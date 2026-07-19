playerControlLock();

with (oPlayer)
{
    playerVisible = 0;
    xsp = 0;
    ysp = 0;
    currentState = "null";
}

myAlarm0.tick();
localTime += doDelta(2);
jpDialog = locGetLanguage() == "Japanese";
_updateDialogBoxDimentions();

addToDialogArray = function()
{
    var i = 0;
    
    repeat (argument_count)
    {
        dialogNumber += 1;
        dialogArray[dialogNumber] = argument[i];
        i += 1;
    }
};

_dialogArrayInitialize = function()
{
    dialogNumber = -1;
    dialogIndex = 0;
};

drawTestRainbow = function(arg0, arg1, arg2 = 160, arg3 = 64)
{
    var _width = arg2;
    var _height = arg3;
    var _stripNum = 16;
    var _colorGradeFitIn = 0.5;
    var _stripWidth = _width / _stripNum;
    draw_primitive_begin(pr_trianglestrip);
    
    for (var i = 0; i <= _stripNum; i += 1)
    {
        var _col = getAuroraColor((_colorGradeFitIn / _stripNum) * i, make_color_rgb(255, 255, 255), 0.9, 9999999 - (localTime / 800));
        draw_vertex_color(arg0 + (_stripWidth * i), arg1, _col, 1);
        draw_vertex_color(arg0 + (_stripWidth * i), arg1 + _height, _col, 1);
    }
    
    draw_primitive_end();
};

drawRainbowBeast = function(arg0 = global.windowLeft, arg1 = global.windowBottom / 10, arg2 = 1)
{
    var cr = global.surfaceCompressionRate;
    var _breatheOffset = sin(localTime / 200) * 1.5;
    arg1 += _breatheOffset;
    var _beastSprite = sTestTranscendedBeastFace;
    var _spriteWidth = sprite_get_width(_beastSprite);
    var _spriteHeight = sprite_get_height(_beastSprite);
    var _spriteNumber = sprite_get_number(_beastSprite);
    beastSurfaceW = global.applicationSurfaceDrawWidth * cr;
    beastSurfaceH = (beastSurfaceW / _spriteWidth) * _spriteHeight;
    var _sprScale = beastSurfaceW / sprite_get_width(_beastSprite);
    
    if (!surface_exists(beastSurface))
        beastSurface = surface_create_track(beastSurfaceW, beastSurfaceH);
    
    surface_set_target(beastSurface);
    draw_clear_alpha(c_white, 0);
    draw_clear(c_lime);
    drawTestRainbow(0, 0, beastSurfaceW, beastSurfaceH);
    beastImageIndexTimer += doDelta(0.05555555555555555);
    
    if (beastImageIndexTimer >= 1)
    {
        beastImageIndexTimer -= 1;
        beastImageIndex += irandom_range(1, _spriteNumber - 3);
        beastImageIndex %= (_spriteNumber - 1);
    }
    
    gpu_set_blendmode(bm_subtract);
    draw_sprite_ext(_beastSprite, beastImageIndex, 0, 0, _sprScale, _sprScale, 0, c_white, 1);
    gpu_set_blendmode(bm_normal);
    surface_reset_target();
    drawSetInterpolation(false);
    draw_surface_ext(beastSurface, arg0, arg1, 1 / cr, 1 / cr, 0, c_white, arg2);
    drawSetInterpolation(true);
};

drawFakeRecipeCloud = function(arg0 = 0, arg1 = 1)
{
    var _cloudScale = 0.13;
    fakeRecipeCloudAnimationTimer = approach(fakeRecipeCloudAnimationTimer, 1, doDelta(0.022222222222222223));
    var _cloudScaleFinal = animcurveGetValueAtPos(curveQuartInv, "curve1", fakeRecipeCloudAnimationTimer);
    _cloudScaleFinal *= (_cloudScale * arg1);
    var _drawx = dbCenter;
    var _drawy = dbMiddle;
    _drawx += random_range(-arg0, arg0);
    _drawy += random_range(-arg0, arg0);
    draw_sprite_ext(sUIthoughtCloudWhite, 0, _drawx, _drawy, _cloudScaleFinal, _cloudScaleFinal, 0, c_white, 1);
    draw_sprite_ext(sUIRecipeCloudOutline, 3, _drawx, _drawy, _cloudScaleFinal, _cloudScaleFinal, 0, make_color_rgb(46, 50, 59), 1);
};

switch (sequenceIndex)
{
    case "moment before beast appear":
        if (_sequenceInitialize())
        {
        }
        
        if (_sequenceTimerIncrementAndCheck(60))
            _nextSequence("beast appears");
        
        break;
    
    case "beast appears":
        if (_sequenceInitialize())
        {
        }
        
        beastAlpha = approach(beastAlpha, 1, doDelta(1/120));
        drawRainbowBeast(undefined, undefined, beastAlpha);
        
        if (_sequenceTimerIncrementAndCheck(210))
            _nextSequence("moment before textbox");
        
        break;
    
    case "moment before textbox":
        if (_sequenceInitialize())
        {
            playMusicUI(music_beastDialogLeadIn, 0, 1);
            if (instance_exists(oEndingSequence))
                audioSetVolumeTarget(oEndingSequence._backgroundSound, 0.3, 0.16666666666666666);
        }
        
        drawRainbowBeast(undefined, undefined, beastAlpha);
        
        if (_sequenceTimerIncrementAndCheck(96))
            _nextSequence("dialog");
        
        break;
    
    case "dialog":
        if (_sequenceInitialize())
        {
            dialogMusic = playMusicUI(music_beastDialogLoop, 1, 1);
            textboxAppearAnimationTimer = 1;
            _dialogArrayInitialize();
            addToDialogArray(loc("ending dialog 00 poinpy"), loc("ending dialog 01 thank you"), loc("ending dialog 02 lost control"), loc("ending dialog 03 destroy reality"), loc("ending dialog 04 pause"), loc("ending dialog 05 consciousness"), loc("ending dialog 06 world collapse"), loc("ending dialog 07 turn to nothing"), loc("ending dialog 08 pause"), loc("ending dialog 09 but"), loc("ending dialog 10 even though"), loc("ending dialog 11 meet again"), loc("ending dialog 12 destiny"), loc("ending dialog 13 when we do"), loc("ending dialog 14 feed me again"), loc("ending dialog 15 pause"), loc("ending dialog 16 times end"), loc("ending dialog 17 glad to talk"), loc("ending dialog 18 good bye"));
            _nextText(dialogArray[dialogIndex]);
        }
        
        drawRainbowBeast();
        _drawText();
        _drawProceedSign();
        
        if (_clickToSkipOrClearText())
        {
            if (dialogIndex < dialogNumber)
            {
                dialogIndex += 1;
                _nextText(dialogArray[dialogIndex]);
            }
            else
            {
                _nextSequence("beast disappears");
            }
        }
        
        break;
    
    case "beast disappears":
        if (_sequenceInitialize())
            if (instance_exists(oEndingSequence))
                audioSetVolumeTarget(oEndingSequence._backgroundSound, 1, 0.16666666666666666);
        drawRainbowBeast(undefined, undefined, 1 - sequenceTimer);
        
        if (_sequenceTimerIncrementAndCheck(180))
        {
            _nextSequence("null");
            
            with (oEndingSequence)
                nextSequence("message ended");
        }
        
        break;
    
    case "i love you":
        if (_sequenceInitialize())
        {
            doTheWheel = 0;
            _dialogArrayInitialize();
            addToDialogArray(loc("ending dialog 19 thank you"), loc("ending dialog 20 i love you"));
            _nextText(dialogArray[dialogIndex]);
        }
        
        _drawText(0);
        _drawProceedSign();
        
        if (_clickToSkipOrClearText())
        {
            if (dialogIndex < dialogNumber)
            {
                dialogIndex += 1;
                _nextText(dialogArray[dialogIndex]);
            }
            else
            {
                _nextSequence("moment before credit");
            }
        }
        
        break;
    
    case "moment before credit":
        if (_sequenceInitialize())
        {
        }
        
        if (_sequenceTimerIncrementAndCheck(240))
        {
            with (oEndingSequence)
                jumpToRoom = rmEnding;
        }
        
        break;
    
    default:
        break;
}

scribble_anim_wheel(0.5, 0.3, 0.05);
