actualDelta = delta_time / 1000000;
deltaRate = actualDelta / targetDelta;
state_timer--;

if (state_timer <= 0)
{
    var _state = state_order[state_index];
    
    switch (_state)
    {
        case UnknownEnum.Value_0:
            fade_alpha = max(0, fade_alpha - (fadeSpeed * deltaRate));
            
            if (fade_alpha <= 0)
            {
                state_index++;
                state_timer = 0;
            }
            
            break;
        
        case UnknownEnum.Value_1:
            splashScreenTimer += actualDelta;
            
            if (splashScreenTimer >= splashScreenDisplayTime)
            {
                state_index++;
                state_timer = 0;
            }
            
            break;
        
        case UnknownEnum.Value_5:
            trace("Init: Loading localisation");
            initializeLocalisation();
            state_index++;
            state_timer = 1;
            break;
        
        case UnknownEnum.Value_6:
            trace("Init: Loading Scribble");
            initializeScribble();
            state_index++;
            state_timer = 1;
            break;
        
        case UnknownEnum.Value_7:
            trace("Init: Loading Input");
            initializeInput();
            state_index++;
            state_timer = 1;
            break;
        
        case UnknownEnum.Value_8:
            trace("Init: Loading audio");
            audio_master_gain(1);
            audio_group_load(2);
            audio_group_load(1);
            state_index++;
            state_timer = 1;
            break;
        
        case UnknownEnum.Value_9:
            trace("Init: Executing initializeGame()");
            initializeGame();
            state_index++;
            state_timer = 1;
            break;
        
        case UnknownEnum.Value_10:
            if (global.netflixEnabled)
            {
                state_timer = 1;
                NetflixCheckUserAuth();
            }
            else
            {
                state_timer = 0;
            }
            
            state_index++;
            break;
        
        case UnknownEnum.Value_11:
            if (IsValidNetflixLoginId())
            {
                if (global.netflixProfileLanguage != -1)
                {
                    trace("Init: netflixUserId: " + global.netflixProfileid);
                    state_timer = 1;
                    state_index++;
                }
                else
                {
                    trace("Init Netflix: Waiting for language data");
                }
            }
            else
            {
                NetflixGetCurrentProfileData();
                
                if (!global.netflixEnabled)
                {
                    state_timer = 0;
                    state_index++;
                }
            }
            
            break;
        
        case UnknownEnum.Value_12:
            trace("Init: Loading savedata");
            loadGame();
            state_index++;
            state_timer = 1;
            break;
        
        case UnknownEnum.Value_13:
            if (loaded)
            {
                initCheckAndSetLanguage();
                toggleEquippedAbility();
                juicerRankUpdate();
                global.puzzleAreaUnlockedUpTo = puzzleDataUnlockSetsForUnlockedAreas();
                state_index++;
                
                if ((os_type == os_windows || os_type == os_macosx || os_type == os_linux) && global.fullscreen)
                {
                    window_set_fullscreen(true);
                    display_set_gui_size(display_get_width(), display_get_height());
                    state_timer = 10;
                }
            }
            else
            {
                trace("Init: Waiting for savedata...");
            }
            
            break;
        
        case UnknownEnum.Value_14:
            state_index++;
            state_timer = 0;
            break;
        
        case UnknownEnum.Value_3:
            trace("Init: Initializing textures");
            TextureManagerGoto(global.tutorialOver ? "main menu" : "tutorial", false);
            
            if (os_type == os_switch)
                switch_set_cpu_boost_mode(1);
            
            state_index++;
            state_timer = 1;
            break;
        
        case UnknownEnum.Value_4:
            if (TexanCommitStep())
            {
                if (os_type == os_switch)
                    switch_set_cpu_boost_mode(0);
                
                state_index++;
                state_timer = 1;
            }
            
            break;
        
        case UnknownEnum.Value_2:
            fade_alpha = min(1, fade_alpha + (fadeSpeed * deltaRate));
            
            if (fade_alpha >= 1)
            {
                delayAfterFadeOut -= (0.016666666666666666 * deltaRate);
                
                if (delayAfterFadeOut <= 0)
                {
                    state_index++;
                    state_timer = 0;
                }
            }
            
            break;
        
        case UnknownEnum.Value_15:
            trace("Init: Resizing window");
            initializeWindow(false);
            state_index++;
            state_timer = 10;
            break;
        
        case UnknownEnum.Value_16:
            trace("Init: Creating controllers");
            var _t = current_time;
            instance_create_depth(0, 0, -10000, oControl);
            instance_create_depth(0, 0, -10000, oAudioController);
            instance_create_depth(0, 0, -10000, oDraw);
            state_index++;
            state_timer = 0;
            break;
        
        case UnknownEnum.Value_17:
            if (splashState >= 3)
            {
                trace("Init: Done! Going to next room");
                initializeGotoNextRoom();
                state_index++;
                state_timer = 0;
            }
            
            break;
        
        case UnknownEnum.Value_18:
            leaderboardsLogIn();
            state_index++;
            state_timer = 0;
            break;
        
        case UnknownEnum.Value_19:
            if (leaderboardsLoginState() > 0)
            {
                if (leaderboardsLoginState() == 1)
                {
                    trace("Init: Login succeeded, submitting cached scores");
                    leaderboardsPostCachedScores();
                }
                else
                {
                    trace("Init: Leaderboards not supported, proceeding");
                }
                
                state_index++;
                state_timer = 0;
            }
            else if (leaderboardsLoginState() < 0)
            {
                trace("Init: Login failed, proceeding");
                state_index++;
                state_timer = 0;
            }
            
            break;
    }
}

if (mouse_check_button_pressed(mb_left))
    hurryInput = 1;

var _splashTimerRate = 1 + hurryInput;

switch (splashState)
{
    case 0:
        splashTimer += (deltaRate * (_splashTimerRate / 120));
        splashText = "[scale, 0.3][sDevolverDigitalLogo,0][/scale]";
        splashText = "[scale, 0.9]Devolver Digital\n[scale, 0.7]presents";
        
        if (splashTimer >= 1)
        {
            splashTimer = 0;
            splashState += 1;
        }
        
        break;
    
    case 1:
        splashTimer += (deltaRate * (_splashTimerRate / 240));
        splashText = "[scale, 0.7]A game created by\n\n[scale, 0.9]Ojiro Fumoto\nerror403\nCalum Bowen\nA Shell in the Pit\nJuju Adams\nGobo3D[scale, 0.7]\n\n\nand many others\nin the credits";
        
        if (splashTimer >= 1)
        {
            splashTimer = 0;
            splashState += 1;
        }
        
        break;
    
    case 2:
        splashTimer += (deltaRate * (_splashTimerRate / 60));
        splashText = "";
        hurryInput = 0;
        
        if (splashTimer >= 1)
        {
            splashTimer = 0;
            splashState += 1;
        }
        
        break;
}
