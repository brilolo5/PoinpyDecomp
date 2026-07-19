function playSoundAbilityMummyPlushie()
{
    with (oPlayer)
    {
        var _mummyPlushieSound = playSfxWorld(sfx_mummyPlushie_activate);
        audioSetSlowmo(_mummyPlushieSound);
    }
}
