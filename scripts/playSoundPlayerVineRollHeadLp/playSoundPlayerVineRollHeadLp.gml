function playSoundPlayerVineRollHeadLp()
{
    with (oPlayer)
    {
        var _vineRollHead = playSfxWorld(sfx_vine_roll_head);
        audioSetSlowmo(_vineRollHead);
    }
}
