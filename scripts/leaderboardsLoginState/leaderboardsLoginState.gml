function leaderboardsLoginState()
{
    if (!(os_type == os_ios || os_type == os_android))
        return 2;
    
    if (leaderboardsIsLoggedIn())
        return 1;
    
    if (global.__leaderboardsLogInPending)
        return 0;
    
    return -1;
}
