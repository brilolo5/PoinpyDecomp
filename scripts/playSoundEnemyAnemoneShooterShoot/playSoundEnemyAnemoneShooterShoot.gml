function playSoundEnemyAnemoneShooterShoot()
{
    with (oEnHorizontalShooter)
    {
        var _anemoneShooterShootSound = playSfxWorld(choose(sfx_enemy_anemoneShooter_fire_01, sfx_enemy_anemoneShooter_fire_02, sfx_enemy_anemoneShooter_fire_03, sfx_enemy_anemoneShooter_fire_04, sfx_enemy_anemoneShooter_fire_05, sfx_enemy_anemoneShooter_fire_06));
        audioSetSlowmo(_anemoneShooterShootSound);
        audioSetInViewOnly(_anemoneShooterShootSound, x, y);
    }
}
