function playSoundAbilityJumpyBoy()
{
    with (oPlayer)
    {
        var _jumpyBoySound = playSfxWorld(sfx_jumpyBoy_activate);
        audioSetSlowmo(_jumpyBoySound);
    }
}
