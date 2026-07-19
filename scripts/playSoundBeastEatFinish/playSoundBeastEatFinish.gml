function playSoundBeastEatFinish()
{
    with (oPlayer)
    {
        audioSystemStopAsset(sfx_beast_eat_lp);
        var _beastSoundEatFinish = playSfxWorld(sfx_beast_eat_tail);
    }
}
