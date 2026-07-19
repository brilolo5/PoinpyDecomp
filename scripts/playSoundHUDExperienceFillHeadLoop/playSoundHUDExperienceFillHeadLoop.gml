function playSoundHUDExperienceFillHeadLoop()
{
    with (oPlayer)
    {
        var _experienceFillHeadSound = playSfxUI(hud_experience_line_fill_head);
        var _experienceFillLoopSound = playSfxUI(hud_experience_line_fill_lp);
    }
}
