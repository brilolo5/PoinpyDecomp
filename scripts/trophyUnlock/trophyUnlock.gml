function trophyUnlock(arg0)
{
    if (global.achievementTrophyGotList[| arg0] != 1)
    {
        global.achievementTrophyGotList[| arg0] = 1;
        
        if (global.endingReached >= UnknownEnum.Value_2)
        {
            with (instance_create_depth(0, 0, 0, oMedalGotNotification))
                medalIndex = arg0;
        }
        
        saveGame();
        return true;
    }
    else
    {
        return false;
    }
}

function debugTrophyUnlockAll()
{
    global.achievementTrophyGotList[| UnknownEnum.Value_0] = 1;
    global.achievementTrophyGotList[| UnknownEnum.Value_1] = 1;
    global.achievementTrophyGotList[| UnknownEnum.Value_2] = 1;
    global.achievementTrophyGotList[| UnknownEnum.Value_3] = 1;
    global.achievementTrophyGotList[| UnknownEnum.Value_4] = 1;
    global.achievementTrophyGotList[| UnknownEnum.Value_5] = 1;
    global.achievementTrophyGotList[| UnknownEnum.Value_6] = 1;
    global.achievementTrophyGotList[| UnknownEnum.Value_7] = 1;
    global.achievementTrophyGotList[| UnknownEnum.Value_8] = 1;
    global.achievementTrophyGotList[| UnknownEnum.Value_9] = 1;
    global.achievementTrophyGotList[| UnknownEnum.Value_10] = 1;
    global.achievementTrophyGotList[| UnknownEnum.Value_11] = 1;
    global.achievementTrophyGotList[| UnknownEnum.Value_12] = 1;
    global.achievementTrophyGotList[| UnknownEnum.Value_13] = 1;
    global.achievementTrophyGotList[| UnknownEnum.Value_14] = 1;
}
