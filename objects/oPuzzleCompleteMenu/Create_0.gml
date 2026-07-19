pauseStart();
draw_set_halign(fa_left);
draw_set_valign(fa_top);
getMoney = 0;
var _newlyCleared = 0;

if (!puzzleDataClearedGet(global.puzzleCurrentTheme, global.puzzleCurrentIndex))
{
    puzzleDataClearedSet(global.puzzleCurrentTheme, global.puzzleCurrentIndex, true);
    getMoney = 1;
    getMoney = global.puzzleCurrentTheme * 10;
    
    with (oControl)
        moneyAmountCountUpDelay = 600;
    
    global.moneyJar += getMoney;
    shownMoneyAmountUpdate();
    _newlyCleared = 1;
}

var _allCompleteTrophyCheck = 1;
var _i = UnknownEnum.Value_1;

while (_i < UnknownEnum.Value_7)
{
    for (var _t = 0; _t < global.puzzleLevelCount; _t += 1)
    {
        if (!puzzleDataClearedGet(_i, _t))
        {
            _allCompleteTrophyCheck = 0;
            _i = 99;
            break;
        }
    }
    
    _i += 1;
}

if (_allCompleteTrophyCheck == 1)
{
    if (!trophyUnlock(UnknownEnum.Value_14))
        _allCompleteTrophyCheck = 0;
}

if (!skipTweens)
{
    if (!_allCompleteTrophyCheck)
        playSoundPuzzleComplete();
    else
        playSoundAllClearedText();
}

saveGame(true);

