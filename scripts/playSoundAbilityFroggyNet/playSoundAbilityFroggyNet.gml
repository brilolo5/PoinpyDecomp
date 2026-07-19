function playSoundAbilityFroggyNet()
{
    with (oPlayer)
    {
        var _froggyNetSound = playSfxWorld(sfx_froggyNet_activate);
        audioSetSlowmo(_froggyNetSound);
    }
}
