function leaderboardsIsLoggedIn()
{
    if (global.netflixEnabled)
        return IsValidNetflixLoginId();
    
    switch (os_type)
    {
        case os_ios:
            return extension_stubfunc_real();
        
        case os_android:
            return extension_stubfunc_real();
        
        default:
            trace("Leaderboards: Not supported on this platform");
            return false;
    }
}
