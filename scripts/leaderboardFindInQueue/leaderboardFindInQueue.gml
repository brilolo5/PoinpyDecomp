function leaderboardFindInQueue(arg0)
{
    var _i = 0;
    
    repeat (array_length(global.__leaderboardQueue))
    {
        if (global.__leaderboardQueue[_i] == arg0)
            return _i;
        
        _i++;
    }
    
    return undefined;
}
