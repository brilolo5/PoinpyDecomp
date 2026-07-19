global.__splineArray = [];

function splineInterpolate()
{
    var _time = argument[0];
    var _array = argument[1];
    var _result = (argument_count > 2 && is_array(argument[2])) ? argument[2] : global.__splineArray;
    
    if (_time <= 0)
    {
        if (_result == undefined)
            return [_array[0], _array[1]];
        
        array_set(_result, 0, _array[0]);
        array_set(_result, 1, _array[1]);
        return _result;
    }
    
    var _length = array_length(_array);
    
    if (_time >= 1)
    {
        if (_result == undefined)
            return [_array[_length - 2], _array[_length - 1]];
        
        array_set(_result, 0, _array[_length - 2]);
        array_set(_result, 1, _array[_length - 1]);
        return _result;
    }
    
    _result ??= array_create(_length);
    
    array_resize(_result, _length);
    array_copy(_result, 0, _array, 0, _length);
    var _count = _length div 2;
    
    repeat (_count)
    {
        _count--;
        __splineReduce(_time, _result, _count);
    }
    
    return _result;
}

function __splineReduce(arg0, arg1, arg2)
{
    var _x1 = undefined;
    var _y1 = undefined;
    var _x2 = arg1[0];
    var _y2 = arg1[1];
    var _i = 0;
    var _j = 2;
    
    repeat (arg2)
    {
        _x1 = _x2;
        _y1 = _y2;
        _x2 = arg1[_j];
        _y2 = arg1[_j + 1];
        array_set(arg1, _i, lerp(_x1, _x2, arg0));
        array_set(arg1, _i + 1, lerp(_y1, _y2, arg0));
        _i = _j;
        _j += 2;
    }
}
