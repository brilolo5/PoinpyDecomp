function playSoundPlayerBonkHead()
{
    with (oPlayer)
    {
        playSfxWorld(choose(sfx_player_platform_bonk_1, sfx_player_platform_bonk_2, sfx_player_platform_bonk_3, sfx_player_platform_bonk_4));
        audioSystemStopAsset(sfx_player_slomo_lp);
        audioSystemStopAsset(sfx_player_spin_med);
        audioSystemStopAsset(sfx_cannon_rotate_lp);
    }
}
