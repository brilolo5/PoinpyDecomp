function playSoundEnemyFlatHopperJump()
{
    with (oEnJumpingSpider)
    {
        var _flatHopperJumpSound = playSfxWorld(sfx_enemy_flatHopper_jump);
        audioSetSlowmo(_flatHopperJumpSound);
        audioSetInViewOnly(_flatHopperJumpSound, x, y);
    }
}
