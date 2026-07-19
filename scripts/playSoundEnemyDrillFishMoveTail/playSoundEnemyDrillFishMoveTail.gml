function playSoundEnemyDrillFishMoveTail()
{
    with (oEnHorizontalLaunch)
    {
        var _drillFishMoveTailSound = playSfxWorld(sfx_enemy_drillFish_move_tail);
        audioSetSlowmo(_drillFishMoveTailSound);
        audioSetInViewOnly(_drillFishMoveTailSound, x, y);
    }
}
