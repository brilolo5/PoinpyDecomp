function fruitCountAdd()
{
    global.mainGameFruitProgress = approach(global.mainGameFruitProgress, 99999, argument[0]);
    global.mainGameFruitProgress_total = approach(global.mainGameFruitProgress_total, 99999, argument[0]);
    
    with (oOrderControl)
    {
        scoreIncrementalForShow = argument[0];
        scoreIncrementalForShow_countdownAmount = clamp(round(argument[0] / 60), 1, 9999);
        scoreIncrementalForShow_downTimer = 0;
        scoreIncrementalForShow_yoffset = 1.5;
        scoreIncrementalForShow_baseScore = argument[1];
        scoreIncrementalForShow_multiplier = argument[2];
        beast_sequenceTimer = 0;
    }
}
