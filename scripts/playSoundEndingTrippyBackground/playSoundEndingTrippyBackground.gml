function playSoundEndingTrippyBackground()
{
    with (oEndingSequence)
    {
        var _backgroundAuraSound = playSfxWorld(sfx_oceanWaves_lp, true);
        audioFadeIn(_backgroundAuraSound, 1, 0.005);
        return _backgroundAuraSound;
    }
}
