if (live_call())
    return global.live_result;

pauseStart();
var _buttonHeight = 15;
draw_set_halign(fa_left);
draw_set_valign(fa_top);
nextLanguage = locGetLanguage();
actionToCofirm = undefined;
previousPage = undefined;
returnedTo = 0;

CollectSetttingsState = function()
{
    oldMusicEnabled = global.musicEnabled;
    oldSoundEnabled = global.soundEnabled;
    oldInvertSwipe = global.invertSwipe;
    oldSlowerTimeScale = global.accessibilityTimeScale;
    oldScreenshakeEnabled = global.screenshakeEnabled;
    oldWideGame = global.wideGame;
    oldFullscreen = global.fullscreen;
    oldLanguage = global.__locLanguage;
};

CommitChanges = function()
{
    var _force_non_async = (argument_count > 0) ? argument[0] : undefined;
    
    if (oldMusicEnabled != global.musicEnabled || oldSoundEnabled != global.soundEnabled || oldInvertSwipe != global.invertSwipe || oldSlowerTimeScale != global.accessibilityTimeScale || oldScreenshakeEnabled != global.screenshakeEnabled || oldWideGame != global.wideGame || oldLanguage != global.__locLanguage || oldFullscreen != global.fullscreen)
    {
        CollectSetttingsState();
        saveGame(_force_non_async);
    }
};

CollectSetttingsState();

