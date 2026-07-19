function playSoundSpinEntrance()
{
    with (oPlayer)
    {
        var _introSpinSound = playSfxWorld(sfx_player_spin_med, true, true);
        audioFadeIn(_introSpinSound, 0.5, 0.01);
    }
}
