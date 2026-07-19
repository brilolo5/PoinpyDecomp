function playSoundAbilityGripRocks()
{
    with (oPlayer)
    {
        var _gripRocksSound = playSfxWorld(sfx_gripRocks_activate);
        audioSetSlowmo(_gripRocksSound);
    }
}
