function puzzleDataRoomExists(arg0, arg1)
{
    if (arg0 < 0 || arg0 >= array_length(global.puzzleRoomList))
        return false;
    
    var _areaArray = global.puzzleRoomList[arg0];
    
    if (arg1 < 0 || arg1 >= array_length(_areaArray))
        return false;
    
    return _areaArray[arg1] != -1;
}
