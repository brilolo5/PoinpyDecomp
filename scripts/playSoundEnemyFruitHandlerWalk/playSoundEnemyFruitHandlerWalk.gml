function playSoundEnemyFruitHandlerWalk()
{
    with (oEnFruitHandler)
    {
        var _fruitHandlerWalkSound = playSfxWorld(choose(sfx_enemy_fruitHandler_walk_01, sfx_enemy_fruitHandler_walk_02, sfx_enemy_fruitHandler_walk_03, sfx_enemy_fruitHandler_walk_04, sfx_enemy_fruitHandler_walk_05, sfx_enemy_fruitHandler_walk_06));
        audioSetSlowmo(_fruitHandlerWalkSound);
        audioSetInViewOnly(_fruitHandlerWalkSound, x, y);
    }
}
