function scoreSquishPackSingle()
{
    var _points = argument[0];
    var _abilityArray = (argument_count > 1 && is_array(argument[1])) ? argument[1] : undefined;
    
    if (_points <= 0)
    {
        trace("Scoresquish: Warning! Points less than or equal to zero");
        return undefined;
    }
    else if (_points > 999)
    {
        trace("Scoresquish: Warning! Points greater than ", 999);
        _points = 999;
    }
    
    if (floor(_points) != _points)
    {
        trace("Scoresquish: Warning! Points is not an integer");
        _points = floor(_points);
    }
    
    var _output = _points;
    return _output;
}
