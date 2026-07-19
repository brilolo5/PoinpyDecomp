global.__puzzleData = [];
global.__puzzleAreaCount = 0;

function puzzleDataReset()
{
    var _areaCount = (argument_count > 0) ? argument[0] : undefined;
    var _levelCount = (argument_count > 1) ? argument[1] : undefined;
    
    if (_areaCount != undefined)
        global.__puzzleAreaCount = _areaCount;
    
    if (_levelCount != undefined)
        global.puzzleLevelCount = _levelCount;
    
    _areaCount ??= global.__puzzleAreaCount;
    
    _levelCount ??= global.puzzleLevelCount;
    
    trace("Puzzle: Reinitialising puzzle data to ", _areaCount, "x", _levelCount);
    global.__puzzleData = array_create(_areaCount, undefined);
    var _i = 0;
    
    repeat (_areaCount)
    {
        var _areaArray = array_create(_levelCount, undefined);
        array_set(global.__puzzleData, _i, _areaArray);
        var _j = 0;
        
        repeat (_levelCount)
        {
            array_set(_areaArray, _j, 
            {
                unlocked: false,
                cleared: false
            });
            _j++;
        }
        
        _i++;
    }
}

function puzzleDataDebugReset()
{
    var _areaCount = (argument_count > 0) ? argument[0] : undefined;
    var _levelCount = (argument_count > 1) ? argument[1] : undefined;
    
    if (_areaCount != undefined)
        global.__puzzleAreaCount = _areaCount;
    
    if (_levelCount != undefined)
        global.puzzleLevelCount = _levelCount;
    
    _areaCount ??= global.__puzzleAreaCount;
    
    _levelCount ??= global.puzzleLevelCount;
    
    trace("Puzzle: Reinitialising puzzle data to ", _areaCount, "x", _levelCount);
    global.__puzzleData = array_create(_areaCount, undefined);
    var _i = 0;
    
    repeat (_areaCount)
    {
        var _areaArray = array_create(_levelCount, undefined);
        array_set(global.__puzzleData, _i, _areaArray);
        var _j = 0;
        
        repeat (_levelCount)
        {
            array_set(_areaArray, _j, 
            {
                unlocked: false,
                cleared: false
            });
            array_set(_areaArray, _j, 
            {
                unlocked: true,
                cleared: true
            });
            _j++;
        }
        
        _i++;
    }
    
    puzzleDataClearedSet(UnknownEnum.Value_6, 2, false);
}
