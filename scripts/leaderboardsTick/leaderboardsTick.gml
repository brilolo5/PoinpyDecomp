function leaderboardsTick()
{
    if (global.__leaderboardsUpdating == undefined)
    {
        if (array_length(global.__leaderboardQueue) > 0)
        {
            var _leaderboard = global.__leaderboardQueue[0];
            array_delete(global.__leaderboardQueue, 0, 1);
            var _name = leaderboardsGetName(_leaderboard);
            var _ident = leaderboardsGetIdent(_leaderboard);
            var _filter = leaderboardsGetFilter(_leaderboard);
            var _state = global.__leaderboardState[_leaderboard];
            global.__leaderboardsUpdating = _leaderboard;
            _state.pending = true;
            _state.startTime = current_time;
            
            if (global.netflixEnabled)
            {
                if (_filter == "achievement_filter_all_players")
                    NetflixLeaderboardGetEntries(_ident);
                else
                    NetflixLeaderboardGetEntriesAroundPlayer(_ident);
            }
            else if (os_type == os_ios)
            {
                extension_stubfunc_real(_ident, 1, 100, _filter, 2);
            }
            else
            {
            }
            
            trace("Leaderboards: Updating leaderboard (\"", _name, "\", ident=", _ident, ", filter=", _filter, ")");
        }
    }
    else
    {
        with (global.__leaderboardState[global.__leaderboardsUpdating])
        {
            if (pending && startTime != undefined)
            {
                if ((current_time - startTime) > ((os_type == os_ios) ? 30000 : 15000))
                {
                    pending = false;
                    startTime = undefined;
                    receivedTime = current_time;
                    failed = true;
                    trace("Leaderboards: Failed to update leaderboard \"", leaderboardsGetName(global.__leaderboardsUpdating), "\"");
                    global.__leaderboardsUpdating = undefined;
                }
            }
        }
    }
}
