function playSoundEnemySpikeBoxFlip()
{
    with (oEnFlippyPatrol)
    {
        var _spikeBoxFlipSound = playSfxWorld(choose(sfx_enemy_spikeBox_flip_01, sfx_enemy_spikeBox_flip_02, sfx_enemy_spikeBox_flip_03, sfx_enemy_spikeBox_flip_04, sfx_enemy_spikeBox_flip_05));
        audioSetSlowmo(_spikeBoxFlipSound);
        audioSetInViewOnly(_spikeBoxFlipSound, x, y);
    }
}
