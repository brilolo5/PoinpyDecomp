function playSoundPlayerWallJump()
{
    with (oPlayer)
    {
        var _wallJumpSound = playSfxWorld(choose(sfx_player_wall_jump_01, sfx_player_wall_jump_02, sfx_player_wall_jump_03, sfx_player_wall_jump_04, sfx_player_wall_jump_05, sfx_player_wall_jump_06));
        audioSetSlowmo(_wallJumpSound);
    }
}
