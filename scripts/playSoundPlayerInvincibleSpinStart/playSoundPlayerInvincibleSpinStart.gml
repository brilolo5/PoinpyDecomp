function playSoundPlayerInvincibleSpinStart()
{
    with (oPlayerInvincibleTrail)
    {
        var _invincibleSound = playSfxWorld(sfx_player_invincible_spin_lp, true, true);
        audioSetSlowmo(_invincibleSound);
        return _invincibleSound;
    }
}
