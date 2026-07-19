var menuElement;
if (!global.ingamePause)
    playSoundAbilityEquipMenuSelect();

pauseStart();
audioSetVolumeTarget(global.areaMusic, 0.25, 0.16666666666666666);
var _textSize = 1.2;
var _buttonHeight = 19;
draw_set_halign(fa_left);
draw_set_valign(fa_top);

for (var i = 0; i < UnknownEnum.Value_9; i += 1)
    menuElement[i] = false;

var _postEndElements = 0;

switch (room)
{
    case rmMainGame:
        menuElement[UnknownEnum.Value_0] = true;
        menuElement[UnknownEnum.Value_4] = true;
        
        if (!abilityCheck(UnknownEnum.Value_22))
        {
            menuElement[UnknownEnum.Value_6] = true;
        }
        else
        {
            menuElement[UnknownEnum.Value_8] = true;
            
            if (os_type == os_windows || os_type == os_macosx || os_type == os_linux)
                menuElement[UnknownEnum.Value_5] = true;
        }
        
        _postEndElements = true;
        break;
    
    case rmPlayableMainMenu:
        menuElement[UnknownEnum.Value_0] = true;
        menuElement[UnknownEnum.Value_4] = true;
        
        if (os_type == os_windows || os_type == os_macosx || os_type == os_linux)
            menuElement[UnknownEnum.Value_5] = true;
        
        _postEndElements = true;
        break;
    
    case rmTutorialMovement2:
        menuElement[UnknownEnum.Value_0] = true;
        menuElement[UnknownEnum.Value_4] = true;
        break;
    
    default:
        menuElement[UnknownEnum.Value_0] = true;
        menuElement[UnknownEnum.Value_7] = true;
        menuElement[UnknownEnum.Value_4] = true;
        menuElement[UnknownEnum.Value_8] = true;
        break;
}

if (global.endingReached >= UnknownEnum.Value_2 && _postEndElements)
{
    menuElement[UnknownEnum.Value_2] = true;
    menuElement[UnknownEnum.Value_3] = true;
}

menuElement[UnknownEnum.Value_1] = global.debugControl;
menuElement[UnknownEnum.Value_3] = max(menuElement[UnknownEnum.Value_3], global.debugEnableLeaderboard);

