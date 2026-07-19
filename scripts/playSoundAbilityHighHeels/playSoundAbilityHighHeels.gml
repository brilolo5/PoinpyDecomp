function playSoundAbilityHighHeels()
{
    with (oPlayer)
    {
        var _highHeelsSound = playSfxWorld(sfx_highHeels_activate);
        audioSetSlowmo(_highHeelsSound);
    }
}
