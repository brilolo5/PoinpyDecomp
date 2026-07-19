function inRange(arg0, arg1, arg2)
{
    var _checkingVar = arg0;
    var _targetVar = arg1;
    var _range = arg2;
    
    if (_checkingVar > (_targetVar - _range) && _checkingVar < (_targetVar + _range))
        return true;
    else
        return false;
}

function inRange_values(arg0, arg1, arg2)
{
    var _checkingVar = arg0;
    
    if (_checkingVar > arg1 && _checkingVar < arg2)
        return true;
    else
        return false;
}
