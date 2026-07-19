function playSoundEnemyBungeeBoyBounce()
{
    with (oEnAirBounce)
    {
        var _bungeeBoyBounceSound = playSfxWorld(sfx_enemy_bungeeBoy_bounceUp);
        audioSetSlowmo(_bungeeBoyBounceSound);
        audioSetInViewOnly(_bungeeBoyBounceSound, x, y);
    }
}
