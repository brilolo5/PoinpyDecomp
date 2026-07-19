function playSoundHUDExperienceMoveHeadLoop()
{
    with (oPlayer)
    {
        var _experienceMoveHeadSound = playSfxUI(hud_experience_line_move_head);
        var _experienceMoveLoopSound = playSfxUI(hud_experience_line_move_lp);
    }
}
