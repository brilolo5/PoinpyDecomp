function leaderboardsDebugFill()
{
    var _j;
    trace("Leaderboards: Filling leaderboards with random data");
    var _i = 0;
    
    repeat (UnknownEnum.Value_20)
    {
        with (global.__leaderboardState[_i])
        {
            pending = false;
            startTime = current_time;
            queueTime = current_time;
            receivedTime = undefined;
            failed = false;
        }
        
        var _data = global.__leaderboardData[_i];
        array_resize(_data, 0);
        
        if (leaderboardsGetSingle(_i))
        {
            _j = 0;
            
            repeat (leaderboardsGetGlobal(_i) ? 100 : 20)
            {
                var _abilityArray = array_create(6);
                var _k = 0;
                
                repeat (6)
                {
                    array_set(_abilityArray, _k, irandom(UnknownEnum.Value_29));
                    _k++;
                }
                
                var _playerName = "p" + string(_j) + " ";
                
                repeat (irandom(10))
                    _playerName += chr(choose(irandom_range(97, 122), irandom_range(65, 90)));
                
                array_push(_data, 
                {
                    player: _playerName,
                    playerID: _i,
                    rank: 0,
                    points: irandom_range(0, 999),
                    abilityArray: _abilityArray,
                    single: true,
                    historicArray: [-1, -1, -1, -1],
                    showHistoric: false
                });
                _j++;
            }
        }
        else
        {
            _j = 0;
            
            repeat (leaderboardsGetGlobal(_i) ? 100 : 20)
            {
                var _historicArray = array_create(4, -1);
                var _average = 0;
                var _k = 0;
                
                repeat (array_length(_historicArray))
                {
                    var _score = irandom(999);
                    array_set(_historicArray, _k, _score);
                    _average += _score;
                    _k++;
                }
                
                _average /= array_length(_historicArray);
                _average = floor(_average * 100) / 100;
                var _playerName = "p" + string(_j) + " ";
                
                repeat (irandom(10))
                    _playerName += chr(choose(irandom_range(97, 122), irandom_range(65, 90)));
                
                array_push(_data, 
                {
                    player: _playerName,
                    playerID: _i,
                    rank: 0,
                    points: _average,
                    abilityArray: [-1, -1, -1, -1, -1, -1],
                    single: true,
                    historicArray: _historicArray,
                    showHistoric: false
                });
                _j++;
            }
        }
        
        array_sort(_data, function(arg0, arg1)
        {
            return arg1.points - arg0.points;
        });
        _j = 0;
        
        repeat (array_length(_data))
        {
            _data[_j].rank = _j + 1;
            _j++;
        }
        
        _i++;
    }
}
