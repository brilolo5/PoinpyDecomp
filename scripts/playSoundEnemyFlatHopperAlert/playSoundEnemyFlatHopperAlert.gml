function playSoundEnemyFlatHopperAlert()
{
    with (oEnJumpingSpider)
    {
        var _flatHopperAlert = playSfxWorld(sfx_enemy_flatHopper_alerted);
        audioSetSlowmo(_flatHopperAlert);
        audioSetInViewOnly(_flatHopperAlert, x, y);
    }
}
