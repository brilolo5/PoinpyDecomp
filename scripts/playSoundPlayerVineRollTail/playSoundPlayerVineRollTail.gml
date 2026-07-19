function playSoundPlayerVineRollTail()
{
    with (oPlayer)
    {
        audioSystemStopAsset(sfx_vine_roll_lp);
        var _vineRollTail = playSfxWorld(sfx_vine_roll_tail);
        audioSetSlowmo(_vineRollTail);
    }
}
