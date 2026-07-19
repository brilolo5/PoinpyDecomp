function puzzleDataClearedSet(arg0, arg1, arg2)
{
    if (arg0 < 0 || arg0 >= array_length(global.__puzzleData))
    {
        trace("Puzzle: Area ", arg0, " out of bounds (0 -> ", array_length(global.__puzzleData) - 1, ")");
        return false;
    }
    
    var _areaArray = global.__puzzleData[arg0];
    
    if (arg1 == -3)
    {
        var _i = 0;
        
        repeat (global.puzzleLevelCount)
        {
            puzzleDataClearedSet(arg0, _i, arg2);
            _i++;
        }
        
        return true;
    }
    
    if (arg1 < 0 || arg1 >= array_length(_areaArray))
    {
        trace("Puzzle: Level ", arg0, " out of bounds (0 -> ", array_length(_areaArray) - 1, ")");
        return false;
    }
    
    var _struct = _areaArray[arg1];
    
    if (!is_struct(_struct))
        return false;
    
    if (!variable_struct_exists(_struct, "cleared"))
        return false;
    
    trace("Puzzle: Set cleared state for ", arg0, ", ", arg1, " = ", arg2);
    _struct.cleared = arg2;
}
