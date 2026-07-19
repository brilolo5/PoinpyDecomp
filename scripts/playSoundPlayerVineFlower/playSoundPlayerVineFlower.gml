function playSoundPlayerVineFlower()
{
    with (oPlayer)
    {
        var _vineRollFlowerSound = playSfxWorld(sfx_vine_roll_flower_bloom);
        audioSetSlowmo(_vineRollFlowerSound);
    }
}
