function playSoundPlayerSmashPot()
{
    with (oPlayer)
    {
        var _potSmashSound = playSfxWorld(choose(sfx_urn_smash_01, sfx_urn_smash_02, sfx_urn_smash_03, sfx_urn_smash_04, sfx_urn_smash_05, sfx_urn_smash_06));
        audioSetSlowmo(_potSmashSound);
    }
}
