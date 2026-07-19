function playSoundPlayerJump()
{
    with (oPlayer)
    {
        playSfxWorld(choose(sfx_player_jump_01, sfx_player_jump_02, sfx_player_jump_03, sfx_player_jump_04, sfx_player_jump_05, sfx_player_jump_06));
        audioSystemStopAsset(sfx_player_slomo_lp);
        audioSystemStopAsset(sfx_player_spin_med);
        audioSystemStopAsset(sfx_cannon_rotate_lp);
        audioVarLaunched = 1;
        audioVarPlayerFalling = 0;
    }
}
