function playSoundEndingTransitionRumble(arg0)
{
    with (oEndingSequence)
    {
        var _transitionRumbleSound = playSfxWorld(sfx_oceanWaves_outro);
        audioFadeOut(arg0, 0.005);
    }
}
