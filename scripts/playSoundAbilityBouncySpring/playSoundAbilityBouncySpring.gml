function playSoundAbilityBouncySpring()
{
    with (oPlayer)
    {
        var _bouncySpringSound = playSfxWorld(sfx_bouncySpring_activate);
        audioSetSlowmo(_bouncySpringSound);
    }
}
