function playSoundEnemyFlatHopperLand()
{
    with (oEnJumpingSpider)
    {
        var _flatHopperLandSound = playSfxWorld(sfx_enemy_flatHopper_land);
        audioSetSlowmo(_flatHopperLandSound);
        audioSetInViewOnly(_flatHopperLandSound, x, y);
    }
}
