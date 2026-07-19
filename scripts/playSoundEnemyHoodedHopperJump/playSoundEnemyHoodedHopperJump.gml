function playSoundEnemyHoodedHopperJump()
{
    with (oEnCannonFodder)
    {
        var _hoodedHopperJump = playSfxWorld(sfx_enemy_hoodedHopper_jump);
        audioSetSlowmo(_hoodedHopperJump);
        audioSetInViewOnly(_hoodedHopperJump, x, y);
    }
}
