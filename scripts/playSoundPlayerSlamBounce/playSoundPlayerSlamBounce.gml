function playSoundPlayerSlamBounce()
{
    with (oPlayer)
    {
        var _slamSound = playSfxWorld(choose(sfx_player_slam_bounce_01, sfx_player_slam_bounce_02, sfx_player_slam_bounce_03, sfx_player_slam_bounce_04, sfx_player_slam_bounce_05, sfx_player_slam_bounce_06));
        audioSetSlowmo(_slamSound);
    }
}
