function inRectArea()
{
    var _checkingx = argument[0];
    var _checkingy = argument[1];
    var _targetx = argument[2];
    var _targety = argument[3];
    var _targetWidth = argument[4];
    var _targetHeight = argument[5];
    
    if (abs(_checkingx - _targetx) <= _targetWidth && abs(_checkingy - _targety) <= _targetHeight)
        return true;
    else
        return false;
}
