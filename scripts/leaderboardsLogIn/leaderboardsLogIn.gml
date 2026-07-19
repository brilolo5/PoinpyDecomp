global.__leaderboardsLogInPending = false;

function leaderboardsLogIn()
{
    if (!(os_type == os_ios || os_type == os_android))
    {
        trace("Leaderboards: Not on iOS/Android, skipping login");
    }
    else if (global.__leaderboardsLogInPending)
    {
        trace("Leaderboards: Login already pending");
    }
    else if (leaderboardsIsLoggedIn())
    {
        trace("Leaderboards: Already logged in");
    }
    else
    {
        trace("Leaderboards: Logging in");
        
        if (os_type == os_ios)
            extension_stubfunc_real();
        else if (os_type == os_android)
            exit;
        
        global.__leaderboardsLogInPending = true;
    }
}
