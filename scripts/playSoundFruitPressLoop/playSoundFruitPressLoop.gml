function playSoundFruitPressLoop()
{
    with (oPlayer)
    {
        var _fruitPressLoopSound = playSfxWorld(sfx_fruit_press_lp);
        audioFadeIn(_fruitPressLoopSound, 0.7, 0.5);
    }
}
