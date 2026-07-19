var _i;
playSoundCapsulesIn();
global.mainGamePaused = 1;
global.playerControlLock = 1;
global.playerControlLockReleaseTimer = 0;
var _rootInstance = id;
wheelIndex = 0;
wheelTotalIndex = 0;
wheelAngle = 0;
wheelAngleTarget = 0;
wheelCount = 0;
wheelData = [];
availableColours = [make_color_rgb(36, 145, 249), make_color_rgb(65, 231, 125), make_color_rgb(255, 233, 1), make_color_rgb(248, 45, 97)];

wheelItemClass = function(arg0) constructor
{
    static tick = function(arg0)
    {
        dropTime = min(1, dropTime + doDelta(0.029411764705882353));
        dropY = animcurve_tween(-15, 0, curveBounceInv, dropTime);
        
        if (rootInstance.wheelData[rootInstance.wheelIndex] == self)
        {
            if (uiGet("shop get") != global.__uiNullElement && uiGet("shop get").secondStage)
                duckY = deltaLerp(duckY, 8, 0.2);
            else
                duckY = deltaLerp(duckY, 0, 0.2);
            
            duckAngleOffset = deltaLerp(duckAngleOffset, 0, 0.2);
        }
        else
        {
            duckY = deltaLerp(duckY, 0, 0.2);
            
            if (uiGet("shop get") != global.__uiNullElement && uiGet("shop get").secondStage)
            {
                var _duckAngleOffsetTarget = 30 * sign(angle_difference(90, angle + rootInstance.wheelAngle));
                duckAngleOffset = deltaLerp(duckAngleOffset, _duckAngleOffsetTarget, 0.2);
            }
            else
            {
                duckAngleOffset = deltaLerp(duckAngleOffset, 0, 0.2);
            }
        }
        
        x = lengthdir_x(1, angle + duckAngleOffset + rootInstance.wheelAngle);
        y = lengthdir_y(1, angle + duckAngleOffset + rootInstance.wheelAngle);
        scale = lerp(0.464, 1, 0.5 + (0.5 * y));
        itemScale = lerp(0.464, 1, 0.3 + (0.7 * y));
        shadow = lerp(0.26, 0, 0.5 + (0.5 * y));
    };
    
    static draw = function(arg0, arg1, arg2, arg3)
    {
        var _x = arg0 + ((x * arg2) / 2);
        var _y = arg1 + ((y * arg3) / 2) + dropY + duckY;
        var _scale = 0.2 * scale;
        var _itemScale = 0.2 * itemScale;
        var _colour = merge_colour(c_white, make_color_rgb(46, 50, 59), shadow);
        var _colour_front = merge_colour(colour, make_color_rgb(46, 50, 59), shadow);
        var _colour_back = merge_colour(colour_dimmed, make_color_rgb(46, 50, 59), shadow);
        draw_sprite_ext(ballSprite, 0, _x, _y, _scale, _scale, 0, _colour_back, 1);
        draw_sprite_ext(ballSprite, 1, _x, _y, _scale, _scale, 0, _colour, 1);
        draw_sprite_ext(sprite, 0, _x, _y, _itemScale, _itemScale, 0, _colour, 1);
        draw_sprite_ext(ballSprite, 2, _x, _y, _scale, _scale, 0, _colour_front, 1);
    };
    
    abilityIndex = arg0;
    sprite = global.upgradeIcon[| abilityIndex];
    scale = 0;
    itemScale = 0;
    angle = 0;
    x = 0;
    y = 0;
    dropTime = 0;
    dropY = 0;
    duckDo = false;
    duckY = 0;
    duckAngleOffset = 0;
    var _index = irandom(array_length(other.availableColours) - 1);
    var _colour = other.availableColours[_index];
    array_delete(other.availableColours, _index, 1);
    colour = _colour;
    colour_dimmed = merge_color(colour, c_white, 0.2);
    var _colourName = "Red";
    
    if (colour == make_color_rgb(248, 45, 97))
        _colourName = "Red";
    
    if (colour == make_color_rgb(36, 145, 249))
        _colourName = "Blue";
    
    if (colour == make_color_rgb(255, 233, 1))
        _colourName = "Yellow";
    
    if (colour == make_color_rgb(65, 231, 125))
        _colourName = "Green";
    
    ballSprite = sGachaBallWhite;
    ballOpenSprite = sGachaBallWhite_Open;
};

random_set_seed(2048);
var _randomPickArray = get3RandomizedAbility();
var _randomPickArrayLength = array_length(_randomPickArray);

