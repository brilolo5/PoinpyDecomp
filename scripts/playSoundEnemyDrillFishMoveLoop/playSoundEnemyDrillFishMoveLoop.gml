function playSoundEnemyDrillFishMoveLoop()
{
    with (oEnHorizontalLaunch)
    {
        var _drillFishMoveLoopSound = playSfxWorld(sfx_enemy_drillFish_move_lp, true);
        audioSetSlowmo(_drillFishMoveLoopSound);
        audioSetInViewOnly(_drillFishMoveLoopSound, x, y);
    }
}
