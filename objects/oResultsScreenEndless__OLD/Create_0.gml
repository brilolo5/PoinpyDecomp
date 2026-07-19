TexanFetch("ResultsScreen");
TexanCommit();
modeIndex = getEndlessMode();
gameScore = global.mainGameFruitProgress_total;
bestScore = global.endlessHighScore[modeIndex];
newHighScore = false;
modeName = "???";

switch (modeIndex)
{
    case UnknownEnum.Value_4:
        modeName = "2 jumps";
        break;
    
    case UnknownEnum.Value_3:
        modeName = "4 jumps";
        break;
    
    case UnknownEnum.Value_2:
        modeName = "6 jumps";
        break;
    
    case UnknownEnum.Value_1:
        modeName = "8 jumps";
        break;
    
    case UnknownEnum.Value_0:
        modeName = "10 jumps";
        break;
}

if (modeIndex > -1)
{
    if (gameScore > bestScore)
    {
        newHighScore = true;
        array_set(global.endlessHighScore, modeIndex, gameScore);
        saveGame();
    }
}

var _ignoreClicksDelay = 15;

with (uiCreate("results root"))
{
    uiTemplateRectangle(make_color_rgb(46, 50, 59), 0);
    inTweenTime = 0;
    eventAddFunction(UnknownEnum.Value_0, function()
    {
        setLTRBToWindow();
    });
    eventAddFunction(UnknownEnum.Value_1, function()
    {
        if (inTweenTime < 1)
        {
            inTweenTime = min(1, inTweenTime + 0.05);
            
            if (inTweenTime >= 1)
                uiGet("results text").setVisible(true);
        }
        
        visAlpha = 0.7 * inTweenTime;
    });
    updateShape();
    
    with (newChild("results body"))
    {
        setVisible(false);
        setX(getParent().getShapeWidth() / 2);
        setY((getParent().getShapeHeight() / 2) - 10);
        setWidth(min(getParent().getShapeWidth(), getParent().getShapeHeight(), 160) - 20);
        setHeight(getRawWidth());
        inTweenTimeBody = 0;
        inTweenTimeTitle = 0;
        inTweenTimeScore = 0;
        inTweenTimeBest = 0;
        matrix = matrix_build(0, 0, 0, 0, 0, 0, 0, 0, 0);
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            goFaster = true;
        });
        eventAddFunction(UnknownEnum.Value_1, function()
        {
            if (getVisible())
            {
                inTweenTimeBody = min(inTweenTimeBody + 0.04, 1);
                
                if (inTweenTimeBody >= 1)
                    inTweenTimeTitle = min(inTweenTimeTitle + 0.02857142857142857, 1);
                
                if (inTweenTimeTitle >= 1)
                    inTweenTimeScore = min(inTweenTimeScore + 0.02857142857142857, 1);
                
                if (inTweenTimeScore >= 1)
                {
                    if (inTweenTimeBest < 1)
                    {
                        inTweenTimeBest = min(inTweenTimeBest + 0.02857142857142857, 1);
                        
                        if (inTweenTimeBest == 1)
                        {
                            with (uiGet("results lobby button"))
                            {
                                setActive(true);
                                setVisible(true);
                            }
                        }
                    }
                }
                
                var _spriteWidth = sprite_get_width(sResultsBody);
                var _spriteHeight = sprite_get_height(sResultsBody);
                var _targetScale = getShapeWidth() / _spriteWidth;
                var _scale = animcurve_tween(_targetScale * 0.5, _targetScale, curveBackInv, inTweenTimeBody);
                matrix = matrix_build(-_spriteWidth / 2, -_spriteHeight / 2, 0, 0, 0, 0, 1, 1, 1);
                matrix = matrix_multiply(matrix, matrix_build(0, 0, 0, 0, 0, 0, _scale, _scale, 1));
                matrix = matrix_multiply(matrix, matrix_build(getShapeX(), getShapeY(), 0, 0, 0, 0, 1, 1, 1));
            }
        });
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            matrix_set(2, matrix);
            var _titleQ = animcurve_tween(0, 1, curveCubicInv, inTweenTimeTitle);
            var _scoreQ = animcurve_tween(0, 1, curveCubicInv, inTweenTimeScore);
            var _bestQ = animcurve_tween(0, 1, curveCubicInv, inTweenTimeBest);
            scribble("[scale,6]Endless Mode").starting_format(undefined, make_color_rgb(69, 80, 97)).scale_to_box(1000, -1).align(1, 1).blend(16777215, _titleQ).draw(853 - (100 * _titleQ), 370);
            scribble(concat("[scale,6]", rootInstance.modeName)).starting_format(undefined, make_color_rgb(69, 80, 97)).scale_to_box(1100, -1).align(1, 1).blend(16777215, _titleQ).draw(653 + (100 * _titleQ), 570);
            scribble(concat("[scale,7]Score: ", rootInstance.gameScore)).starting_format(undefined, make_color_rgb(69, 80, 97)).scale_to_box(1200, -1).align(1, 1).blend(16777215, _scoreQ).draw(753, 870);
            
            if (rootInstance.newHighScore)
            {
                if (inTweenTimeBest > 0)
                    scribble("[scale,6][blink]New high score!").starting_format(undefined, make_color_rgb(122, 131, 146)).scale_to_box(1200, -1).align(1, 1).animation_blink(17, 17, 0).draw(753, 1070);
            }
            else
            {
                scribble(concat("[scale,6]Best: ", rootInstance.bestScore)).starting_format(undefined, make_color_rgb(69, 80, 97)).scale_to_box(1200, -1).align(1, 1).blend(16777215, _bestQ).draw(753, 1070);
            }
            
            matrix_set(2, matrix_build_identity());
        });
        updateShape();
    }
    
    with (newChild("results text"))
    {
        setVisible(false);
        setX(getParent().getShapeWidth() / 2);
        setBottom(uiGet("results body").getShapeTop() - 9);
        setWidth(0.1 * sprite_get_width(sResultsSignA));
        setHeight(0.1 * sprite_get_height(sResultsSignA));
        textElement = scribble("[fa_center][fa_middle][scale,0.7]" + loc("result game over"), rootInstance).starting_format(locGetFontFromLanguage(), make_color_rgb(36, 145, 249));
        var _scale = (getRawWidth() - 12) / textElement.get_width();
        
        if (_scale < 1)
            textElement.transform(_scale, _scale, 0);
        
        delayTime = 0;
        inTweenTime = 0;
        eventAddFunction(UnknownEnum.Value_1, function()
        {
            if (getVisible())
            {
                if (inTweenTime < 1)
                {
                    inTweenTime = min(1, inTweenTime + 0.04);
                }
                else if (delayTime < 20)
                {
                    delayTime++;
                    
                    if (delayTime >= 20)
                        uiGet("results body").setVisible(true);
                }
            }
        });
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            var _scale = animcurve_tween(0.5, 1, curveBackInv, inTweenTime);
            matrix_set(2, matrix_build(outVisXCenter, outVisYCenter, 0, 0, 0, 0, _scale, _scale, 1));
            draw_sprite_ext(sResultsSignA, 0, 0, 0, 0.1, 0.1, 0, c_white, 1);
            textElement.draw(0, 0);
            matrix_set(2, matrix_build_identity());
        });
    }
    
    with (newChild("results lobby button"))
    {
        uiTemplateSpriteScaled(sResultsLobbyButton, 0, 0.1);
        setVisible(false);
        setActive(false);
        setX(getParent().getShapeWidth() / 2);
        setTop(uiGet("results body").getShapeBottom() + 2);
        delayTime = _ignoreClicksDelay;
        inTweenTime = 0;
        visYOffset = 30;
        visAlpha = 0;
        eventAddFunction(UnknownEnum.Value_5, function()
        {
        });
        eventAddFunction(UnknownEnum.Value_1, function()
        {
            if (getVisible())
            {
                inTweenTime = min(1, inTweenTime + 0.027777777777777776);
                visYOffset = animcurve_tween(30, 0, curveExpoInv, inTweenTime);
                visAlpha = inTweenTime;
            }
        });
        eventAddFunction(UnknownEnum.Value_9, function()
        {
            if (delayTime <= 0)
                imageIndex = 1;
        });
        eventAddFunction(UnknownEnum.Value_11, function()
        {
            if (inTweenTime >= 1 && getActive())
                delayTime--;
            
            imageIndex = 0;
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            if (imageIndex == 1 && inTweenTime >= 1)
                roomTransitionTo(rmPlayableMainMenu, "lobby normal");
        });
    }
}
