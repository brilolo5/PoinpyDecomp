function playSoundMagma()
{
    with (oMagma)
    {
        var _magmaSound = playSfxWorld(sfx_magmaBurstSequence_magma_lp_V3, true);
        audioFadeIn(_magmaSound, 1, 0.05);
        return _magmaSound;
    }
}
