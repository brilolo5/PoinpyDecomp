function beastDrawFunctions()
{
}

function beastBreathe(arg0, arg1)
{
    breatheSpeed = deltaLerp(breatheSpeed, arg0, 0.1);
    breatheValue += doDelta(breatheSpeed);
    breatheScale = arg1;
    var _breathe = sin(breatheValue) * breatheScale;
    shrinkScaleOffset = _breathe;
}

function beastScaling()
{
    baseShrinkScale = 1 + shrinkScaleOffset;
    beastXscale = 0.1;
    beastYscale = 0.1;
    beastXscale *= baseShrinkScale;
    beastYscale *= baseShrinkScale;
}

function beastFaceAngleLock(arg0)
{
    faceAngleLock = arg0;
}

function beastShake(arg0, arg1)
{
    with (oBeastMainGame)
    {
        beastShakeTime = arg0;
        beastShakeAmount = arg1;
    }
}

function beastPositioning()
{
    beastBasex = getViewx(global.cam) + (global.viewWidth / 2);
    beastBasey = ((((getViewy(global.cam) + global.viewHeight) - 0 - 8 - 10 - 32) + 8) - 2 - 2) + 8;
    
    if (beastShakeTime > 0)
    {
        beastShakeTime -= doDelta(1);
        var _shake = random_range(-beastShakeAmount, beastShakeAmount);
        beastBasex += _shake;
        _shake = random_range(-beastShakeAmount, beastShakeAmount);
        beastBasey += _shake;
    }
    
    beastyTween = clamp(deltaLerp(beastyTween, beastBasey, 0.5), beastBasey - 8, beastBasey + 96);
    beastDrawy = beastyTween + ((baseShrinkScale - 1) * -32) + enterIntroOffsety;
    
    if (beastForcePos > 0)
    {
        beastDrawy = beastForcePosy;
    }
    else if (instance_exists(oMagma))
    {
        var _aboveMagma = lerp(beastDrawy, oMagma.y - 32 - 8, 0.75);
        beastDrawy = min(beastDrawy, _aboveMagma);
    }
    
    var _centerx = global.viewWidth / 2;
    var _playerxOffsetRate = (oPlayer.x - _centerx) / _centerx;
    faceAngleLock = 1;
    
    if (faceAngleLock)
        _playerxOffsetRate = 0;
    
    faceAngle_xOffsetRateTween = deltaLerp(faceAngle_xOffsetRateTween, _playerxOffsetRate, 0.1);
    var _xOffset = faceAngle_xOffsetRateTween * 3;
    var _middley = global.viewHeight / 2;
    var _playerRelativey = oPlayer.y - getViewy(global.cam);
    var _yOffset = abs(sin((faceAngle_xOffsetRateTween * 0.15) + pi) * 8);
    faceXscale = beastXscale;
    faceYscale = beastYscale;
    faceDrawx = beastBasex + _xOffset;
    faceDrawy = beastDrawy + _yOffset;
}

function drawBeastBody(arg0 = sBeastPart_Body)
{
    if (drawBody)
    {
        texture_set_interpolation(false);
        draw_sprite_ext(arg0, 0, beastBasex, beastDrawy, beastXscale, beastYscale, image_angle, c_white, image_alpha);
        draw_sprite_ext(arg0, 0, beastBasex, beastDrawy, -beastXscale, beastYscale, image_angle, c_white, image_alpha);
        drawSetInterpolation(true);
    }
}

function drawBeastEar()
{
    if (drawEar)
    {
        drawSetInterpolation(false);
        draw_sprite_ext(earSprite, 0, beastBasex, beastDrawy, beastXscale, beastYscale, image_angle, c_white, image_alpha);
        draw_sprite_ext(earSprite, 0, beastBasex, beastDrawy, -beastXscale, beastYscale, image_angle, c_white, image_alpha);
        drawSetInterpolation(true);
    }
}

function drawBeastFace_AnimLoopEnd(arg0, arg1)
{
    beastScaling();
    beastPositioning();
    drawBeastBody();
    drawBeastEar();
    var animOver = false;
    
    if (!ds_map_exists(global.animDataMap, faceSprite))
        addToAnimDataMap(faceSprite);
    
    if (arg0 == -1)
        arg0 = sprite_get_speed(faceSprite);
    
    faceAnimFrame += doDelta(arg0);
    faceImageIndex = animFrameToIndex(faceSprite, faceAnimFrame);
    
    if (animFrameNumber(faceSprite) <= 1)
        faceAnimLoopCount += arg0;
    
    if (p_faceImageIndex > faceImageIndex)
        faceAnimLoopCount += 1;
    
    if (arg1 != -1 && faceAnimLoopCount >= arg1)
    {
        faceImageIndex = sprite_get_number(faceSprite) - 1;
        animOver = true;
    }
    else
    {
        p_faceImageIndex = faceImageIndex;
        
        if (faceImageIndex == (sprite_get_number(faceSprite) - 1))
            animOver = true;
    }
    
    draw_sprite_ext(faceSprite, faceImageIndex, faceDrawx, faceDrawy, faceXscale, faceYscale, image_angle, c_white, image_alpha);
    drawBeastEffect();
    return animOver;
}

