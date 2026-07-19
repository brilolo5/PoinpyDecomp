function playSoundEnemyHoodedHopperAlert()
{
    with (oEnCannonFodder)
    {
        var _hoodedHopperAlert = playSfxWorld(sfx_enemy_hoodedHopper_alerted);
        audioSetSlowmo(_hoodedHopperAlert);
        audioSetInViewOnly(_hoodedHopperAlert, x, y);
    }
}
