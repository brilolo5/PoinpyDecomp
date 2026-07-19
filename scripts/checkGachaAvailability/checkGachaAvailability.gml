function checkGachaAvailability()
{
    if (global.moneyJar >= getGachaCost() && areThereItemsLeftToGetFromGacha())
        return true;
    else
        return false;
}

function checkNewPuzzleAvailability()
{
    if (global.puzzleModeUnlocked && global.puzzleAreaUnlockNotification)
        return true;
    else
        return false;
}
