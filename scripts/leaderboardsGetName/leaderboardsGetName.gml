function leaderboardsGetName(arg0)
{
    var _name;
    
    switch (arg0)
    {
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_10:
        case UnknownEnum.Value_2:
        case UnknownEnum.Value_12:
        case UnknownEnum.Value_4:
        case UnknownEnum.Value_14:
        case UnknownEnum.Value_6:
        case UnknownEnum.Value_16:
        case UnknownEnum.Value_8:
        case UnknownEnum.Value_18:
            _name = "Highest";
            break;
        
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_11:
        case UnknownEnum.Value_3:
        case UnknownEnum.Value_13:
        case UnknownEnum.Value_5:
        case UnknownEnum.Value_15:
        case UnknownEnum.Value_7:
        case UnknownEnum.Value_17:
        case UnknownEnum.Value_9:
        case UnknownEnum.Value_19:
            _name = "Average";
            break;
        
        default:
            show_debug_message("Leaderboards: Leaderboard \"" + string(arg0) + "\" not supported");
            break;
    }
    
    switch (arg0)
    {
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_10:
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_11:
            _name += " 10 Jumps";
            break;
        
        case UnknownEnum.Value_2:
        case UnknownEnum.Value_12:
        case UnknownEnum.Value_3:
        case UnknownEnum.Value_13:
            _name += " 8 Jumps";
            break;
        
        case UnknownEnum.Value_4:
        case UnknownEnum.Value_14:
        case UnknownEnum.Value_5:
        case UnknownEnum.Value_15:
            _name += " 6 Jumps";
            break;
        
        case UnknownEnum.Value_6:
        case UnknownEnum.Value_16:
        case UnknownEnum.Value_7:
        case UnknownEnum.Value_17:
            _name += " 4 Jumps";
            break;
        
        case UnknownEnum.Value_8:
        case UnknownEnum.Value_18:
        case UnknownEnum.Value_9:
        case UnknownEnum.Value_19:
            _name += " 2 Jumps";
            break;
        
        default:
            show_debug_message("Leaderboards: Leaderboard \"" + string(arg0) + "\" not supported");
            break;
    }
    
    var _filter = leaderboardsGetFilter(arg0);
    
    if (!global.netflixEnabled)
    {
        if (_filter == 0 || _filter == 0)
            _name += " Global";
        else if (_filter == 1 || _filter == 1)
            _name += " Friends";
        else
            show_debug_message("Leaderboards: Leaderboard \"" + string(arg0) + "\" not supported");
    }
    
    return _name;
}
