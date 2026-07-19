function playSoundPlayerLand()
{
    with (oPlayer)
    {
        var _landSound = playSfxWorld(choose(sfx_player_land_01, sfx_player_land_02, sfx_player_land_03, sfx_player_land_04, sfx_player_land_05, sfx_player_land_06));
        audioSetSlowmo(_landSound);
        audioVarLand = 1;
        audioVarLaunched = 0;
        audioVarSpin = 0;
        audioSystemStopAsset(sfx_player_post_wall_flying_lp);
    }
}
