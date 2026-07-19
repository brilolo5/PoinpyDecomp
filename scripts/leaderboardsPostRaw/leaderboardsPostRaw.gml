function leaderboardsPostRaw(arg0, arg1)
{
    if ((os_type == os_ios || os_type == os_android) && (os_type == os_ios || os_type == os_android))
    {
        if (arg1 == undefined)
        {
            trace("Leaderboards: Score is invalid, ignoring post to \"", leaderboardsGetName(arg0), "\"");
            exit;
        }
        
        var _ident = leaderboardsGetIdent(arg0);
        
        if (_ident == undefined)
        {
            traceError("Leaderboards: ", arg0, " not recognised");
        }
        else if (arg1 <= 0)
        {
            trace("Leaderboards: Raw score is <= 0 (", arg1, "), not posting score to \"", leaderboardsGetName(arg0), "\" (id = ", _ident, ")");
        }
        else
        {
            trace("Leaderboards: Posting raw score ", arg1, " to \"", leaderboardsGetName(arg0), "\" (id = ", _ident, ")");
            
            if (global.netflixEnabled)
            {
                NetflixPostScore(_ident, arg1);
            }
            else if (os_type == os_ios)
            {
                extension_stubfunc_string(_ident, arg1 & 4294967295, arg1 >> 32);
            }
            else
            {
            }
        }
    }
}
