function puzzleDataUnlockedGet(arg0, arg1)
{
    if (arg0 < 0 || arg0 >= array_length(global.__puzzleData))
    {
        trace("Puzzle: Area ", arg0, " out of bounds (0 -> ", array_length(global.__puzzleData) - 1, ")");
        return false;
    }
    
    var _areaArray = global.__puzzleData[arg0];
    
    if (arg1 < 0 || arg1 >= array_length(_areaArray))
    {
        trace("Puzzle: Level ", arg0, " out of bounds (0 -> ", array_length(_areaArray) - 1, ")");
        return false;
    }
    
    var _struct = _areaArray[arg1];
    
    if (!is_struct(_struct) || !variable_struct_exists(_struct, "unlocked"))
    {
        trace("Puzzle: Invalid data found at ", arg0, ", ", arg1);
        return false;
    }
    
    return _struct.unlocked;
}
