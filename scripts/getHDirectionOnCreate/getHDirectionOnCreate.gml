function getHDirectionOnCreate(arg0, arg1, arg2)
{
    var _noFlip = arg0;
    var _oppositeSide = arg1;
    var _xdirection = arg2;
    
    if (!_noFlip)
    {
        var _imageXscaleCheck = _xdirection;
        
        if (_oppositeSide)
            _imageXscaleCheck *= -1;
        
        if (sign(((room_width / 2) - x) + 1) != sign(_imageXscaleCheck))
            _xdirection *= -1;
    }
    
    return _xdirection;
}
