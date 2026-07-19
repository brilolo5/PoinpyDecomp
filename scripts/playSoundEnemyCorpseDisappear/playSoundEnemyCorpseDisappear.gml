function playSoundEnemyCorpseDisappear()
{
    with (oPlayer)
    {
        var _corpseDisappearSound = playSfxUI(sfx_enemy_disappear);
        audioSetInViewOnly(_corpseDisappearSound, x, y);
    }
}
