function playSoundEnemyDrillFishMoveHead()
{
    with (oEnHorizontalLaunch)
    {
        var _drillFishMoveHeadSound = playSfxWorld(sfx_enemy_drillFish_move_head);
        audioSetSlowmo(_drillFishMoveHeadSound);
        audioSetInViewOnly(_drillFishMoveHeadSound, x, y);
    }
}
