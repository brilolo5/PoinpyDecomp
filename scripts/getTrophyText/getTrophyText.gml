function getTrophyText(arg0)
{
    var _trophyText = array_create(UnknownEnum.Value_15, "null");
    _trophyText[UnknownEnum.Value_0] = loc("trophy clear by 10");
    _trophyText[UnknownEnum.Value_1] = loc("trophy clear by 8");
    _trophyText[UnknownEnum.Value_2] = loc("trophy clear by 6");
    _trophyText[UnknownEnum.Value_3] = loc("trophy clear by 4");
    _trophyText[UnknownEnum.Value_4] = loc("trophy endless score 10", global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_4]);
    _trophyText[UnknownEnum.Value_5] = loc("trophy endless score 8", global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_5]);
    _trophyText[UnknownEnum.Value_6] = loc("trophy endless score 6", global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_6]);
    _trophyText[UnknownEnum.Value_7] = loc("trophy endless score 4", global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_7]);
    _trophyText[UnknownEnum.Value_8] = loc("trophy endless score 2", global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_8]);
    _trophyText[UnknownEnum.Value_9] = loc("trophy endless average", global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_9], 10);
    _trophyText[UnknownEnum.Value_10] = loc("trophy endless average", global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_10], 8);
    _trophyText[UnknownEnum.Value_11] = loc("trophy endless average", global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_11], 6);
    _trophyText[UnknownEnum.Value_12] = loc("trophy endless average", global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_12], 4);
    _trophyText[UnknownEnum.Value_13] = loc("trophy endless average", global.achievementTrophyEndlessScoreThreshold[UnknownEnum.Value_13], 2);
    _trophyText[UnknownEnum.Value_14] = loc("trophy puzzle all clear");
    return _trophyText[arg0];
}
