areaIndex = global.currentLevelChunkSet;
nextMusic = getMusicForArea(areaIndex);
active = 0;
myAlarm0 = new makeAlarm(0, function()
{
    var _nextMusicAsset = nextMusic;
    
    if (audioGetAsset(global.areaMusic) != _nextMusicAsset)
    {
        audioStop(global.areaMusic);
        global.areaMusic = playMusicUI(_nextMusicAsset, true, true);
    }
    
    audioSetVolume(global.areaMusic, 1);
    instance_destroy();
});
myAlarm1 = new makeAlarm(0, function()
{
    if (global.finalStretchSequence < UnknownEnum.Value_2)
        createAreaTextEffect(areaIndex);
});
