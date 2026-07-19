if ((y % 48) == 0)
{
    var _yOffset = 0;
    var _targetAbove = instance_place(x, y - 16, oWall);
    var _targetAboveAbove = 1;
    var _targetBelow = instance_place(x, y + 16, oWall);
    var _targetBelowBelow = 1;
    
    if (_targetAbove && _targetAboveAbove && _targetAbove.object_index == oWall)
    {
        instance_destroy(_targetAbove);
        _yOffset -= 8;
        _targetAbove = 1;
    }
    else
    {
        _targetAbove = 0;
    }
    
    if (_targetBelow && _targetBelowBelow && _targetBelow.object_index == oWall)
    {
        instance_destroy(_targetBelow);
        _yOffset += 8;
        _targetBelow = 1;
    }
    else
    {
        _targetBelow = 0;
    }
    
    image_yscale += (_targetBelow + _targetAbove);
    y += _yOffset;
}
