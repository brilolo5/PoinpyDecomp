levelUpReached = 0;
levelUpReachedNotifTimer = 0;
moneyTransitionSequenceStartTimerMax = 120;
moneyTransitionSequenceStartTimer = moneyTransitionSequenceStartTimerMax;
pBlink = 0;
skipTap = 0;
checkAffordable = 0;
gameTime = global.oneGameTime;
gameScore = global.mainGameFruitProgress_total;
newHighScore = 0;
allowTapToReturnTimer = 60;
endlessMode = getEndlessMode();

if (endlessMode > -1)
{
    if (gameScore > global.endlessHighScore[endlessMode])
    {
        newHighScore = 1;
        global.endlessHighScore[endlessMode] = gameScore;
        saveGame();
    }
}