for (var i = 0; i < _randomPickArrayLength; i++)
    array_set(wheelData, i, new wheelItemClass(_randomPickArray[i]));

wheelCount = array_length(wheelData);
var _incr = 360 / wheelCount;
var _angle = 270;
_i = 0;

repeat (wheelCount)
{
    with (wheelData[_i])
    {
        dropTime = (0.09 * _i) + random(0.11);
        rootInstance = _rootInstance;
        angle = _angle;
        tick();
    }
    
    _angle += _incr;
    _i++;
}

with (uiCreate("shop root"))
{
    uiTemplateRectangle(make_color_rgb(46, 50, 59), 0.7);
    eventAddFunction(UnknownEnum.Value_0, function()
    {
        setLTRBToWindow();
    });
    updateShape();
    
    focusRight = function()
    {
        with (rootInstance)
        {
            wheelIndex = (wheelIndex + 1 + wheelCount) % wheelCount;
            wheelTotalIndex++;
            wheelAngleTarget = (-wheelTotalIndex * 360) / wheelCount;
        }
    };
    
    focusLeft = function()
    {
        with (rootInstance)
        {
            wheelIndex = ((wheelIndex - 1) + wheelCount) % wheelCount;
            wheelTotalIndex--;
            wheelAngleTarget = (-wheelTotalIndex * 360) / wheelCount;
        }
    };
    
    with (newChild(undefined, "shop first page group"))
    {
        setX(0.5 * getParent().getShapeWidth());
        setY(0.16 * getParent().getShapeHeight());
        textElement = scribble("[scale,0.8]" + loc("gacha pick one")).align(1, 1).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).scale_to_box(getParent().getShapeWidth() - 20, -1).msdf_border(make_color_rgb(46, 50, 59), 3);
        setWidth(textElement.get_width());
        setHeight(textElement.get_height());
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            textElement.draw(getDrawX(), getDrawY());
        });
    }
    
    with (newChild("shop wheel", "shop first page group"))
    {
        setX(0.5 * getParent().getShapeWidth());
        setWidth(0.66 * getParent().getShapeWidth());
        setBottom((0.45 * getParent().getShapeHeight()) - 30);
        setHeight(0.25 * getRawWidth());
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            var _count, _orderArray;
            
            with (rootInstance)
            {
                wheelAngle = approach(wheelAngle, wheelAngleTarget, doDelta(3));
                wheelAngle = deltaLerp(wheelAngle, wheelAngleTarget, 0.16);
                _i = 0;
                
                repeat (array_length(wheelData))
                {
                    wheelData[_i].tick();
                    _i++;
                }
                
                _count = array_length(wheelData);
                _orderArray = array_create(_count);
                array_copy(_orderArray, 0, wheelData, 0, _count);
                array_sort(_orderArray, function(arg0, arg1)
                {
                    return arg0.y - arg1.y;
                });
            }
            
            _i = 0;
            
            repeat (_count)
            {
                with (_orderArray[_i])
                    draw(other.getDrawX(), other.getDrawY(), other.getDrawWidth(), other.getDrawHeight());
                
                _i++;
            }
        });
    }
    
    with (newChild(undefined, "shop first page group"))
    {
        setX(0.5 * getParent().getShapeWidth());
        setTop(0.45 * getParent().getShapeHeight());
        setWidth(min(getParent().getShapeWidth() - 30, 130));
        setHeight(0.1 * sprite_get_height(sGacha3SliceLabel));
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            var _ballData = rootInstance.wheelData[rootInstance.wheelIndex];
            var _ability = _ballData.abilityIndex;
            var _duckY = _ballData.duckY;
            var _colour = _ballData.colour;
            drawThreeSliceExt(sGacha3SliceLabel, getDrawLeft(), getDrawRight(), getDrawTop() + _duckY, 0.1, 16777215, 1);
            drawThreeSliceExt(sGacha3SliceLabelBorder, getDrawLeft(), getDrawRight(), getDrawTop() + _duckY, 0.1, _colour, 1);
            var _textElement = scribble("[scale,0.4]" + loc(abilityGetIndexName(_ability) + " desc")).starting_format(locGetFontFromLanguage(), make_color_rgb(46, 50, 59)).fit_to_box(getRawWidth() - 18, getRawHeight() - 12, locIsAsian());
            _textElement.draw(getDrawX() - (_textElement.get_width() / 2), (getDrawY() - (_textElement.get_height() / 2)) + _duckY);
        });
    }
    
    with (newChild("shop get", "shop first page button group"))
    {
        uiTemplateSpriteScaled(sGachaConfirm, 0, 0.2);
        setX(0.5 * getParent().getShapeWidth());
        setTop(0.67 * getParent().getShapeHeight());
        updateShape();
        outTweenDo = false;
        outTweenTime = -0.2;
        selected = false;
        textYTweenTime = 1;
        clickPressTime = -1;
        clickReleaseTime = infinity;
        secondStage = false;
        eventAddFunction(UnknownEnum.Value_4, function()
        {
            if (input_player_source_get() == UnknownEnum.Value_2)
                selected = true;
        });
        eventAddFunction(UnknownEnum.Value_7, function()
        {
            if (selected)
                outCursorClick = false;
            
            selected = false;
        });
        eventAddFunction(UnknownEnum.Value_1, function()
        {
            textYTweenTime = min(1, textYTweenTime + doDelta(0.16666666666666666));
            
            if (outTweenDo)
            {
                outTweenTime += doDelta(0.08333333333333333);
                visYOffset = animcurve_tween(0, global.windowBottom - getShapeTop(), curveCubic, outTweenTime);
            }
        });
        eventAddFunction(UnknownEnum.Value_14, function()
        {
            secondStage = false;
            textYTweenTime = 0;
        });
        eventAddFunction(UnknownEnum.Value_9, function()
        {
            clickReleaseTime = -1;
            clickPressTime = max(0, clickPressTime + 1);
            
            if (!secondStage)
                imageIndex = (clickPressTime < 3) ? 1 : 2;
            else
                imageIndex = (clickPressTime < 3) ? 3 : 4;
        });
        eventAddFunction(UnknownEnum.Value_11, function()
        {
            clickPressTime = -1;
            clickReleaseTime = max(0, clickReleaseTime + 1);
            
            if (!secondStage)
                imageIndex = 0;
            else
                imageIndex = (clickReleaseTime < 1) ? 5 : 2;
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            if (!secondStage)
            {
                playSoundCapsuleGet();
                secondStage = true;
                clickReleaseTime = infinity;
                textYTweenTime = 0;
            }
            else
            {
                playSoundCapsuleConfirm();
                var _abilityIndex = undefined;
                
                with (rootInstance)
                    _abilityIndex = wheelData[wheelIndex].abilityIndex;
                
                abilityUnlock(_abilityIndex);
                saveGame();
                input_consume("menu select");
                uiForEachInGroup("shop root", "shop first page group", function()
                {
                    setVisible(false);
                    setActive(false);
                });
                uiForEachInGroup("shop root", "shop first page button group", function()
                {
                    outTweenDo = true;
                    setVisible(true);
                    setActive(false);
                });
                uiForEachInGroup("shop root", "shop second page group", function()
                {
                    setVisible(true);
                    setActive(true);
                });
                
                with (uiGet("shop fullscreen"))
                    startTime = current_time;
                
                with (uiGet("shop open animation"))
                    initialize();
                
                uiFocusForce("shop fullscreen");
            }
        });
        eventInsertFunction(UnknownEnum.Value_2, 0, function()
        {
            if (selected && (current_time % 600) < 300)
            {
                var _spriteWidth = sprite_get_width(sGachaConfirmHighlight);
                var _spriteHeight = sprite_get_height(sGachaConfirmHighlight);
                var _xscale = getShapeWidth() / _spriteWidth;
                var _yscale = getShapeHeight() / _spriteHeight;
                var _x = getDrawLeft() + (_xscale * sprite_get_xoffset(sGachaConfirmHighlight));
                var _y = getDrawTop() + (_yscale * sprite_get_yoffset(sGachaConfirmHighlight));
                draw_sprite_ext(sGachaConfirmHighlight, 0, _x, _y, spriteXScale * _xscale, spriteYScale * _yscale, 0, make_color_rgb(90, 243, 145), visAlpha);
            }
        });
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            var _y = getDrawY();
            
            switch (imageIndex)
            {
                case 0:
                    _y += -7;
                    break;
                
                case 1:
                    _y += -1;
                    break;
                
                case 2:
                    _y += -2;
                    break;
                
                case 3:
                    _y += 4;
                    break;
                
                case 4:
                    _y += 3;
                    break;
                
                case 5:
                    _y += 1;
                    break;
            }
            
            var _yscale = animcurve_tween(0.1, 1, curveBackInv, textYTweenTime);
            
            if (!secondStage)
            {
                var _textElement = scribble(loc("gacha button get")).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 233, 1)).align(1, 1);
                var _factor = min(1, 55 / _textElement.get_width());
                _textElement.transform(_factor, _yscale * _factor, 0).draw(getDrawX(), _y);
            }
            else
            {
                var _textElement = scribble(loc("gacha button confirm")).starting_format(locGetFontFromLanguage(), make_color_rgb(248, 45, 97)).align(1, 1);
                var _factor = min(1, 55 / _textElement.get_width());
                _textElement.transform(_factor, _yscale * _factor, 0).draw(getDrawX(), _y);
            }
        });
    }
    
    with (newChild(undefined, "shop first page button group"))
    {
        uiTemplateSpriteScaled(sGachaArrow, 0, 0.2);
        spriteXScale = -1;
        setRight(uiGet("shop get").getShapeLeft() - 4 - getParent().getShapeLeft());
        setY(uiGet("shop get").getShapeY());
        outTweenDo = false;
        outTweenTime = -0.6;
        clickPressTime = -1;
        clickReleaseTime = infinity;
        selected = false;
        eventAddFunction(UnknownEnum.Value_4, function()
        {
            if (input_player_source_get() == UnknownEnum.Value_2)
                selected = true;
        });
        eventAddFunction(UnknownEnum.Value_7, function()
        {
            selected = false;
        });
        eventAddFunction(UnknownEnum.Value_1, function()
        {
            if (outTweenDo)
            {
                outTweenTime += doDelta(0.08333333333333333);
                visYOffset = animcurve_tween(0, global.windowBottom - getShapeTop(), curveCubic, outTweenTime);
            }
        });
        eventAddFunction(UnknownEnum.Value_9, function()
        {
            clickReleaseTime = -1;
            clickPressTime = max(0, clickPressTime + 1);
            imageIndex = (clickPressTime < 2) ? 0 : 1;
        });
        eventAddFunction(UnknownEnum.Value_11, function()
        {
            clickPressTime = -1;
            clickReleaseTime = max(0, clickReleaseTime + 1);
            
            if (clickReleaseTime < 2)
                imageIndex = 1;
            else if (clickReleaseTime < 5)
                imageIndex = 2;
            else if (clickReleaseTime < 7)
                imageIndex = 3;
            else
                imageIndex = 0;
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            playSoundCapsulesRotate();
            uiGet("shop root").focusLeft();
            
            with (uiGet("shop get"))
            {
                if (secondStage)
                    textYTweenTime = 0;
                
                secondStage = false;
            }
        });
        eventInsertFunction(UnknownEnum.Value_2, 0, function()
        {
            if (selected && (current_time % 600) < 300)
            {
                var _spriteWidth = sprite_get_width(sGachaArrowHighlight);
                var _spriteHeight = sprite_get_height(sGachaArrowHighlight);
                var _xscale = getShapeWidth() / _spriteWidth;
                var _yscale = getShapeHeight() / _spriteHeight;
                var _x = getDrawLeft() + (_xscale * sprite_get_xoffset(sGachaArrowHighlight));
                var _y = getDrawTop() + (_yscale * sprite_get_yoffset(sGachaArrowHighlight));
                draw_sprite_ext(sGachaArrowHighlight, 0, _x, _y, spriteXScale * _xscale, spriteYScale * _yscale, 0, make_color_rgb(90, 243, 145), visAlpha);
            }
        });
    }
    
    with (newChild(undefined, "shop first page button group"))
    {
        uiTemplateSpriteScaled(sGachaArrow, 0, 0.2);
        setLeft((uiGet("shop get").getShapeRight() + 4) - getParent().getShapeLeft());
        setY(uiGet("shop get").getShapeY());
        outTweenDo = false;
        outTweenTime = -0.5;
        clickPressTime = -1;
        clickReleaseTime = infinity;
        selected = false;
        eventAddFunction(UnknownEnum.Value_4, function()
        {
            if (input_player_source_get() == UnknownEnum.Value_2)
                selected = true;
        });
        eventAddFunction(UnknownEnum.Value_7, function()
        {
            selected = false;
        });
        eventAddFunction(UnknownEnum.Value_1, function()
        {
            if (outTweenDo)
            {
                outTweenTime += doDelta(0.08333333333333333);
                visYOffset = animcurve_tween(0, global.windowBottom - getShapeTop(), curveCubic, outTweenTime);
            }
        });
        eventAddFunction(UnknownEnum.Value_9, function()
        {
            clickReleaseTime = -1;
            clickPressTime = max(0, clickPressTime + 1);
            imageIndex = (clickPressTime < 3) ? 0 : 1;
        });
        eventAddFunction(UnknownEnum.Value_11, function()
        {
            clickPressTime = -1;
            clickReleaseTime = max(0, clickReleaseTime + 1);
            
            if (clickReleaseTime < 3)
                imageIndex = 1;
            else if (clickReleaseTime < 5)
                imageIndex = 2;
            else if (clickReleaseTime < 7)
                imageIndex = 3;
            else
                imageIndex = 0;
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            playSoundCapsulesRotate();
            uiGet("shop root").focusRight();
            
            with (uiGet("shop get"))
            {
                if (secondStage)
                    textYTweenTime = 0;
                
                secondStage = false;
            }
        });
        eventInsertFunction(UnknownEnum.Value_2, 0, function()
        {
            if (selected && (current_time % 600) < 300)
            {
                var _spriteWidth = sprite_get_width(sGachaArrowHighlight);
                var _spriteHeight = sprite_get_height(sGachaArrowHighlight);
                var _xscale = getShapeWidth() / _spriteWidth;
                var _yscale = getShapeHeight() / _spriteHeight;
                var _x = getDrawLeft() + (_xscale * sprite_get_xoffset(sGachaArrowHighlight));
                var _y = getDrawTop() + (_yscale * sprite_get_yoffset(sGachaArrowHighlight));
                draw_sprite_ext(sGachaArrowHighlight, 0, _x, _y, spriteXScale * _xscale, spriteYScale * _yscale, 0, make_color_rgb(90, 243, 145), visAlpha);
            }
        });
    }
    
    with (newChild("shop fullscreen", "shop second page group"))
    {
        setActive(false);
        setLeft(0);
        setTop(0);
        setRight(getParent().getShapeWidth() - 1);
        setBottom(getParent().getShapeHeight() - 1);
        startTime = infinity;
        
        advanceToNextPage = function()
        {
            setActive(false);
            uiForEachInGroup("shop root", "shop third page group", function()
            {
                setVisible(true);
                setActive(true);
            });
            uiFocusForce("shop equip");
        };
        
        eventAddFunction(UnknownEnum.Value_4, function()
        {
        });
        eventAddFunction(UnknownEnum.Value_1, function()
        {
            if (getActive() && (current_time - startTime) > 3150 && uiGet("shop title").getVisible())
                advanceToNextPage();
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
        });
    }
    
    with (newChild("shop open animation", "shop second page group"))
    {
        setVisible(false);
        setX(1);
        setY(1);
        setWidth(1);
        setHeight(1);
        ballData = undefined;
        vibrateX = 0;
        vibrateY = 0;
        vibrateScaleOffset = 0;
        swellScaleOffset = 0;
        slideTweenTime = 0;
        slideY = 0;
        rainbowTweenTime = 0;
        rainbowScale = 0;
        openAnimTime = 0;
        openAnimFrame = -1;
        itemScaleTime = 0;
        itemScale = 1;
        
        initialize = function()
        {
            ballData = rootInstance.wheelData[rootInstance.wheelIndex];
            var _ballData = ballData;
            
            with (uiGet("shop wheel"))
            {
                other.setX((getShapeX() - getParent().getShapeLeft()) + ((_ballData.x * getDrawWidth()) / 2));
                other.setY((getShapeY() - getParent().getShapeTop()) + ((_ballData.y * getDrawHeight()) / 2) + _ballData.dropY + _ballData.duckY);
            }
        };
        
        eventAddFunction(UnknownEnum.Value_1, function()
        {
            if (getVisible())
            {
                if (slideTweenTime < 1)
                {
                    slideTweenTime = min(1, slideTweenTime + doDelta(0.045454545454545456));
                    
                    if (slideTweenTime == 1)
                        openAnimFrame = 0;
                }
                
                slideY = animcurve_tween(0, 34, curveExpo, slideTweenTime);
                var _squishanim_firstVibration = 35;
                var _squishanim_pause1 = 1;
                var _squishanim_slightTwitch = 1;
                var _squishanim_pause2 = 1;
                var _squishanim_bigShrink = 2;
                _squishanim_pause1 += _squishanim_firstVibration;
                _squishanim_slightTwitch += _squishanim_pause1;
                _squishanim_pause2 += _squishanim_slightTwitch;
                _squishanim_bigShrink += _squishanim_pause2;
                var _openanim_squish = _squishanim_bigShrink;
                var _openanim_pop1 = 3;
                var _openanim_pop2 = 45;
                var _openanim_disappear = 24;
                _openanim_pop1 += _openanim_squish;
                _openanim_pop2 += _openanim_pop1;
                _openanim_disappear += _openanim_pop2;
                
                if (slideTweenTime >= 1)
                {
                    openAnimTime += doDelta(1);
                    
                    if (openAnimTime < _openanim_squish)
                    {
                        openAnimFrame = 0;
                    }
                    else if (openAnimTime < _openanim_pop1)
                    {
                        openAnimFrame = 1;
                    }
                    else if (openAnimTime < _openanim_pop2)
                    {
                        openAnimFrame = 2;
                    }
                    else if (openAnimTime < _openanim_disappear)
                    {
                        openAnimFrame = 3;
                    }
                    else
                    {
                        if (openAnimFrame != 4)
                        {
                            playSoundCapsuleReveal();
                            
                            with (uiGet("shop title"))
                                setVisible(true);
                        }
                        
                        openAnimFrame = 4;
                    }
                }
                
                if (openAnimFrame == 0 && openAnimTime >= 4)
                {
                    if (openAnimTime < _squishanim_firstVibration)
                    {
                        var _vibrateRate = 1;
                        vibrateX = deltaLerp(vibrateX, random_range(-_vibrateRate, _vibrateRate), 0.6);
                        vibrateY = deltaLerp(vibrateY, random_range(-_vibrateRate, _vibrateRate), 0.8);
                    }
                    else
                    {
                        swellScaleOffset = deltaLerp(swellScaleOffset, -0.04, 0.2);
                        vibrateX = deltaLerp(vibrateX, 0, 0.9);
                        vibrateY = deltaLerp(vibrateY, 0, 0.9);
                        vibrateScaleOffset = deltaLerp(vibrateScaleOffset, 0, 0.7);
                        
                        if (openAnimTime < _squishanim_pause1)
                        {
                        }
                        else if (openAnimTime < _squishanim_slightTwitch)
                        {
                            var _vibrateRate = 1;
                            vibrateX = deltaLerp(vibrateX, random_range(-_vibrateRate, _vibrateRate), 0.6);
                            vibrateY = deltaLerp(vibrateY, random_range(-_vibrateRate, _vibrateRate), 0.8);
                        }
                        else if (openAnimTime < _squishanim_pause2)
                        {
                        }
                        else if (openAnimTime < _squishanim_bigShrink)
                        {
                            var _vibrateRate = 1;
                            vibrateX = deltaLerp(vibrateX, random_range(-_vibrateRate, _vibrateRate), 0.6);
                            vibrateY = deltaLerp(vibrateY, random_range(-_vibrateRate, _vibrateRate), 0.8);
                            swellScaleOffset = -0.1;
                            ballData.ballSprite = ballData.ballOpenSprite;
                        }
                    }
                }
                else
                {
                    swellScaleOffset = deltaLerp(swellScaleOffset, 0, 0.5);
                }
                
                if (openAnimFrame >= 1)
                    rainbowTweenTime = min(1, rainbowTweenTime + doDelta(1/15));
                
                rainbowScale = animcurve_tween(0, 0.12, curveBackInv, rainbowTweenTime);
                
                if (openAnimFrame >= 2)
                    itemScaleTime = min(1, itemScaleTime + doDelta(0.058823529411764705));
                
                itemScale = animcurve_tween(1, 1.25, curveBackInv, itemScaleTime);
            }
        });
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            var _x = getDrawX() + vibrateX;
            var _y = getDrawY() + vibrateY + slideY;
            var _scale = (0.2 * ballData.scale) + swellScaleOffset + vibrateScaleOffset;
            var _item_scale = _scale * itemScale;
            drawRainbowSplash(_x, _y, rainbowScale, current_time);
            
            switch (openAnimFrame)
            {
                case -1:
                    draw_sprite_ext(ballData.ballSprite, 0, _x, _y, _scale, _scale, 0, ballData.colour_dimmed, 1);
                    draw_sprite_ext(ballData.ballSprite, 1, _x, _y, _scale, _scale, 0, c_white, 1);
                    draw_sprite_ext(ballData.sprite, 0, _x, _y, _item_scale, _item_scale, 0, c_white, 1);
                    draw_sprite_ext(ballData.ballSprite, 2, _x, _y, _scale, _scale, 0, ballData.colour, 1);
                    break;
                
                case 0:
                    draw_sprite_ext(ballData.ballSprite, 0, _x, _y, _scale, _scale, 0, ballData.colour_dimmed, 1);
                    draw_sprite_ext(ballData.ballSprite, 1, _x, _y, _scale, _scale, 0, c_white, 1);
                    draw_sprite_ext(ballData.sprite, 0, _x, _y, _item_scale, _item_scale, 0, c_white, 1);
                    draw_sprite_ext(ballData.ballSprite, 2, _x, _y, _scale, _scale, 0, ballData.colour, 1);
                    break;
                
                case 1:
                    draw_sprite_ext(ballData.ballOpenSprite, 0, _x - 12, _y + 40, _scale, _scale, 0, ballData.colour, 1);
                    draw_sprite_ext(sGachaBallOpenLid, 0, _x + 12, _y - 40, _scale, _scale, 0, c_white, 1);
                    draw_sprite_ext(ballData.sprite, 0, _x, _y, _item_scale, _item_scale, 0, c_white, 1);
                    break;
                
                case 2:
                    draw_sprite_ext(ballData.ballOpenSprite, 1, _x - 15, _y + 70, _scale, _scale, 0, ballData.colour, 1);
                    draw_sprite_ext(sGachaBallOpenLid, 1, _x + 15, _y - 70, _scale, _scale, 0, c_white, 1);
                    draw_sprite_ext(ballData.sprite, 0, _x, _y, _item_scale, _item_scale, 0, c_white, 1);
                    break;
                
                case 3:
                    if ((current_time % 6) == 3)
                    {
                        draw_sprite_ext(ballData.ballOpenSprite, 1, _x - 15, _y + 70, _scale, _scale, 0, ballData.colour, 1);
                        draw_sprite_ext(sGachaBallOpenLid, 1, _x + 15, _y - 70, _scale, _scale, 0, c_white, 1);
                    }
                    
                    draw_sprite_ext(ballData.sprite, 0, _x, _y, _item_scale, _item_scale, 0, c_white, 1);
                    break;
                
                case 4:
                    draw_sprite_ext(ballData.sprite, 0, _x, _y, _item_scale, _item_scale, 0, c_white, 1);
                    break;
            }
        });
    }
    
    with (newChild("shop title"))
    {
        setX(0.5 * getParent().getShapeWidth());
        setWidth(1);
        setY(0.21 * getParent().getShapeHeight());
        setHeight(1);
        setVisible(false);
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            var _ability;
            
            with (rootInstance)
                _ability = wheelData[wheelIndex].abilityIndex;
            
            if (locGetLanguage() != "Thai")
                scribble("[scale,0.73][pin_center][fa_middle]" + loc(abilityGetIndexName(_ability) + " name")).bezier(getDrawX() - 70, getDrawY() + 65, getDrawX() - 40, getDrawY(), getDrawX() + 40, getDrawY(), getDrawX() + 70, getDrawY() + 65).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 6).typewriter_in(0.3, 20).typewriter_ease(UnknownEnum.Value_4, 0, 0, 1, 1, 0, 0.02).draw(getDrawX() - 70, getDrawY() + 65);
            else
                scribble("[scale,0.73]" + loc(abilityGetIndexName(_ability) + " name")).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 6).typewriter_in(0.3, 20).typewriter_ease(UnknownEnum.Value_4, 0, 0, 1, 1, 0, 0.02).align(1, 1).wrap(140).draw(global.windowCenterx, getDrawY() + 32.5);
        });
    }
    
    with (newChild("shop equip", "shop third page group"))
    {
        setX(0.5 * getParent().getShapeWidth());
        setWidth(65);
        setY((0.78 * getParent().getShapeHeight()) - 20);
        setHeight(0.1 * sprite_get_height(sGacha3SliceButton));
        setVisible(false);
        setActive(false);
        selected = false;
        selectedScaleOffset = 0;
        inTweenTime = 0;
        eventAddFunction(UnknownEnum.Value_4, function()
        {
            if (input_player_source_get() == UnknownEnum.Value_2 || (os_type == os_windows || os_type == os_macosx || os_type == os_linux))
                selected = true;
        });
        eventAddFunction(UnknownEnum.Value_7, function()
        {
            if (selected)
                outCursorClick = false;
            
            selected = false;
            highlight = false;
        });
        eventAddFunction(UnknownEnum.Value_1, function()
        {
            if (getVisible())
                inTweenTime = min(1, inTweenTime + doDelta(0.1));
            
            if (selected)
                selectedScaleOffset = lerp(selectedScaleOffset, 0.15, 0.4);
            else
                selectedScaleOffset = lerp(selectedScaleOffset, 0, 0.4);
        });
        eventAddFunction(UnknownEnum.Value_14, function()
        {
            uiFocusForce("shop return");
        });
        eventAddFunction(UnknownEnum.Value_9, function()
        {
            highlight = true;
        });
        eventAddFunction(UnknownEnum.Value_11, function()
        {
            highlight = false;
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            instance_destroy(rootInstance);
            instance_create_depth(0, 0, 0, oAbilityEquipMenu);
        });
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            var _scale = animcurve_tween(0, 1, curveBackInv, inTweenTime) + selectedScaleOffset;
            var _matrix = matrix_build(-getDrawX(), -getDrawY(), 0, 0, 0, 0, 1, 1, 1);
            _matrix = matrix_multiply(_matrix, matrix_build(0, 0, 0, 0, 0, 0, _scale, _scale, 1));
            _matrix = matrix_multiply(_matrix, matrix_build(getDrawX(), getDrawY(), 0, 0, 0, 0, 1, 1, 1));
            matrix_set(2, _matrix);
            var _oldFilter = gpu_get_tex_filter();
            gpu_set_tex_filter(false);
            drawThreeSliceExt(sGacha3SliceButton, getDrawLeft(), getDrawRight(), getDrawTop(), 0.1, make_color_rgb(46, 50, 59), 1);
            drawThreeSliceExt(sGacha3SliceButtonHighlight, getDrawLeft(), getDrawRight(), getDrawTop(), 0.1, ((selected && (current_time % 600) < 300) || highlight) ? make_color_rgb(255, 233, 1) : make_color_rgb(65, 231, 125), 1);
            gpu_set_tex_filter(_oldFilter);
            scribble("[scale,0.5]" + loc("gacha button equip")).starting_format(locGetFontFromLanguage(), highlight ? make_color_rgb(255, 233, 1) : make_color_rgb(255, 255, 255)).align(1, 1).scale_to_box(getDrawWidth() - 16, -1).draw(getDrawX(), getDrawY());
            matrix_set(2, matrix_build_identity());
        });
    }
    
    with (newChild("shop return", "shop third page group"))
    {
        setX(0.5 * getParent().getShapeWidth());
        setWidth(65);
        setY((0.78 * getParent().getShapeHeight()) + 17);
        setHeight(0.1 * sprite_get_height(sGacha3SliceButton));
        setVisible(false);
        setActive(false);
        selected = false;
        selectedScaleOffset = 0;
        highlight = false;
        inTweenTime = -0.5;
        eventAddFunction(UnknownEnum.Value_4, function()
        {
            if (input_player_source_get() == UnknownEnum.Value_2 || (os_type == os_windows || os_type == os_macosx || os_type == os_linux))
                selected = true;
        });
        eventAddFunction(UnknownEnum.Value_7, function()
        {
            if (selected)
                outCursorClick = false;
            
            selected = false;
            highlight = false;
        });
        eventAddFunction(UnknownEnum.Value_1, function()
        {
            if (getVisible())
                inTweenTime = min(1, inTweenTime + doDelta(0.1));
            
            if (selected)
                selectedScaleOffset = lerp(selectedScaleOffset, 0.15, 0.4);
            else
                selectedScaleOffset = lerp(selectedScaleOffset, 0, 0.4);
        });
        eventAddFunction(UnknownEnum.Value_14, function()
        {
            instance_destroy(rootInstance);
        });
        eventAddFunction(UnknownEnum.Value_9, function()
        {
            highlight = true;
        });
        eventAddFunction(UnknownEnum.Value_11, function()
        {
            highlight = false;
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            instance_destroy(rootInstance);
        });
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            var _scale = animcurve_tween(0, 1, curveBackInv, inTweenTime) + selectedScaleOffset;
            var _matrix = matrix_build(-getDrawX(), -getDrawY(), 0, 0, 0, 0, 1, 1, 1);
            _matrix = matrix_multiply(_matrix, matrix_build(0, 0, 0, 0, 0, 0, _scale, _scale, 1));
            _matrix = matrix_multiply(_matrix, matrix_build(getDrawX(), getDrawY(), 0, 0, 0, 0, 1, 1, 1));
            matrix_set(2, _matrix);
            var _oldFilter = gpu_get_tex_filter();
            gpu_set_tex_filter(false);
            drawThreeSliceExt(sGacha3SliceButton, getDrawLeft(), getDrawRight(), getDrawTop(), 0.1, make_color_rgb(46, 50, 59), 1);
            drawThreeSliceExt(sGacha3SliceButtonHighlight, getDrawLeft(), getDrawRight(), getDrawTop(), 0.1, ((selected && (current_time % 600) < 300) || highlight) ? make_color_rgb(255, 233, 1) : make_color_rgb(36, 145, 249), 1);
            gpu_set_tex_filter(_oldFilter);
            scribble("[scale,0.5]" + loc("gacha button return")).starting_format(locGetFontFromLanguage(), highlight ? make_color_rgb(255, 233, 1) : make_color_rgb(255, 255, 255)).align(1, 1).scale_to_box(getDrawWidth() - 16, -1).draw(getDrawX(), getDrawY());
            matrix_set(2, matrix_build_identity());
        });
    }
}
