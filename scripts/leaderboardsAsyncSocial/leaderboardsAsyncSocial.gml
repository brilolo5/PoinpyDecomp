function leaderboardsAsyncSocial()
{
    trace("LeaderboardsAsyncSocial func: Social Async: ", json_encode(async_load));
    var _id = async_load[? "id"];
    
    if (global.__leaderboardsLogInPending)
    {
        switch (os_type)
        {
            case os_ios:
                if (async_load[? "type"] == "GameCenter_Authenticate")
                {
                    global.__leaderboardsLogInPending = false;
                    
                    if (leaderboardsIsLoggedIn())
                        trace("Leaderboards: Login successful");
                    else
                        trace("Leaderboards: Login unsuccessful");
                }
                
                break;
            
            case os_android:
                if (async_load[? "type"] == "GooglePlayServices_SignIn" || global.netflixEnabled)
                {
                    global.__leaderboardsLogInPending = false;
                    trace("Leaderboards: Login successful");
                }
                
                break;
        }
    }
    
    if (global.__leaderboardsUpdating != undefined)
    {
        if (_id == "achievement_leaderboard_info")
        {
            var _state = async_load[? "status"];
            var _leaderboardIdent = async_load[? "leaderboardid"];
            var _count = async_load[? "numentries"];
            var _action = async_load[? "action"];
            var _expectedIdent = leaderboardsGetIdent(global.__leaderboardsUpdating);
            
            if (_leaderboardIdent != _expectedIdent)
            {
                with (oLeaderboardsMenu)
                {
                    if (leaderboardScope != "global")
                    {
                        with (global.__leaderboardState[global.__leaderboardsUpdating])
                        {
                            pending = false;
                            startTime = undefined;
                            receivedTime = undefined;
                            failed = false;
                        }
                        
                        global.__leaderboardsUpdating = undefined;
                        leaderboardScope = "global";
                        updateLeaderboard();
                    }
                    else
                    {
                        trace("Leaderboards: Warning! Received data for leaderboard \"", _leaderboardIdent, "\" but we were expecting \"", _expectedIdent, "\"");
                    }
                }
            }
            else
            {
                if (_state != "OK")
                {
                    with (oLeaderboardsMenu)
                    {
                        if (leaderboardScope != "global")
                        {
                            with (global.__leaderboardState[global.__leaderboardsUpdating])
                            {
                                pending = false;
                                startTime = undefined;
                                receivedTime = undefined;
                                failed = false;
                            }
                            
                            global.__leaderboardsUpdating = undefined;
                            leaderboardScope = "global";
                            updateLeaderboard();
                        }
                        else
                        {
                            trace("Leaderboards: Warning! Data failed for leaderboard (\"", leaderboardsGetName(global.__leaderboardsUpdating), "\", id=", leaderboardsGetIdent(global.__leaderboardsUpdating), ", filter=", leaderboardsGetFilter(global.__leaderboardsUpdating), ")");
                            
                            with (global.__leaderboardState[global.__leaderboardsUpdating])
                            {
                                pending = false;
                                startTime = undefined;
                                receivedTime = current_time;
                                failed = true;
                            }
                        }
                    }
                }
                else
                {
                    trace("Leaderboards: Data obtained for leaderboard, entries = ", _count, " (\"", leaderboardsGetName(global.__leaderboardsUpdating), "\", id=", leaderboardsGetIdent(global.__leaderboardsUpdating), ", filter=", leaderboardsGetFilter(global.__leaderboardsUpdating), ")");
                    var _leaderboardData = global.__leaderboardData[global.__leaderboardsUpdating];
                    
                    if (_action == "replace")
                        array_resize(_leaderboardData, 0);
                    
                    var includesPlayerScore = false;
                    var _i = 0;
                    
                    repeat (_count)
                    {
                        var _player = async_load[? concat("Player", _i)];
                        var _playerID = async_load[? concat("Playerid", _i)];
                        var _rank = async_load[? concat("Rank", _i)];
                        var _score = async_load[? concat("Score", _i)];
                        
                        if (_score == undefined)
                        {
                            var _scoreLow = async_load[? concat("ScoreLow", _i)];
                            var _scoreHigh = async_load[? concat("ScoreHigh", _i)];
                            _score = _scoreLow | (_scoreHigh << 32);
                        }
                        
                        var _unpacked;
                        
                        if (leaderboardsGetSingle(global.__leaderboardsUpdating))
                            _unpacked = scoreSquishUnpackSingle(_score);
                        else
                            _unpacked = scoreSquishUnpackAverage(_score);
                        
                        if (_player == "")
                            _player = "??????";
                        
                        if (_playerID == "")
                            _playerID = "??????";
                        
                        trace("Leaderboards: ", _i, ", player = \"", _player, "\", id = \"", _playerID, "\", rank = ", _rank, ", raw score = ", _score, ", points = ", _unpacked.points, ", abilities = ", _unpacked.abilityArray);
                        array_push(_leaderboardData, 
                        {
                            player: _player,
                            playerID: _playerID,
                            rank: _rank,
                            points: _unpacked.points,
                            abilityArray: _unpacked.abilityArray,
                            single: _unpacked.single,
                            historicArray: _unpacked.historicArray,
                            showHistoric: false,
                            isPlayer: _playerID == global.netflixProfileid
                        });
                        _i++;
                    }
                    
                    array_sort(_leaderboardData, function(arg0, arg1)
                    {
                        return arg0.rank - arg1.rank;
                    });
                    
                    with (global.__leaderboardState[global.__leaderboardsUpdating])
                    {
                        pending = false;
                        startTime = undefined;
                        receivedTime = current_time;
                        failed = false;
                    }
                }
                
                global.__leaderboardsUpdating = undefined;
            }
        }
    }
}
