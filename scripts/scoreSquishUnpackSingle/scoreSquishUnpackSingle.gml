function scoreSquishUnpackSingle(arg0)
{
    var _working = arg0;
    var _divisor = power(10, 12);
    var _points = floor(arg0 / _divisor);
    _working -= (_points * _divisor);
    
    if (_points <= 0)
    {
        return 
        {
            points: arg0,
            abilityArray: array_create(6, -1),
            single: true,
            historicArray: [-1, -1, -1, -1]
        };
    }
    else
    {
        var _abilityArray = array_create(6, -1);
        var _i = 5;
        
        repeat (6)
        {
            _divisor = power(33, _i);
            var _value = floor(_working / _divisor);
            _working -= (_value * _divisor);
            array_set(_abilityArray, _i, _value - 1);
            _i--;
        }
        
        return 
        {
            points: _points,
            abilityArray: _abilityArray,
            single: true,
            historicArray: [-1, -1, -1, -1]
        };
    }
}
