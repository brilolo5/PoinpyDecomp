function playSoundPlayerWallBounce()
{
    with (oPlayer)
    {
        var _wallBounceSound = playSfxWorld(choose(sfx_player_wall_bounce_01, sfx_player_wall_bounce_02, sfx_player_wall_bounce_03, sfx_player_wall_bounce_04, sfx_player_wall_bounce_05, sfx_player_wall_bounce_06));
        audioSetSlowmo(_wallBounceSound);
    }
}
