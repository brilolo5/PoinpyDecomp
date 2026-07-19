uiTick("service root");

if (alarm[0] < 0)
{
    if (input_player_source_get() == UnknownEnum.Value_1)
    {
        uiFocusCursor("service root", device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), input_check("menu select"), input_check("menu back"));
    }
    else if (input_player_source_get() == UnknownEnum.Value_2)
    {
        var _dx = input_value("menu right") - input_value("menu left");
        var _dy = input_value("menu down") - input_value("menu up");
        uiFocusGamepad("service root", _dx, _dy, input_check("menu select"), input_check("menu back"));
    }
}

if (alarm[0] <= 0)
{
    var _state = leaderboardsLoginState();
    
    switch (_state)
    {
        case -1:
            if (previousSignInState != _state)
            {
                previousSignInState = _state;
                uiGroupDeactivate("service root", "service sign in group");
                uiGroupActivate("service root", "service retry group");
            }
            
            break;
        
        case 0:
            if (previousSignInState != _state)
            {
                previousSignInState = _state;
                uiGroupDeactivate("service root", "service sign in group");
                uiGroupDeactivate("service root", "service retry group");
            }
            
            break;
        
        case 1:
        case 2:
            trace("Leaderboards: Signed in, submitting cached scores");
            leaderboardsPostCachedScores();
            instance_destroy();
            instance_create_depth(0, 0, 0, oLeaderboardsMenu);
            break;
    }
}
