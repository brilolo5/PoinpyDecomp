function scoreSquishUnpackAverage(arg0)
{
    var _historicArray = array_create(4, -1);
    
    if (arg0 < power(10, 11))
    {
        return 
        {
            points: arg0 / 100,
            abilityArray: array_create(6, -1),
            single: true,
            historicArray: _historicArray
        };
    }
    else
    {
        var _working = arg0;
        array_set(_historicArray, 0, _working % 1000);
        _working = floor(_working / 1000);
        array_set(_historicArray, 1, _working % 1000);
        _working = floor(_working / 1000);
        array_set(_historicArray, 2, _working % 1000);
        _working = floor(_working / 1000);
        var _average = _working / 100;
        array_set(_historicArray, 3, round((4 * _average) - (array_get(_historicArray, 0) + array_get(_historicArray, 1) + array_get(_historicArray, 2))));
        return 
        {
            points: _average,
            abilityArray: array_create(6, -1),
            single: false,
            historicArray: _historicArray
        };
    }
}
