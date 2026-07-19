function getHoopBoostedSpeeds(arg0, arg1, arg2)
{
    var target = arg0;
    var xsp = arg1;
    var ysp = arg2;
    var _boost = 1;
    var _hoopAngle = target.image_angle + 90;
    var _playerJumpAngle = point_direction(0, 0, xsp, ysp);
    var _angleDifference = angle_difference(_playerJumpAngle, _hoopAngle);
    
    if (abs(_angleDifference) > 90)
        _boost = 0;
    
    if (_boost)
    {
        var _boostSpeed = 4;
        xsp += lengthdir_x(_boostSpeed, _hoopAngle);
        ysp += lengthdir_y(_boostSpeed, _hoopAngle);
        var _currentSpeed = getSpeed(xsp, ysp);
        var _maxSpeed = 7;
        var _minSpeed = 4;
        
        if (_currentSpeed > _maxSpeed)
        {
            xsp *= (_maxSpeed / _currentSpeed);
            ysp *= (_maxSpeed / _currentSpeed);
        }
        else if (_currentSpeed < _minSpeed)
        {
            xsp *= (_minSpeed / _currentSpeed);
            ysp *= (_minSpeed / _currentSpeed);
        }
    }
    
    var _returnSpeed;
    _returnSpeed[0] = xsp;
    _returnSpeed[1] = ysp;
    return _returnSpeed;
}
