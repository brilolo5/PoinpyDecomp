function playSoundHUDExperienceMoveTail()
{
    with (oPlayer)
    {
        var _experienceMoveTailSound = playSfxUI(hud_experience_line_move_tail);
        audioSystemStopAsset(hud_experience_line_move_lp);
    }
}