with (uiCreate("pause menu root"))
{
    eventAddFunction(UnknownEnum.Value_0, function()
    {
        setLTRBToWindow();
    });
    updateShape();
    
    with (newChild())
    {
        setX(0.5 * getParent().getShapeWidth());
        setY(0.2 * getParent().getShapeHeight());
        drawMenuHeaderText(loc("pause header"));
    }
    
    with (newChild())
    {
        setLeft(15);
        setWidth(getParent().getShapeWidth() - 30);
        setTop(100);
        setFlow("list", "y");
        setFlowAlignment("center", "middle", "center", "middle");
        setFlowSpacing(20, 20, 20, 0, 0, 5);
        updateShape();
        eventAddFunction(UnknownEnum.Value_14, function()
        {
            instance_destroy(rootInstance);
            pauseEnd();
        });
        
        if (menuElement[UnknownEnum.Value_0])
        {
            with (newChild())
            {
                uiTemplateButtonLimit(loc("pause resume"), _textSize, getParent().getShapeWidth() - 24);
                setHeight(_buttonHeight);
                eventAddFunction(UnknownEnum.Value_10, function()
                {
                    playSoundBackButton();
                    instance_destroy(rootInstance);
                    pauseEnd();
                });
            }
        }
        
        if (menuElement[UnknownEnum.Value_7])
        {
            with (newChild())
            {
                uiTemplateButtonLimit(loc("puzzle list"), _textSize, getParent().getShapeWidth() - 24);
                setHeight(_buttonHeight);
                eventAddFunction(UnknownEnum.Value_10, function()
                {
                    instance_destroy(rootInstance);
                    
                    with (instance_create_depth(0, 0, 0, oPuzzleMenu))
                        fromPauseMenu = 1;
                });
            }
        }
        
        if (menuElement[UnknownEnum.Value_2])
        {
            with (newChild())
            {
                uiTemplateButtonLimit(loc("pause trophy"), _textSize, getParent().getShapeWidth() - 24);
                setHeight(_buttonHeight);
                eventAddFunction(UnknownEnum.Value_10, function()
                {
                    playSoundAbilityEquipMenuSelect();
                    instance_destroy(rootInstance);
                    instance_create_depth(0, 0, 0, oTrophyMenu);
                });
            }
        }
        
        if (menuElement[UnknownEnum.Value_3])
        {
            with (newChild())
            {
                uiTemplateButtonLimit(loc("leaderboards title"), _textSize, getParent().getShapeWidth() - 24);
                setHeight(_buttonHeight);
                eventAddFunction(UnknownEnum.Value_10, function()
                {
                    instance_destroy(rootInstance);
                    
                    if (leaderboardsLoginState() >= 1)
                        instance_create_depth(0, 0, 0, oLeaderboardsMenu);
                    else
                        instance_create_depth(0, 0, 0, oServiceSignInMenu);
                });
            }
        }
        
        if (menuElement[UnknownEnum.Value_4])
        {
            with (newChild())
            {
                uiTemplateButtonLimit(loc("pause settings"), _textSize, getParent().getShapeWidth() - 24);
                setHeight(_buttonHeight);
                eventAddFunction(UnknownEnum.Value_10, function()
                {
                    playSoundAbilityEquipMenuSelect();
                    instance_destroy(rootInstance);
                    instance_create_depth(0, 0, 0, oSettingsMenu);
                });
            }
        }
        
        if (menuElement[UnknownEnum.Value_5])
        {
            with (newChild())
            {
                uiTemplateButtonLimit(loc("pause quit game"), _textSize, getParent().getShapeWidth() - 24);
                setHeight(_buttonHeight);
                eventAddFunction(UnknownEnum.Value_10, function()
                {
                    saveGame(true);
                    game_end();
                });
            }
        }
        
        if (menuElement[UnknownEnum.Value_6])
        {
            with (newChild())
            {
                uiTemplateButtonLimit(loc("pause end run"), _textSize, getParent().getShapeWidth() - 24);
                setHeight(_buttonHeight);
                eventAddFunction(UnknownEnum.Value_10, function()
                {
                    global.tutorialOver = max(1, global.tutorialOver);
                    global.lifePoint = 0;
                    instance_activate_object(oPlayer);
                    
                    with (oPlayer)
                    {
                        playerComboLoss();
                        xsp = 0;
                        ysp = 0;
                        currentState = "dead";
                        deathResetTimer = 1;
                    }
                    
                    instance_destroy(rootInstance);
                    pauseEnd();
                });
            }
        }
        
        if (menuElement[UnknownEnum.Value_8])
        {
            with (newChild())
            {
                uiTemplateButtonLimit(loc("pause return to lobby"), _textSize, getParent().getShapeWidth() - 24);
                setHeight(_buttonHeight);
                eventAddFunction(UnknownEnum.Value_10, function()
                {
                    if (abilityCheck(UnknownEnum.Value_22))
                        roomTransitionTo(rmPlayableMainMenu, "lobby normal");
                    else if (global.gameReinitializeState == "puzzle")
                        roomTransitionTo(rmPlayableMainMenu, "return from puzzle");
                    
                    instance_destroy(rootInstance);
                    pauseEnd();
                });
            }
        }
        
        if (menuElement[UnknownEnum.Value_1])
        {
            with (newChild())
            {
                uiTemplateButtonLimit("*Debug", _textSize, getParent().getShapeWidth() - 24);
                setHeight(_buttonHeight);
                eventAddFunction(UnknownEnum.Value_10, function()
                {
                    instance_destroy(rootInstance);
                    instance_create_depth(0, 0, 0, oDebugMenu010321);
                });
            }
        }
    }
}