with (uiCreate("puzzle complete root"))
{
    uiTemplateRectangle(make_color_rgb(46, 50, 59), 0);
    eventAddFunction(UnknownEnum.Value_0, function()
    {
        setLTRBToWindow();
    });
    inTweenTime = 0;
    textDelay = 0;
    
    if (_allCompleteTrophyCheck && _newlyCleared)
        textDelay = -1;
    
    if (rootInstance.skipTweens)
    {
        inTweenTime = 1;
        textDelay = 1;
    }
    
    moneyDone = 0;
    whooshSoundPlayed = 0;
    updateShape();
    eventAddFunction(UnknownEnum.Value_1, function()
    {
        inTweenTime = min(1, inTweenTime + doDelta(0.04));
        visAlpha = 0.7 * inTweenTime;
        textDelay = min(1, textDelay + doDelta(0.013333333333333334));
        
        if (textDelay >= 0.75 && !moneyDone)
        {
            uiForEachInGroup(rootTag, "money notification", function()
            {
                var _money = rootInstance.getMoney;
                
                with (oControl)
                {
                    moneyAmountCountUpDelay = 60;
                    walletUIappearTime = 240;
                    walletWobble = 1;
                    walletChange(_money);
                }
                
                setActive(true);
                setVisible(true);
            });
            moneyDone = 1;
        }
        
        if (textDelay >= 1)
        {
            uiForEachInGroup(rootTag, "puzzle complete button group", function()
            {
                setActive(true);
                setVisible(true);
            });
            
            if (!whooshSoundPlayed)
            {
                playSoundPuzzleCompleteIcons();
                whooshSoundPlayed = 1;
            }
        }
    });
    
    with (newChild())
    {
        setX(0.5 * getParent().getShapeWidth());
        setBottom((0.5 * getParent().getShapeHeight()) - 3);
        doTheBezier = false;
        text = loc("puzzle complete");
        
        if (_allCompleteTrophyCheck)
            text = loc("puzzle all complete");
        
        textScale = min(1.8, 200 / scribble(text).get_width());
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            var _scale = 1;
            completeText = scribble(text, rootInstance).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 3).transform(_scale, _scale, 0).scale_to_box(getParent().getShapeWidth() * 0.9, getParent().getShapeHeight()).align(1, 2);
            
            if (!rootInstance.skipTweens)
                completeText.typewriter_in(0.3, 30).typewriter_ease(UnknownEnum.Value_7, 0, 0, 1, 0.8, 0, 0.03);
            
            completeText.draw(getDrawX(), getDrawY() - 16 - 8 - 8);
        });
    }
    
    if (rootInstance.getMoney)
    {
        with (newChild(undefined, "money notification"))
        {
            setActive(false);
            setVisible(false);
            setX(0.5 * getParent().getShapeWidth());
            setBottom((0.5 * getParent().getShapeHeight()) - 3);
            inTweenTime = 0;
            visAlpha = 0;
            text = loc("puzzle complete");
            eventAddFunction(UnknownEnum.Value_1, function()
            {
                if (getVisible() && inTweenTime < 1)
                    inTweenTime = min(1, inTweenTime + doDelta(0.05555555555555555));
                
                visAlpha = inTweenTime;
                visYOffset = animcurve_tween(10, 0, curveQuartInv, inTweenTime);
            });
            eventAddFunction(UnknownEnum.Value_2, function()
            {
                var _scale = 0.5;
                scribble("+ " + string(rootInstance.getMoney) + "[scale, 0.15][sGoldenSeedUI][/scale]", rootInstance).starting_format(locGetNumFont(), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 3).transform(_scale, _scale, 0).align(1, 1).draw(getDrawX(), getDrawY() - 16);
            });
        }
    }
    
    with (newChild())
    {
        setX(0.5 * getParent().getShapeWidth());
        setWidth(getParent().getShapeWidth() - 30);
        setTop(0.5 * getParent().getShapeHeight());
        setFlow("list", "y");
        setFlowAlignment("center", "middle", "center", "middle");
        setFlowSpacing(0, 0, 0, 0, 0, 10);
        updateShape();
        eventAddFunction(UnknownEnum.Value_14, function()
        {
            instance_destroy(rootInstance);
            pauseEnd();
        });
        var _arrayLength = array_length(global.puzzleRoomList[global.puzzleCurrentTheme]);
        var _nextIndex = global.puzzleCurrentIndex % _arrayLength;
        var _nextTheme = global.puzzleCurrentTheme;
        
        if (global.puzzleCurrentIndex == (global.puzzleLevelCount - 1))
            _nextTheme += 1;
        
        if (!_allCompleteTrophyCheck)
        {
            if (puzzleDataUnlockedGet(_nextTheme, _nextIndex) && puzzleDataRoomExists(_nextTheme, _nextIndex))
            {
                with (newChild(undefined, "puzzle complete button group"))
                {
                    uiTemplateButton(loc("puzzle next"), 1.3);
                    setActive(false);
                    setVisible(false);
                    inTweenTime = 0;
                    visAlpha = 0;
                    eventAddFunction(UnknownEnum.Value_1, function()
                    {
                        if (getVisible() && inTweenTime < 1)
                            inTweenTime = min(1, inTweenTime + doDelta(0.05555555555555555));
                        
                        visAlpha = inTweenTime;
                        visXOffset = animcurve_tween(-20, 0, curveQuartInv, inTweenTime);
                    });
                    eventAddFunction(UnknownEnum.Value_10, function()
                    {
                        callEventInChildren();
                        
                        if (global.puzzleCurrentIndex == (global.puzzleLevelCount - 1))
                        {
                            global.puzzleCurrentTheme += 1;
                            global.puzzleMusicIntroPlay = UnknownEnum.Value_2;
                        }
                        
                        global.puzzleCurrentIndex += 1;
                        var _arrayLength = global.puzzleLevelCount;
                        global.puzzleCurrentIndex = global.puzzleCurrentIndex % _arrayLength;
                        var _targetRoom = global.puzzleRoomList[global.puzzleCurrentTheme][global.puzzleCurrentIndex];
                        roomTransitionTo(_targetRoom, "puzzle");
                        instance_destroy(rootInstance);
                        pauseEnd();
                    });
                }
            }
            
            with (newChild(undefined, "puzzle complete button group"))
            {
                uiTemplateButton(loc("puzzle list"), 1.3);
                setActive(false);
                setVisible(false);
                inTweenTime = 0;
                visAlpha = 0;
                eventAddFunction(UnknownEnum.Value_1, function()
                {
                    if (getVisible() && inTweenTime < 1)
                        inTweenTime = min(1, inTweenTime + doDelta(0.05555555555555555));
                    
                    visAlpha = inTweenTime;
                    visXOffset = animcurve_tween(20, 0, curveQuartInv, inTweenTime);
                });
                eventAddFunction(UnknownEnum.Value_10, function()
                {
                    with (instance_create_depth(0, 0, 0, oPuzzleMenu))
                        fromPuzzleComplete = 1;
                    
                    instance_destroy(rootInstance);
                });
            }
        }
        
        with (newChild(undefined, "puzzle complete button group"))
        {
            uiTemplateButton(loc("puzzle return"), 1.3);
            setActive(false);
            setVisible(false);
            inTweenTime = 0;
            visAlpha = 0;
            eventAddFunction(UnknownEnum.Value_1, function()
            {
                if (getVisible() && inTweenTime < 1)
                    inTweenTime = min(1, inTweenTime + doDelta(0.05555555555555555));
                
                visAlpha = inTweenTime;
                visXOffset = animcurve_tween(-20, 0, curveQuartInv, inTweenTime);
            });
            eventAddFunction(UnknownEnum.Value_10, function()
            {
                callEventInChildren();
                roomTransitionTo(rmPlayableMainMenu, "return from puzzle");
                instance_destroy(rootInstance);
                pauseEnd();
            });
        }
    }
}
