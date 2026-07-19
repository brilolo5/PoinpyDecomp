function playSoundPlayerFalling()
{
    with (oPlayer)
    {
        var _playerFallingSound = playSfxWorld(sfx_player_post_wall_flying_lp, true, true);
        audioSetSlowmo(_playerFallingSound);
    }
}
