function playSoundFruitPress(arg0)
{
    with (oJuiceHomingParticleEmitter)
    {
        var _fruitPressSound = playSfxWorld(sfx_player_fruit_press_05);
        audioSetPitch(_fruitPressSound, arg0 / 10);
    }
}
