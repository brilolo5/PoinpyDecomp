function playSoundAbilityFightingSpirit()
{
    with (oPlayer)
    {
        var _fightingSpiritSound = playSfxWorld(sfx_fightingSpirit_activate);
        audioSetSlowmo(_fightingSpiritSound);
    }
}
