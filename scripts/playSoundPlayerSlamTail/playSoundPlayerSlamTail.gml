function playSoundPlayerSlamTail()
{
    with (oPlayer)
    {
        var _soundSlamTail = playSfxWorld(choose(sfx_player_slam_tail_01, sfx_player_slam_tail_02, sfx_player_slam_tail_03));
        audioSetSlowmo(_soundSlamTail);
    }
}
