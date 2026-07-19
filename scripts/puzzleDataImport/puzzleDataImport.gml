function puzzleDataImport(arg0)
{
    if (!is_string(arg0) || arg0 == "")
    {
        trace("Puzzle: Data string was empty or invalid, resetting puzzle data");
        puzzleDataReset();
        exit;
    }
    
    trace("Puzzle: Importing data from string");
    global.__puzzleData = json_parse(arg0);
}