function drawBeastFace(arg0)
{
    beastScaling();
    beastPositioning();
    drawBeastBody();
    drawBeastEar();
    draw_sprite_ext(faceSprite, arg0, faceDrawx, faceDrawy, faceXscale, faceYscale, image_angle, c_white, image_alpha);
    drawBeastEffect();
}

function beastFaceStateInit()
{
    faceStateTimer = 0;
    faceAnimFrame = 0;
    faceAnimLoopCount = 0;
    faceImageIndex = 0;
    p_faceImageIndex = faceImageIndex;
    beastStateInitialize = 1;
    faceStateInit = 1;
    shrinkAnimCurve = -1;
}

function beastFaceStateChange(arg0)
{
    with (oBeastMainGame)
    {
        faceState = arg0;
        beastFaceStateInit();
    }
}

function beastFaceSpriteSet(arg0)
{
    faceSprite = arg0;
    
    if (pFaceSprite != faceSprite)
        pFaceSprite = faceSprite;
}

function beastFaceStateTimer(arg0)
{
    var _timerOver = 0;
    faceStateTimer += doDelta(1 / arg0);
    
    if (faceStateTimer >= 1)
    {
        faceStateTimer = 0;
        _timerOver = 1;
    }
    
    return _timerOver;
}

function beastAnimCurveStepAndGet(arg0, arg1, arg2)
{
    if (shrinkAnimCurve != animcurve_get(arg0))
    {
        shrinkAnimCurve = animcurve_get(arg0);
        shrinkAnimCurvePos = 0;
    }
    
    shrinkAnimCurveChannel = animcurve_get_channel(shrinkAnimCurve, "curve1");
    shrinkAnimCurvePos = approach(shrinkAnimCurvePos, 1, doDelta(arg2));
    var _animCurveValue = animcurve_channel_evaluate(shrinkAnimCurveChannel, shrinkAnimCurvePos);
    return _animCurveValue;
}

function beastGameStateChange(arg0)
{
    with (oBeastMainGame)
    {
        beastGameState = arg0;
        beastGameStateUpdate = 1;
        p_waitStateLevel = -1;
        beastEffectClear();
    }
}

function beastSetAngerTick(arg0)
{
    with (oOrderControl)
        beastAngerTick = arg0;
}

function beastEffectClear()
{
    if (ds_exists(effectMap, ds_type_map))
        ds_map_clear(effectMap);
}

function beastFaceStateInitialize()
{
    if (beastStateInitialize)
    {
        beastStateInitialize = 0;
        return true;
    }
    else
    {
        return false;
    }
}

function getBeastDelicousFaceSet(arg0)
{
    var _variationCount = 6;
    arg0 %= 6;
    var _faceSet;
    _faceSet[0] = sBeastPart_FaceGlug_DeliciousA_Start;
    _faceSet[1] = sBeastPart_FaceGlug_DeliciousA;
    _faceSet[2] = -1;
    return _faceSet;
}

function drawBeastEffect()
{
    var _effectMapSize = ds_map_size(effectMap);
    var _mapIndex = ds_map_find_first(effectMap);
    
    for (var i = 0; i <= _effectMapSize; i += 1)
    {
        if (is_undefined(_mapIndex))
            break;
        
        var _map = effectMap[? _mapIndex];
        var _nextMapIndex = ds_map_find_next(effectMap, _mapIndex);
        
        if (_map.isStar)
        {
            with (_map)
            {
                if (isStar == 1)
                    ysp += doDelta(0.015);
                
                angle += doDelta(-0.2);
                var _drawx = root.beastBasex + x;
                var _drawy = root.beastDrawy + y;
                var _sprite = sUI160circle;
                var _spriteWidth = sprite_get_width(_sprite);
                var _radius = 24;
                var _spriteScale = _radius / _spriteWidth;
                var _drawOrNot = (global.time % 8) == 0;
                
                if (isStar == 2)
                    _drawOrNot = (global.time % 16) == 0;
                
                if (_drawOrNot)
                {
                    draw_sprite_ext(sUI160circle, 0, _drawx, _drawy, _spriteScale, _spriteScale, 0, c_white, 1);
                    root.beastEffect(sBeastPart_FxSparkle00, x, y - 8, 0.4, 0.05, 0, 0, 1, 1, 0, 0.2);
                }
            }
        }
        
        _map._draw();
        _map._tick();
        
        if (_map._checkDestroy())
            ds_map_delete(effectMap, _mapIndex);
        
        _mapIndex = _nextMapIndex;
    }
}
