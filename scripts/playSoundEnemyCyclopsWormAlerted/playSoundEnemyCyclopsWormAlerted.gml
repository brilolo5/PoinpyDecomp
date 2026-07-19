function playSoundEnemyCyclopsWormAlerted()
{
    with (oEnHoming)
    {
        var _cyclopsWormAlertedSound = playSfxWorld(sfx_enemy_cyclopsWorm_alerted);
        audioSetSlowmo(_cyclopsWormAlertedSound);
        audioSetInViewOnly(_cyclopsWormAlertedSound, x, y);
    }
}
