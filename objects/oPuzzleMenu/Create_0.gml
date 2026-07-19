var _i;
pauseStart();
global.puzzleAreaUnlockNotification = 0;
inLobby = (room == rmPlayableMainMenu) ? 1 : 0;
fromPuzzleComplete = 0;
fromPauseMenu = 0;
selectedArea = undefined;
selectedLevel = undefined;
initialScroll = 0;
puzzleListSize = (array_length(global.puzzleRoomList) - 1) * array_length(global.puzzleRoomList[UnknownEnum.Value_1]);
var _puzzleListSize = puzzleListSize;

if (inLobby)
{
    audioSetVolumeTarget(global.areaMusic, 0, 0.16666666666666666);
    audioSetVolumeTarget(global.puzzleMenuMusic, 1, 0.16666666666666666);
}
else
{
    selectedArea = global.puzzleCurrentTheme;
    selectedLevel = global.puzzleCurrentIndex;
    initialScroll = 1;
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);

with (uiCreate("puzzle root"))
{
    var _overlayBlack = make_color_rgb(85, 94, 108);
    uiTemplateRectangle(_overlayBlack, 0);
    inTweenTime = 0;
    
    if (!rootInstance.inLobby)
        inTweenTime = 1;
    
    eventAddFunction(UnknownEnum.Value_0, function()
    {
        setLTRBToWindow();
    });
    eventAddFunction(UnknownEnum.Value_1, function()
    {
        inTweenTime = min(1, inTweenTime + doDelta(0.05));
        visAlpha = 0.5 * inTweenTime;
    });
    eventAddFunction(UnknownEnum.Value_2, function()
    {
        var _scale = animcurve_tween(0.5, 1, curveBackInv, inTweenTime);
        var _matrix = matrix_build(-getDrawX(), -getDrawY(), 0, 0, 0, 0, 1, 1, 1);
        _matrix = matrix_multiply(_matrix, matrix_build(0, 0, 0, 0, 0, 0, _scale, _scale, 1));
        _matrix = matrix_multiply(_matrix, matrix_build(getDrawX(), getDrawY(), 0, 0, 0, 0, 1, 1, 1));
        matrix_set(2, _matrix);
    });
    eventAddFunction(UnknownEnum.Value_3, function()
    {
        matrix_set(2, matrix_build_identity());
    });
    updateShape();
    eventAddFunction(UnknownEnum.Value_10, function()
    {
        uiGet("puzzle selected").borderT = 0;
        rootInstance.selectedArea = undefined;
        rootInstance.selectedLevel = undefined;
    });
    eventAddFunction(UnknownEnum.Value_14, function()
    {
        uiFocusForce("puzzle back");
    });
    
    with (newChild("puzzle panel"))
    {
        setX(getParent().getShapeWidth() / 2);
        setWidth(min(getParent().getShapeWidth() - 9, 152));
        setTop(0.18 * getParent().getShapeHeight());
        setBottom(0.76 * getParent().getShapeHeight());
        setFlow("grid", "x");
        setFlowAlignment("left", "top", "left", "top");
        setFlowSpacing(2, 16, 2, 10, 2, 2);
        flowGridXCount = 5;
        updateShape();
        var _buttonSize = (getShapeWidth() - 4 - (flowGutterH * (flowGridXCount - 1))) / flowGridXCount;
        _i = 0;
        
        repeat (_puzzleListSize)
        {
            with (newChild(undefined, "puzzle button group"))
            {
                scalingFactor = _buttonSize / sprite_get_width(sPuzzleFrames);
                uiTemplateSpriteScaled(sPuzzleFrames, 0, scalingFactor);
                puzzleIndex = _i;
                areaIndex = (_i div global.puzzleLevelCount) + 1;
                levelIndex = _i % global.puzzleLevelCount;
                textColour = undefined;
                areaColour = undefined;
                
                switch (areaIndex)
                {
                    case 1:
                        areaColour = make_color_rgb(176, 183, 195);
                        break;
                    
                    case 2:
                        areaColour = make_color_rgb(65, 231, 125);
                        break;
                    
                    case 3:
                        areaColour = make_color_rgb(36, 145, 249);
                        break;
                    
                    case 4:
                        areaColour = make_color_rgb(248, 45, 97);
                        break;
                    
                    case 5:
                        areaColour = make_color_rgb(255, 238, 96);
                        break;
                    
                    case 6:
                        areaColour = make_color_rgb(255, 255, 255);
                        break;
                }
                
                if (!puzzleDataRoomExists(areaIndex, levelIndex) || !puzzleDataUnlockedGet(areaIndex, levelIndex))
                {
                    imageIndex = 0;
                }
                else if (!puzzleDataClearedGet(areaIndex, levelIndex))
                {
                    imageIndex = 1;
                    textColour = areaColour;
                }
                else
                {
                    imageIndex = 2 + areaIndex;
                    textColour = (areaColour == make_color_rgb(255, 238, 96) || areaColour == make_color_rgb(255, 255, 255)) ? make_color_rgb(46, 50, 59) : make_color_rgb(255, 255, 255);
                }
                
                selected = false;
                setActive(puzzleDataRoomExists(areaIndex, levelIndex) && puzzleDataUnlockedGet(areaIndex, levelIndex));
                eventAddFunction(UnknownEnum.Value_4, function()
                {
                    if (input_player_source_get() == UnknownEnum.Value_2)
                    {
                        uiGet("puzzle selected").borderT = 0;
                        rootInstance.selectedArea = areaIndex;
                        rootInstance.selectedLevel = levelIndex;
                        scrollTo();
                    }
                });
                eventAddFunction(UnknownEnum.Value_10, function()
                {
                    uiGet("puzzle selected").borderT = 0;
                    
                    if (rootInstance.selectedArea != areaIndex || rootInstance.selectedLevel != levelIndex)
                    {
                        playSoundPuzzleSelect();
                        rootInstance.selectedArea = areaIndex;
                        rootInstance.selectedLevel = levelIndex;
                        scrollTo();
                    }
                    else if (puzzleDataRoomExists(areaIndex, levelIndex) && puzzleDataUnlockedGet(areaIndex, levelIndex))
                    {
                        playSoundPuzzleConfirm();
                        playMusicIntro = 0;
                        
                        if (global.puzzleCurrentTheme != areaIndex)
                        {
                            global.puzzleCurrentTheme = areaIndex;
                            playMusicIntro = 1;
                        }
                        
                        global.puzzleCurrentIndex = levelIndex;
                        global.currentLevelChunkSet = global.puzzleCurrentTheme;
                        var _room = global.puzzleRoomList[areaIndex][levelIndex];
                        global.gameReinitializeState = "puzzle";
                        disableAllAbility();
                        var _areaIndex = areaIndex;
                        var _levelIndex = levelIndex;
                        
                        if (rootInstance.inLobby)
                        {
                            global.puzzleMusicIntroPlay = UnknownEnum.Value_1;
                            
                            with (instance_create_depth(0, 0, 0, oTSequence_puzzleEnter))
                            {
                                areaIndex = _areaIndex;
                                levelIndex = _levelIndex;
                            }
                            
                            instance_destroy(rootInstance);
                            pauseEnd();
                        }
                        else
                        {
                            if (playMusicIntro)
                                global.puzzleMusicIntroPlay = UnknownEnum.Value_2;
                            
                            instance_destroy(rootInstance);
                            pauseEnd();
                            roomTransitionTo(_room, "puzzle");
                        }
                        
                        instance_destroy(rootInstance);
                        pauseEnd();
                    }
                });
                eventAddFunction(UnknownEnum.Value_2, function()
                {
                    if (textColour != undefined)
                    {
                        var _textElement = scribble(puzzleIndex + 1).align(1, 1).starting_format(locGetNumFont(), textColour).transform(6 * scalingFactor, 6 * scalingFactor, 0).draw(getDrawX() + 1, getDrawY() - 0.5);
                        uiShaderReset();
                    }
                    
                    if (puzzleDataClearedGet(areaIndex, levelIndex))
                        draw_sprite_ext(sPuzzleFlower, 0, getDrawRight() - (44 * scalingFactor), getDrawBottom() - (44 * scalingFactor), scalingFactor, scalingFactor, 0, c_white, 1);
                });
            }
            
            _i++;
        }
        
        updateShape();
        
        if (outFlowAreaHeight > getShapeHeight())
        {
            clipChildrenAllow = true;
            scrollAllow = true;
            updateShape();
        }
    }
    
    with (newChild("puzzle selected clip"))
    {
        setLeft(0);
        setRight(getParent().getShapeWidth());
        setTop(uiGet("puzzle panel").getRawTop());
        setBottom(uiGet("puzzle panel").getRawBottom());
        setActive(false);
        clipChildrenAllow = uiGet("puzzle panel").clipChildrenAllow;
        
        with (newChild("puzzle selected"))
        {
            borderT = 0;
            eventAddFunction(UnknownEnum.Value_2, function()
            {
                if (rootInstance.selectedArea != undefined && rootInstance.selectedLevel != undefined)
                {
                    borderT = approach(borderT, 1, doDelta(0.1));
                    uiForEachInGroup("puzzle root", "puzzle button group", function(arg0)
                    {
                        if (rootInstance.selectedArea == areaIndex && rootInstance.selectedLevel == levelIndex)
                        {
                            var _borderQ = animcurve_tween(0, 1, curveBackInv, arg0);
                            var _scale = lerp(sprite_get_width(sPuzzleFrames) / sprite_get_width(sPuzzleFramesSelected), 1, _borderQ);
                            var _old_matrix = matrix_get(2);
                            var _matrix = _old_matrix;
                            _matrix = matrix_multiply(_matrix, matrix_build(0, 0, 0, 0, 0, 0, _scale, _scale, 1));
                            _matrix = matrix_multiply(_matrix, matrix_build(getDrawX(), getDrawY(), 0, 0, 0, 0, 1, 1, 1));
                            matrix_set(2, _matrix);
                            draw_sprite_ext(sPuzzleHighlight, 0, 1, 0, scalingFactor, scalingFactor, 0, c_white, 1);
                            draw_sprite_ext(sPuzzleFramesSelected, imageIndex, 1, 0, scalingFactor, scalingFactor, 0, c_white, 1);
                            scribble(puzzleIndex + 1).align(1, 1).starting_format(locGetNumFont(), textColour).transform(8 * scalingFactor, 8 * scalingFactor, 0).draw(1, -0.5);
                            uiShaderReset();
                            var _playX = getDrawLeft() - getDrawX() - (44 * scalingFactor);
                            var _playY = getDrawTop() - getDrawY() - (66 * scalingFactor);
                            var _playText = scribble("[scale,0.25]" + loc("puzzle play")).align(0, 1).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).scale_to_box((0.1 * sprite_get_width(sPuzzleFrames)) - 4, 0);
                            drawThreeSliceExt(sPuzzle3SlicePlay, _playX, _playX + _playText.get_width() + 8, _playY, scalingFactor, 16777215, 1);
                            _playText.draw(_playX + 4, (_playY - 0.5) + ((scalingFactor * sprite_get_height(sPuzzle3SlicePlay)) / 2));
                            uiShaderReset();
                            
                            if (puzzleDataClearedGet(areaIndex, levelIndex))
                                draw_sprite_ext(sPuzzleFlower, 0, getDrawRight() - getDrawX() - (25 * scalingFactor), getDrawBottom() - getDrawY() - (25 * scalingFactor), scalingFactor, scalingFactor, 0, c_white, 1);
                            
                            matrix_set(2, _old_matrix);
                        }
                    }, borderT);
                }
            });
        }
    }
    
    with (newChild())
    {
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            if (uiGet("puzzle panel").clipChildrenAllow)
            {
                var _parent = getParent();
                var _l = global.windowLeft;
                var _t = 0;
                var _r = global.windowRight;
                var _b = uiGet("puzzle header").getDrawBottom() + 6;
                uiDrawPauseSurfacePart(_l, _t, _r, _b, _parent.visBlend, _parent.visAlpha);
                uiDrawPauseSurfacePartExt(_l, _b, _r, _b + 4, _parent.visBlend, _parent.visAlpha, 1, 1, 0, 0);
                _l = global.windowLeft;
                _t = uiGet("puzzle panel").getDrawBottom() + 1;
                _r = global.windowRight;
                _b = _parent.getDrawBottom();
                uiDrawPauseSurfacePart(_l, _t, _r, _b, _parent.visBlend, _parent.visAlpha);
                uiDrawPauseSurfacePartExt(_l, _t - 4, _r, _t, _parent.visBlend, _parent.visAlpha, 0, 0, 1, 1);
            }
        });
    }
    
    with (newChild("puzzle header"))
    {
        setX(getParent().getShapeWidth() / 2);
        setTop(0.08 * getParent().getShapeHeight());
        var _headerText = loc("puzzle header");
        textElement = scribble(_headerText).starting_format(locGetFontFromLanguage(), make_color_rgb(46, 50, 59)).align(1, 1).scale_to_box(getParent().getShapeWidth() - 30, (0.1 * sprite_get_height(sPuzzle3SliceHeader)) - 4);
        setWidth(textElement.get_width() + 24);
        setHeight(0.1 * sprite_get_height(sPuzzle3SliceHeader));
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            drawThreeSliceExt(sPuzzle3SliceHeader, getDrawLeft(), getDrawRight(), getDrawTop() + 1, 0.1, 16777215, 1);
            textElement.draw(getDrawX(), getDrawY());
        });
        updateShape();
    }
    
    with (newChild("puzzle back"))
    {
        uiTemplateSpriteScaled(sPuzzleReturnButton, 0, 0.1);
        setX(getParent().getShapeWidth() / 2);
        setY((0.86 * getParent().getShapeHeight()) + 4);
        selected = false;
        eventAddFunction(UnknownEnum.Value_4, function()
        {
            if (input_player_source_get() == UnknownEnum.Value_2)
            {
                selected = true;
                uiGet("puzzle selected").borderT = 0;
                rootInstance.selectedArea = undefined;
                rootInstance.selectedLevel = undefined;
            }
        });
        eventAddFunction(UnknownEnum.Value_7, function()
        {
            outCursorClick = false;
            
            if (selected)
                imageIndex = 0;
            
            selected = false;
        });
        eventAddFunction(UnknownEnum.Value_8, function()
        {
            imageIndex = 1;
        });
        eventAddFunction(UnknownEnum.Value_14, function()
        {
            playSoundBackButton();
            instance_destroy(rootInstance);
            
            if (rootInstance.inLobby)
            {
                pauseEnd();
                playerControlLockRelease();
            }
            else if (rootInstance.fromPuzzleComplete)
            {
                instance_create_depth(0, 0, 0, oPuzzleCompleteMenu_returnedFromList);
            }
            else if (rootInstance.fromPauseMenu)
            {
                instance_create_depth(0, 0, 0, oPauseMenu);
            }
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            playSoundBackButton();
            
            if (rootInstance.inLobby)
            {
                pauseEnd();
                playerControlLockRelease();
            }
            else if (rootInstance.fromPuzzleComplete)
            {
                instance_create_depth(0, 0, 0, oPuzzleCompleteMenu_returnedFromList);
            }
            else if (rootInstance.fromPauseMenu)
            {
                instance_create_depth(0, 0, 0, oPauseMenu);
            }
            
            instance_destroy(rootInstance);
        });
        eventAddFunction(UnknownEnum.Value_11, function()
        {
            imageIndex = 0;
        });
        eventInsertFunction(UnknownEnum.Value_2, 0, function()
        {
            if (selected)
                draw_sprite_ext(sPuzzleReturnButtonHighlight, 0, getDrawLeft(), getDrawTop(), 0.1, 0.1, 0, c_white, 1);
        });
    }
}

var _earliestArea = 1;
var _earliestLevel = 0;
_i = 0;

repeat (puzzleListSize)
{
    var _areaIndex = (_i div 5) + 1;
    var _levelIndex = _i % 5;
    
    if (puzzleDataRoomExists(_areaIndex, _levelIndex) && puzzleDataUnlockedGet(_areaIndex, _levelIndex) && !puzzleDataClearedGet(_areaIndex, _levelIndex))
    {
        _earliestArea = _areaIndex;
        _earliestLevel = _levelIndex;
        break;
    }
    
    _i++;
}

uiForEachInGroup("puzzle root", "puzzle button group", function(arg0)
{
    _earliestArea = arg0.earliestArea;
    _earliestLevel = arg0.earliestLevel;
    
    if (areaIndex == _earliestArea && levelIndex == _earliestLevel)
        uiFocusForce(globalTag);
}, 
{
    earliestArea: _earliestArea,
    earliestLevel: _earliestLevel
});
