function leaderboardsFindID(arg0, arg1)
{
    switch (arg0)
    {
        case UnknownEnum.Value_4:
            return arg1 ? UnknownEnum.Value_9 : UnknownEnum.Value_8;
        
        case UnknownEnum.Value_3:
            return arg1 ? UnknownEnum.Value_7 : UnknownEnum.Value_6;
        
        case UnknownEnum.Value_2:
            return arg1 ? UnknownEnum.Value_5 : UnknownEnum.Value_4;
        
        case UnknownEnum.Value_1:
            return arg1 ? UnknownEnum.Value_3 : UnknownEnum.Value_2;
        
        case UnknownEnum.Value_0:
            return arg1 ? UnknownEnum.Value_1 : UnknownEnum.Value_0;
    }
    
    return undefined;
}
