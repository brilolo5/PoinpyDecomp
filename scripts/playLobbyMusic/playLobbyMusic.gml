function playLobbyMusic()
{
    audioStop(global.areaMusic);
    audioStop(global.equipmentMusic);
    audioStop(global.puzzleMenuMusic);
    global.areaMusic = playMusicUI(music_lobby, true, true);
    global.equipmentMusic = playMusicUI(music_equipmentMenu, true, true);
    global.puzzleMenuMusic = playMusicUI(music_puzzleMenu, true, true);
    audioSetVolume(global.areaMusic, 1);
    audioSetVolume(global.equipmentMusic, 0);
    audioSetVolume(global.puzzleMenuMusic, 0);
}
