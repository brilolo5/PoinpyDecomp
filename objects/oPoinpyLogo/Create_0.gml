random_set_seed(1234);
myAlarmPlayLeadIn = new makeAlarm(0, function()
{
    sparkle = 150;
    lobbyMusicLeadIn = playMusicUI(music_titleLogoAppearLeadIn, 0, 1);
    myAlarm1.setTimer(255.6);
    myAlarm0.setTimer(6);
});
myAlarm0 = new makeAlarm(0, function()
{
    logoVisible = 1;
    
    repeat (8)
    {
        var _sparkleRandx = irandom_range(bbox_left, bbox_right);
        var _sparkleRandy = irandom_range(bbox_top, bbox_bottom);
        generateEffect(_sparkleRandx, _sparkleRandy, "logo sparkle", 0);
    }
    
    lobbyMusicLeadIn = playMusicUI(music_titleLogoAppearLeadIn, 0, 1);
});
myAlarm1 = new makeAlarm(0, function()
{
    playLobbyMusic();
    global.tutorialOver = max(1, global.tutorialOver);
    playerControlLockRelease();
    saveGame(true);
});
sprite_index = getLogoSprite();
logoScale = getLogoScale();
allMedalUnlocked = 1;

for (var i = 0; i < UnknownEnum.Value_15; i += 1)
{
    if (global.achievementTrophyGotList[| i] == 0)
    {
        allMedalUnlocked = 0;
        break;
    }
}

lobbyMusicLeadIn = -1;
logoVisible = 1;
sparkle = 0;

if (!global.tutorialOver)
{
    logoVisible = 0;
    logoBoingTime = 0;
}
else
{
    logoBoingTime = 1;
}

defaultScale = image_xscale;
