function scoreSquishPackAverage(arg0, arg1 = -1)
{
    var _average = 0;
    var _i = 0;
    
    repeat (ds_list_size(arg0))
    {
        var _historicScore = arg0[| _i];
        
        if (_historicScore < 0)
        {
            trace("Scoresquish: Warning! Historic score ", _i, " less than zero");
            _historicScore = 0;
        }
        else if (_historicScore > 999)
        {
            trace("Scoresquish: Warning! Historic score ", _i, " greater than ", 999);
            _historicScore = 999;
        }
        
        if (floor(_historicScore) != _historicScore)
        {
            trace("Scoresquish: Warning! Historic score ", _i, " is not an integer");
            _historicScore = floor(_historicScore);
            arg0[| _i] = _historicScore;
        }
        
        _average += _historicScore;
        _i++;
    }
    
    _average = arg1;
    _average = floor(_average * 100) / 100;
    
    if (_average <= 0)
    {
        trace("Scoresquish: Warning! Average points less than or equal to zero");
        return undefined;
    }
    else if (_average > 999)
    {
        trace("Scoresquish: Warning! Average points greater than ", 999);
        _average = 999;
    }
    
    var _output = 100 * _average;
    return _output;
}
