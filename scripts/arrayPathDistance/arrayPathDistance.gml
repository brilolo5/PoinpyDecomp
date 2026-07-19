function arrayPathDistance(arg0)
{
    var _x1 = undefined;
    var _y1 = undefined;
    var _x2 = arg0[0];
    var _y2 = arg0[1];
    var _distance = 0;
    var _i = 2;
    
    repeat ((array_length(arg0) div 2) - 1)
    {
        _x1 = _x2;
        _y1 = _y2;
        _x2 = arg0[_i];
        _y2 = arg0[_i + 1];
        _distance += point_distance(_x1, _y1, _x2, _y2);
        _i += 2;
    }
    
    return _distance;
}
