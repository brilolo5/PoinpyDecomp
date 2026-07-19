if (place_meeting(x, y, oPlayer))
{
    var _nextMusicAsset = nextMusic;
    
    if (audioGetAsset(global.areaMusic) != _nextMusicAsset)
    {
        audioStop(global.areaMusic);
        global.areaMusic = playMusicWorld(_nextMusicAsset, true, true);
        var _length = audio_sound_length(audioGetAsset(global.areaMusic));
        audio_sound_set_track_position(global.areaMusic, _length / 2);
    }
    
    audioSetVolume(global.areaMusic, 0);
}
