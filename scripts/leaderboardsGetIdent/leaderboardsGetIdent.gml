function leaderboardsGetIdent(arg0)
{
    if (!(os_type == os_ios || os_type == os_android))
        return undefined;
    
    switch (arg0)
    {
        case UnknownEnum.Value_0:
        case UnknownEnum.Value_10:
            if (os_type == os_ios || global.netflixEnabled)
                return "bestSingleScore10";
            else if (os_type == os_android)
                return "CgkI-ICgj6ELEAIQAA";
            
            break;
        
        case UnknownEnum.Value_1:
        case UnknownEnum.Value_11:
            if (os_type == os_ios || global.netflixEnabled)
                return "bestAverageScore10";
            else if (os_type == os_android)
                return "CgkI-ICgj6ELEAIQAQ";
            
            break;
        
        case UnknownEnum.Value_2:
        case UnknownEnum.Value_12:
            if (os_type == os_ios || global.netflixEnabled)
                return "bestSingleScore8";
            else if (os_type == os_android)
                return "CgkI-ICgj6ELEAIQAg";
            
            break;
        
        case UnknownEnum.Value_3:
        case UnknownEnum.Value_13:
            if (os_type == os_ios || global.netflixEnabled)
                return "bestAverageScore8";
            else if (os_type == os_android)
                return "CgkI-ICgj6ELEAIQAw";
            
            break;
        
        case UnknownEnum.Value_4:
        case UnknownEnum.Value_14:
            if (os_type == os_ios || global.netflixEnabled)
                return "bestSingleScore6";
            else if (os_type == os_android)
                return "CgkI-ICgj6ELEAIQBA";
            
            break;
        
        case UnknownEnum.Value_5:
        case UnknownEnum.Value_15:
            if (os_type == os_ios || global.netflixEnabled)
                return "bestAverageScore6";
            else if (os_type == os_android)
                return "CgkI-ICgj6ELEAIQBQ";
            
            break;
        
        case UnknownEnum.Value_6:
        case UnknownEnum.Value_16:
            if (os_type == os_ios || global.netflixEnabled)
                return "bestSingleScore4";
            else if (os_type == os_android)
                return "CgkI-ICgj6ELEAIQBg";
            
            break;
        
        case UnknownEnum.Value_7:
        case UnknownEnum.Value_17:
            if (os_type == os_ios || global.netflixEnabled)
                return "bestAverageScore4";
            else if (os_type == os_android)
                return "CgkI-ICgj6ELEAIQBw";
            
            break;
        
        case UnknownEnum.Value_8:
        case UnknownEnum.Value_18:
            if (os_type == os_ios || global.netflixEnabled)
                return "bestSingleScore2";
            else if (os_type == os_android)
                return "CgkI-ICgj6ELEAIQCA";
            
            break;
        
        case UnknownEnum.Value_9:
        case UnknownEnum.Value_19:
            if (os_type == os_ios || global.netflixEnabled)
                return "bestAverageScore2";
            else if (os_type == os_android)
                return "CgkI-ICgj6ELEAIQCQ";
            
            break;
    }
    
    traceError("Leaderboards: Leaderboard \"", arg0, "\" not supported");
}
