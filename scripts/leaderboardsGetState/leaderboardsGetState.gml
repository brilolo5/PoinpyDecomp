function leaderboardsGetState(arg0)
{
    if (global.__leaderboardState[arg0].pending)
        return 0;
    
    if (global.__leaderboardState[arg0].failed)
        return -1;
    
    return 1;
}
