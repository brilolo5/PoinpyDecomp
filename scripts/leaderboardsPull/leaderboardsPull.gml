function leaderboardsPull(arg0, arg1 = false)
{
    var _state = global.__leaderboardState[arg0];
    var _name = leaderboardsGetName(arg0);
    var _ident = leaderboardsGetIdent(arg0);
    var _filter = leaderboardsGetFilter(arg0);
    
    if (os_type != os_ios && os_type != os_android)
    {
        trace("Leaderboards: Not supported on this platform");
    }
    else if (!leaderboardsIsLoggedIn())
    {
        trace("Leaderboards: Not logged in");
    }
    else if (_filter != 0 && _filter != 1 && _filter != 0 && _filter != 1 && !global.netflixEnabled)
    {
        traceError("Filter ", _filter, " not supported");
    }
    else if (_state.queueTime != undefined && _state.pending)
    {
        trace("Leaderboards: Update pending, time in queue = ", current_time - _state.queueTime, ", time in transit = ", (_state.startTime == undefined) ? "<not yet started>" : (current_time - _state.startTime), " (\"", _name, "\", ident=", _ident, ", filter=", _filter, ")");
        var _queueIndex = leaderboardFindInQueue(arg0);
        
        if (_queueIndex != undefined)
        {
            array_delete(global.__leaderboardQueue, _queueIndex, 1);
            array_insert(global.__leaderboardQueue, 0, arg0);
            _state.queueTime = current_time;
        }
    }
    else if (!arg1 && _state.receivedTime != undefined && (current_time - _state.receivedTime) < 60000)
    {
        trace("Leaderboards: Received data for this leaderboard recently (", current_time - _state.receivedTime, "ms ago), ignoring pull command (\"", _name, "\", ident=", _ident, ", filter=", _filter, ")");
    }
    else
    {
        trace("Leaderboards: Queuing (\"", _name, "\", ident=", _ident, ", filter=", _filter, ")");
        _state.pending = true;
        _state.queueTime = current_time;
        array_push(global.__leaderboardQueue, arg0);
    }
}
