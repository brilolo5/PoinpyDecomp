function playSoundEnemyHoodedHopperLand()
{
    with (oEnCannonFodder)
    {
        var _hoodedHopperLand = playSfxWorld(sfx_enemy_hoodedHopper_land);
        audioSetSlowmo(_hoodedHopperLand);
        audioSetInViewOnly(_hoodedHopperLand, x, y);
    }
}
