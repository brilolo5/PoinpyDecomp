global.timeScaledTime += global.timeScale;
global.time += 1;
audioSystemTick();
leaderboardsTick();
debugLiveCallStep();

if ((os_type == os_macosx || os_type == os_windows) && !global.fullscreen)
{
    global.userWindowWidth = window_get_width();
    global.userWindowHeight = window_get_height();
}

if (global.debugControl)
{
    if (keyboard_check_pressed(ord("R")))
    {
        gameRestart();
        exit;
    }
    
    if (keyboard_check_pressed(ord("T")))
    {
        if (global.userWindowWidth != -1)
        {
            _windowWidth = global.userWindowWidth;
            _windowHeight = global.userWindowHeight;
        }
        
        window_set_size(_windowWidth, _windowHeight);
    }
    
    if (keyboard_check_pressed(ord("L")))
    {
        with (oPlayer)
        {
            repeat (8)
            {
                gainComboElement(getFruitSprite(UnknownEnum.Value_0), UnknownEnum.Value_0, 0);
                gainComboElement(getFruitSprite(UnknownEnum.Value_4), UnknownEnum.Value_4, 0);
            }
            
            playerComboPayout(true);
        }
    }
}

var _oldSource = input_player_source_get();

if (input_tick())
{
    if (_oldSource == UnknownEnum.Value_2 && !input_player_connected())
    {
        if (!instance_exists(oControllerDisconnectMenu))
            instance_create_depth(0, 0, 0, oControllerDisconnectMenu);
    }
}

input_hotswap_tick();

if (!global.mainGamePaused && global.lifePoint > 0 && !global.playerControlLock && room != rmInit)
    global.allowPauseMenu = 1;
else
    global.allowPauseMenu = 0;

if (global.allowPauseMenu)
{
    if (((os_type == os_ios || os_type == os_android) && (device_mouse_check_button_pressed(0, mb_left) && device_mouse_y_to_gui(0) < 48)) || ((os_type == os_windows || os_type == os_macosx || os_type == os_linux) && (device_mouse_check_button_pressed(0, mb_left) && guiCursorInRange(pauseButtonX, pauseButtonY, 8))) || input_check_released("pause") || global.gameReturnedTo)
    {
        global.gameReturnedTo = 0;
        global.mainGamePaused = 1;
        instance_create_depth(0, 0, 0, oPauseMenu);
    }
}

if (!global.mainGamePaused && room == rmMainGame)
{
    var viewy = getViewy(global.cam);
    var viewx = getViewx(global.cam);
    var _cullingWindowWidth = global.viewWidth * 3;
    var _cullWindowHeight = global.viewHeight * 2;
    var _cullWindowLeft = viewx - global.viewWidth;
    var _cullWindowCenter = viewy + (global.viewHeight / 2);
    var _cullingWindowTop = _cullWindowCenter - (_cullWindowHeight / 2);
    instance_deactivate_region(_cullWindowLeft, _cullingWindowTop, _cullingWindowWidth, _cullWindowHeight, false, true);
    instance_activate_region(_cullWindowLeft, _cullingWindowTop, _cullingWindowWidth, _cullWindowHeight, true);
    instance_activate_object(oWall);
    instance_activate_object(oOnewayPlatform);
    instance_activate_object(parentMenu);
    instance_activate_object(parentControl);
    instance_activate_object(oNetflixControl);
    instance_activate_object(parentScreenEffect);
    instance_activate_object(oAudioController);
    instance_activate_object(oEndingSequence);
    instance_activate_object(oEndingSequence_BeastDialogue);
    instance_activate_object(oEndCredit);
    instance_activate_object(parentTutorial);
    instance_activate_object(oCamera);
    instance_activate_object(oDiscoveryLine);
    instance_activate_object(oStarfieldTest2);
    instance_activate_object(parentBackgroundFront);
    instance_activate_object(parentBackground);
    instance_activate_object(oOrderControl);
    instance_activate_object(oBeastMainGame);
    instance_activate_object(oPlayer);
    instance_activate_object(oMagma);
    instance_activate_object(oLevelBuilder);
    instance_activate_object(oJuiceHomingParticleEmitter);
    instance_activate_object(parentGUIEffect);
    
    if ((global.time % 3) == 0 && room == rmMainGame)
    {
        var distance = 1024;
        var _cullTop = oPlayer.y + distance;
        var _cullingUnit = 64;
        var unloadRegionLeft = -1000;
        var unloadRegionRight = 1000;
        var unloadRegionTop = _cullTop;
        var unloadRegionBottom = global.unloadLevelArea_y;
        instance_activate_region(unloadRegionLeft, unloadRegionTop, unloadRegionRight - unloadRegionLeft, unloadRegionBottom - unloadRegionTop, 1);
        var foodInstanceList = ds_list_create();
        var foodInstanceNumber = collision_rectangle_list(unloadRegionLeft, unloadRegionTop, unloadRegionRight, unloadRegionBottom, all, 0, 1, foodInstanceList, false);
        
        // Entries are a mix of concrete objects and parents, so children have to be
        // matched too - oGameBackground hangs off parentBackground, oPlayer off parentEntity.
        var _keep = [parentControl, oGameBackground, oNetflixControl, parentScreenEffect, oAudioController, oEndingSequence, oEndingSequence_BeastDialogue, oEndCredit, oPlayer, parentMenu, oCamera, oLevelBuilder, parentTutorial, parentGUIEffect, oBeastMainGame, oMagma, oDraw, oStarfieldTest2];
        var _keepNum = array_length(_keep);
        
        for (var i = 0; i < foodInstanceNumber; i += 1)
        {
            var _inst = foodInstanceList[| i];
            
            if (!instance_exists(_inst))
                continue;
            
            var _obj = _inst.object_index;
            var _safe = false;
            
            for (var k = 0; k < _keepNum; k += 1)
            {
                if (_obj == _keep[k] || object_is_ancestor(_obj, _keep[k]))
                {
                    _safe = true;
                    break;
                }
            }
            
            if (!_safe)
                instance_destroy(_inst);
        }
        
        global.unloadLevelArea_y = min(global.unloadLevelArea_y, _cullTop);
        ds_list_destroy(foodInstanceList);
    }
}

instance_activate_object(obj_gmlive);
instance_activate_object(oNetflixControl);
instance_activate_object(oDraw);
instance_activate_object(oAudioController);
