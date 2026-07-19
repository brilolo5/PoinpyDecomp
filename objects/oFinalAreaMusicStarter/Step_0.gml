x = getViewx(global.cam);
y = getViewy(global.cam);

if (introStarted)
{
    var _areaMusic = music_outerSpace;
    var _introMusic = music_outerSpaceIntro;
    
    if (!audio_is_playing(_introMusic))
    {
        createAreaTextEffect();
        audioStop(global.areaMusic);
        global.areaMusic = playMusicUI(_areaMusic, true, true);
        instance_destroy();
    }
}
