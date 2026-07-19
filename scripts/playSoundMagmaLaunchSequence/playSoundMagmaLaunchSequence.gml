function playSoundMagmaLaunchSequence()
{
    with (oShootIntoSpace)
    {
        var _magmaLaunchRumbleSound = playSfxWorld(sfx_magmaBurstSequence_rumble_lp, true);
        audioFadeIn(_magmaLaunchRumbleSound, 1, 0.05);
        return _magmaLaunchRumbleSound;
    }
}
