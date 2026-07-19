pauseStart();
draw_set_halign(fa_left);
draw_set_valign(fa_top);

with (uiCreate("trophy root"))
{
    uiTemplateRectangle(make_color_rgb(46, 50, 59), 0.3);
    eventAddFunction(UnknownEnum.Value_0, function()
    {
        setLTRBToWindow();
    });
    updateShape();
    eventAddFunction(UnknownEnum.Value_10, function()
    {
        uiGet("trophy selected").borderT = 0;
        rootInstance.selectedArea = undefined;
        rootInstance.selectedLevel = undefined;
    });
    eventAddFunction(UnknownEnum.Value_14, function()
    {
        uiFocusForce("trophy back");
    });
    
    with (newChild("trophy header"))
    {
        setX(0.5 * getParent().getShapeWidth());
        setTop(0.13 * getParent().getShapeHeight());
        drawMenuHeaderText(loc("trophy header"));
        updateShape();
    }
    
    with (newChild("trophy back"))
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
                uiGet("trophy selected").borderT = 0;
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
            instance_destroy(rootInstance);
            instance_create_depth(0, 0, 0, oPauseMenu);
        });
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            playSoundBackButton();
            instance_destroy(rootInstance);
            instance_create_depth(0, 0, 0, oPauseMenu);
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
        updateShape();
    }
    
    with (newChild("trophy panel"))
    {
        setX(getParent().getShapeWidth() / 2);
        setWidth(getParent().getShapeWidth() - 8);
        setTop(uiGet("trophy header").getShapeBottom() + 11);
        setBottom(uiGet("trophy back").getShapeTop() - 13);
        setFlow("list", "y");
        setFlowAlignment("center", "top", "left", "top");
        setFlowSpacing(0, 4, 0, 4, 0, 3);
        clipChildrenAllow = true;
        scrollAllow = true;
        updateShape();
        var _i = 0;
        
        repeat (UnknownEnum.Value_15)
        {
            with (newChild())
            {
                trophyIndex = _i;
                trophyUnlocked = global.achievementTrophyGotList[| trophyIndex];
                trophySprite = global.medalSprite[trophyIndex];
                
                if (trophyUnlocked == undefined)
                {
                    trophyUnlocked = false;
                    trace("Warning! Trophy index ", trophyIndex, " state not found in global.achievementTrophyGotList");
                }
                
                scale = 0.2;
                setHeight(sprite_get_height(sTrophyTextbox) * scale);
                setWidth((sprite_get_width(sTrophyTextbox) * scale) + getRawHeight() + 4);
                selected = false;
                eventAddFunction(UnknownEnum.Value_4, function()
                {
                    if (input_player_source_get() == UnknownEnum.Value_2)
                    {
                        scrollTo();
                        selected = true;
                    }
                });
                eventAddFunction(UnknownEnum.Value_7, function()
                {
                    selected = false;
                });
                eventAddFunction(UnknownEnum.Value_2, function()
                {
                    if (selected)
                        draw_sprite_ext(sTrophyTextboxHighlight, trophyUnlocked, getDrawLeft() + getDrawHeight() + 4, getDrawTop(), scale, scale, 0, c_white, 1);
                    
                    draw_sprite_stretched(trophySprite, trophyUnlocked, getDrawLeft(), getDrawTop(), getDrawHeight(), getDrawHeight());
                    draw_sprite_stretched(sTrophyCase, trophyUnlocked, getDrawLeft(), getDrawTop(), getDrawHeight(), getDrawHeight());
                    draw_sprite_ext(sTrophyTextbox, trophyUnlocked, getDrawLeft() + getDrawHeight() + 4, getDrawTop(), scale, scale, 0, c_white, 1);
                    scribble("[scale,0.28]" + getTrophyText(trophyIndex)).fit_to_box(getDrawWidth() - getDrawHeight() - 21, getDrawHeight() - 10, locIsAsian()).starting_format(locGetFontFromLanguage(), make_color_rgb(46, 50, 59)).align(0, 1).draw(getDrawLeft() + getDrawHeight() + 11, getDrawY());
                });
            }
            
            _i++;
        }
        
        updateShape();
    }
    
    with (newChild())
    {
        setActive(false);
        setLeft(uiGet("trophy panel").getShapeLeft() - getParent().getShapeLeft());
        setTop(uiGet("trophy panel").getShapeTop() - getParent().getShapeTop());
        setRight(uiGet("trophy panel").getShapeRight() - getParent().getShapeLeft());
        setBottom(uiGet("trophy panel").getShapeBottom() - getParent().getShapeTop());
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            var _parent = getParent();
            uiDrawPauseSurfacePartExt(getDrawLeft(), getDrawTop(), getDrawRight(), getDrawTop() + 4, _parent.visBlend, _parent.visAlpha, 1, 1, 0, 0);
            uiDrawPauseSurfacePartExt(getDrawLeft(), getDrawBottom() - 3, getDrawRight(), getDrawBottom() + 1, _parent.visBlend, _parent.visAlpha, 0, 0, 1, 1);
        });
    }
}