with (uiCreate("settings root"))
{
    eventAddFunction(UnknownEnum.Value_0, function()
    {
        setLTRBToWindow();
    });
    updateShape();
    eventAddFunction(UnknownEnum.Value_14, function()
    {
        instance_destroy(rootInstance);
        instance_create_depth(0, 0, 0, oPauseMenu);
    });
    
    with (newChild("settings title"))
    {
        setX(getParent().getShapeWidth() / 2);
        setY(0.2 * getParent().getShapeHeight());
        drawMenuHeaderText(loc("settings header"));
        updateShape();
    }
    
    with (newChild("settings main back", "settings main group"))
    {
        uiTemplateButtonLimit(loc("settings return"), 1.3, getParent().getShapeWidth() - 70);
        shapeHeight = _buttonHeight;
        setX(getParent().getShapeWidth() / 2);
        setY(0.875 * getParent().getShapeHeight());
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            playSoundBackButton();
            callEventInChildren();
            instance_destroy(rootInstance);
            instance_create_depth(0, 0, 0, oPauseMenu);
        });
        updateShape();
    }
    
    with (newChild("settings panel", "settings main group"))
    {
        setX(getParent().getShapeWidth() / 2);
        setWidth(getParent().getShapeWidth() - 20);
        setY(0.5 * (uiGet("settings title").getShapeBottom() + uiGet("settings main back").getShapeTop()));
        setFlow("list", "y");
        setFlowAlignment("center", "middle", "center", "middle");
        setFlowSpacing(0, 0, 0, 0, 0, 5);
        updateShape();
        
        if (!(os_type == os_switch || os_type == os_ps4 || os_type == os_xboxone))
        {
            with (newChild(undefined, "settings main group"))
            {
                uiTemplateSettingsMultichoice(loc("settings language"), 0.85, getParent().getShapeWidth(), 999, locGetLanguage);
                setWidth(getParent().getShapeWidth());
                setHeight(_buttonHeight);
                eventAddFunction(UnknownEnum.Value_10, function()
                {
                    uiGroupActivate(rootTag, "settings language group");
                    uiGroupDeactivate(rootTag, "settings main group");
                });
            }
        }
        
        with (newChild(undefined, "settings main group"))
        {
            uiTemplateSettingsScaler_test(loc("settings music"), 0.85, getParent().getShapeWidth(), 999, "musicEnabled", -1);
            setWidth(getParent().getShapeWidth());
            setHeight(_buttonHeight);
        }
        
        with (newChild(undefined, "settings main group"))
        {
            uiTemplateSettingsScaler_test(loc("settings sound"), 0.85, getParent().getShapeWidth(), 999, "soundEnabled", sfx_player_slam_tail_01);
            setWidth(getParent().getShapeWidth());
            setHeight(_buttonHeight);
        }
        
        with (newChild(undefined, "settings main group"))
        {
            uiTemplateSettingsScaler_test(loc("settings timescale"), 0.85, getParent().getShapeWidth(), 999, "accessibilityTimeScale", -1);
            setWidth(getParent().getShapeWidth());
            setHeight(_buttonHeight);
        }
        
        with (newChild(undefined, "settings main group"))
        {
            uiTemplateSettingsToggle(loc("settings invert swipe"), 0.85, getParent().getShapeWidth(), 999, "invertSwipe");
            setWidth(getParent().getShapeWidth());
            setHeight(_buttonHeight);
        }
        
        if ((os_type == os_ios || os_type == os_android) && global.hapticAvailable)
        {
            with (newChild(undefined, "settings main group"))
            {
                uiTemplateSettingsToggle(loc("settings haptics"), 0.85, getParent().getShapeWidth(), 999, "hapticEnabled");
                setWidth(getParent().getShapeWidth());
                setHeight(_buttonHeight);
            }
        }
        
        with (newChild(undefined, "settings main group"))
        {
            uiTemplateSettingsToggle(loc("settings screenshake"), 0.85, getParent().getShapeWidth(), 999, "screenshakeEnabled");
            setWidth(getParent().getShapeWidth());
            setHeight(_buttonHeight);
        }
        
        if (os_type == os_windows || os_type == os_macosx || os_type == os_linux)
        {
            with (newChild(undefined, "settings main group"))
            {
                uiTemplateSettingsToggle(loc("settings fullscreen"), 0.85, getParent().getShapeWidth(), 999, "fullscreen");
                setWidth(getParent().getShapeWidth());
                setHeight(_buttonHeight);
                eventAddFunction(UnknownEnum.Value_8, function()
                {
                    global.fullscreen = window_get_fullscreen();
                });
                eventAddFunction(UnknownEnum.Value_10, function()
                {
                    callEventInChildren();
                    window_set_fullscreen(global.fullscreen);
                    rootInstance.alarm[0] = 30;
                });
            }
        }
        
        if (room == rmPlayableMainMenu)
        {
            with (newChild(undefined, "settings main group"))
            {
                uiTemplateSettingsCredits(loc("settings credits"), 0.85, getParent().getShapeWidth(), 999, "");
                setWidth(getParent().getShapeWidth());
                setHeight(_buttonHeight);
            }
        }
        
        updateShape();
        setHeight(outFlowAreaHeight);
        updateShape();
    }
    
    with (newChild("settings language back", "settings language group"))
    {
        uiTemplateButtonLimit(loc("settings return"), 1.3, getParent().getShapeWidth() - 70);
        shapeHeight = _buttonHeight;
        setX(getParent().getShapeWidth() / 2);
        setY(0.85 * getParent().getShapeHeight());
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            uiGroupActivate(rootTag, "settings main group");
            uiGroupDeactivate(rootTag, "settings language group");
        });
        updateShape();
    }
    
    with (newChild("settings language panel", "settings language group"))
    {
        setX(getParent().getShapeWidth() / 2);
        setWidth(getParent().getShapeWidth() - 20);
        setTop(uiGet("settings title").getShapeBottom() + 15);
        setBottom(uiGet("settings language back").getShapeTop() - 15);
        setFlow("list", "y");
        setFlowAlignment("center", "top", "center", "middle");
        setFlowSpacing(0, 0, 0, 0, 0, 3);
        scrollAllow = true;
        clipChildrenAllow = true;
        updateShape();
        var _i = 0;
        
        repeat (array_length(global.__locLanguageArray))
        {
            var _language = global.__locLanguageArray[_i];
            
            with (newChild(undefined, "settings language group"))
            {
                language = _language;
                uiTemplateButtonLimit(locGetLanguageNameInTheirLanguage(language), 1.1, getParent().getShapeWidth() - 30);
                setHeight(_buttonHeight);
                eventAddFunction(UnknownEnum.Value_10, function()
                {
                    if (locGetLanguage() == language)
                    {
                        uiGroupActivate(rootTag, "settings main group");
                        uiGroupDeactivate(rootTag, "settings language group");
                    }
                    else
                    {
                        rootInstance.nextLanguage = language;
                        rootInstance.previousPage = "settings language group";
                        rootInstance.actionToCofirm = "change language";
                        uiGroupActivate(rootTag, "settings confirm group");
                        uiGroupDeactivate(rootTag, "settings language group");
                    }
                });
            }
            
            _i++;
        }
        
        updateShape();
    }
    
    with (newChild("settings confirm", "settings confirm group"))
    {
        text = "[scale,0.45]" + loc("settings confirm text");
        visBlend = make_color_rgb(255, 255, 255);
        borderColor = make_color_rgb(46, 50, 59);
        borderThickness = 4;
        textElement = scribble(text).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).wrap(getParent().getShapeWidth() - 16);
        setX(getParent().getShapeWidth() / 2);
        setY((getParent().getShapeHeight() / 2) - 30);
        setWidth(textElement.get_width());
        setHeight(textElement.get_height());
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            textElement.blend(visBlend, visAlpha).msdf_border(borderColor, borderThickness).draw(getDrawLeft(), getDrawTop());
        });
        updateShape();
    }
    
    with (newChild("settings confirm accept", "settings confirm group"))
    {
        uiTemplateButtonLimit(loc("settings accept"), 1.3, getParent().getShapeWidth() - 70);
        setHeight(_buttonHeight);
        setX(getParent().getShapeWidth() / 2);
        setTop(uiGet("settings confirm").getShapeBottom() + 10);
        updateShape();
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            switch (rootInstance.actionToCofirm)
            {
                case "change language":
                    global.languageSetByUser = rootInstance.nextLanguage;
                    locSetLanguage(rootInstance.nextLanguage);
                    rootInstance.CommitChanges(true);
                    instance_destroy(rootInstance);
                    pauseEnd();
                    gameRestart();
                    break;
                
                case "change wide game":
                    global.wideGame = !global.wideGame;
                    rootInstance.CommitChanges(true);
                    instance_destroy(rootInstance);
                    pauseEnd();
                    debugGameRestart();
                    break;
            }
        });
    }
    
    with (newChild("settings confirm back", "settings confirm group"))
    {
        uiTemplateButtonLimit(loc("settings return"), 1.3, getParent().getShapeWidth() - 70);
        setHeight(_buttonHeight);
        setX(getParent().getShapeWidth() / 2);
        setTop(uiGet("settings confirm accept").getShapeBottom() + 10);
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            playSoundBackButton();
            uiGroupActivate(rootTag, rootInstance.previousPage);
            uiGroupDeactivate(rootTag, "settings confirm group");
        });
    }
}

uiGroupDeactivate("settings root", "settings language group");
uiGroupDeactivate("settings root", "settings confirm group");
