function leaderboardsGetFilter(arg0)
{
    switch (arg0)
    {
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_2:
        case UnknownEnum.Value_3:
        case UnknownEnum.Value_4:
        case UnknownEnum.Value_5:
        case UnknownEnum.Value_6:
        case UnknownEnum.Value_7:
        case UnknownEnum.Value_8:
        case UnknownEnum.Value_9:
            return (os_type == os_ios && !global.netflixEnabled) ? 0 : "achievement_filter_all_players";
        
        case UnknownEnum.Value_10:
        case UnknownEnum.Value_11:
        case UnknownEnum.Value_12:
        case UnknownEnum.Value_13:
        case UnknownEnum.Value_14:
        case UnknownEnum.Value_15:
        case UnknownEnum.Value_16:
        case UnknownEnum.Value_17:
        case UnknownEnum.Value_18:
        case UnknownEnum.Value_19:
            return (os_type == os_ios && !global.netflixEnabled) ? 1 : "achievement_filter_friends_only";
    }
    
    traceError("Leaderboards: Leaderboard \"", arg0, "\" not supported");
}
