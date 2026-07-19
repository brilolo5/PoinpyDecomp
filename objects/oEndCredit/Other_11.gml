if (live_call())
    return global.live_result;

function sequenceTimerIncrementAndCheck(arg0)
{
    sequenceTimer += doDelta(1 / arg0);
    return sequenceTimer >= 1;
}

nextSequence = function(arg0)
{
    currentSequence = arg0;
    sequenceTimer = 0;
    sequenceInit = 0;
};

sequenceInitialize = function()
{
    if (!sequenceInit)
    {
        sequenceInit = 1;
        return true;
    }
};

function springCalc()
{
    tension = 0.4;
    dampening = 0.25;
    displacement = 1 - beastShrinkRate;
    springSpeed += ((displacement * tension) - (dampening * springSpeed));
    beastShrinkRate += springSpeed;
    beastScaley *= beastShrinkRate;
    beastScalex *= beastShrinkRate;
}

function detectMultiTouch(arg0)
{
    if (device_mouse_check_button_pressed(arg0 - 1, mb_left))
        return true;
}

function drawLogo(arg0, arg1)
{
    logoBoingTime = approach(logoBoingTime, 1, doDelta(0.022222222222222223));
    var _scaleOffset = 1 + (0.3 - (0.3 * animcurveGetValueAtPos(curveElasticInv, "curve1", logoBoingTime)));
    var _logoScale = 0.0875 * _scaleOffset * logoScale;
    drawLogoFromParts(logoSprite, arg0, arg1, _logoScale);
}

creditScribble = scribble(creditString).starting_format("fredoka", make_color_rgb(255, 255, 255)).transform(0.5, 0.5, 0).align(1, 0);
creditScribbleHeight = scribble(creditString).get_height() * 0.5;
var _backColor = make_color_rgb(255, 255, 255);

switch (currentSequence)
{
    case "template":
        if (sequenceInitialize())
        {
        }
        
        var _sequenceTime = 60;
        
        if (sequenceTimerIncrementAndCheck(_sequenceTime))
            nextSequence("transitioned from main");
        
        break;
    
    case "color shift":
        if (sequenceInitialize())
        {
        }
        
        var _whiteR = color_get_red(make_color_rgb(255, 255, 255));
        var _whiteG = color_get_green(make_color_rgb(255, 255, 255));
        var _whiteB = color_get_blue(make_color_rgb(255, 255, 255));
        var _greyR = color_get_red(_backColor);
        var _greyG = color_get_green(_backColor);
        var _greyB = color_get_blue(_backColor);
        var _roundBy = 5;
        var _roundSeqTimer = round(sequenceTimer * _roundBy) / _roundBy;
        var _lerpR = lerp(_whiteR, _greyR, _roundSeqTimer);
        var _lerpG = lerp(_whiteG, _greyG, _roundSeqTimer);
        var _lerpB = lerp(_whiteB, _greyB, _roundSeqTimer);
        var _col = make_color_rgb(_lerpR, _lerpG, _lerpB);
        draw_clear(_col);
        _sequenceTime = 120;
        
        if (sequenceTimerIncrementAndCheck(_sequenceTime))
            nextSequence("initial pause");
        
        break;
    
    case "initial pause":
        if (sequenceInitialize())
        {
        }
        
        draw_clear(_backColor);
        _sequenceTime = 60;
        
        if (sequenceTimerIncrementAndCheck(_sequenceTime))
            nextSequence("title appear");
        
        break;
    
    case "title appear":
        if (sequenceInitialize())
        {
            if (!audioAssetIsPlaying(music_logoAppearChord) && partOfEnding)
                playMusicUI(music_logoAppearChord, 0, 1);
            
            playSoundEndingTitleCard();
        }
        
        if (partOfEnding)
            draw_clear(_backColor);
        else
            drawRectangleLTRB(global.windowLeft, global.windowTop, global.windowRight, global.windowBottom, 16777215, 1);
        
        var _textx = global.windowCenterx;
        var _texty = global.windowMiddley + creditScrollY;
        creditScribble.starting_format("fredoka", make_color_rgb(255, 255, 255)).draw(_textx, _texty);
        drawLogo(_textx, _texty);
        _sequenceTime = 60;
        
        if (!partOfEnding)
        {
            if (sequenceTimerIncrementAndCheck(_sequenceTime))
                nextSequence("credit roll");
        }
        else if (!audio_is_playing(music_logoAppearChord))
        {
            creditMusic = playMusicUI(music_creditRollLoop, 1, 1);
            nextSequence("credit roll");
        }
        
        break;
    
    case "credit roll":
        if (sequenceInitialize())
        {
        }
        
        if (partOfEnding)
            draw_clear(_backColor);
        else
            drawRectangleLTRB(global.windowLeft, global.windowTop, global.windowRight, global.windowBottom, 16777215, 1);
        
        _textx = global.windowCenterx;
        _texty = global.windowMiddley + creditScrollY;
        var _border = 32;
        creditScribble.origin(160 - _border, 0).wrap(320 - (_border * 2)).starting_format("fredoka", make_color_rgb(255, 255, 255)).draw(_textx, _texty);
        drawLogo(_textx, _texty);
        var _creditHeight = creditScribbleHeight + 16;
        
        if (mouse_check_button(mb_left))
        {
            scrollHoldBuffer += 1;
            
            if (scrollHoldBuffer >= 5)
                scrollSpeed = approach(scrollSpeed, 20, doDelta(1));
        }
        else
        {
            scrollHoldBuffer = 0;
            scrollSpeed = approach(scrollSpeed, scrollSpeed_default, doDelta(5));
        }
        
        creditScrollY = approach(creditScrollY, -_creditHeight, doDelta(scrollSpeed));
        
        if (abs(creditScrollY) >= _creditHeight || sequenceTimer == 1)
        {
            creditScrollY = -_creditHeight;
            nextSequence("stop");
        }
        
        draw_set_alpha(1);
        break;
    
    case "stop":
        if (sequenceInitialize())
        {
        }
        
        draw_clear(_backColor);
        _textx = global.windowCenterx;
        _texty = global.windowMiddley + creditScrollY;
        creditScribble.starting_format("fredoka", make_color_rgb(255, 255, 255)).draw(_textx, _texty);
        _sequenceTime = 0;
        
        if (sequenceTimerIncrementAndCheck(_sequenceTime))
        {
            if (partOfEnding)
            {
                audioFadeOut(creditMusic, 0.001282051282051282);
                musicFading = 1;
                instance_create_depth(x, y, 0, oEnding_PostEndCutscene);
                instance_destroy();
            }
            else
            {
                playSoundAbilityEquipMenuSelect();
                instance_destroy();
                
                with (instance_create_depth(0, 0, 0, oSettingsMenu))
                    returnedTo = 1;
            }
        }
        
        break;
}

global.playerControlLock = 1;
global.playerControlLockReleaseTimer = 4;
