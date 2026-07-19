function playSoundJumpOrbReplenish()
{
    with (oPlayer)
    {
        var _jumpOrbReplenishSound = playSfxWorld(sfx_jumpOrb_replenish);
        audioSetSlowmo(_jumpOrbReplenishSound);
    }
}
