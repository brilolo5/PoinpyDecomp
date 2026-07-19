function playSoundHUDExperienceFillTail()
{
    with (oPlayer)
    {
        var _experienceFillTailSound = playSfxUI(hud_experience_line_fill_tail);
        audioSystemStopAsset(hud_experience_line_fill_lp);
    }
}
