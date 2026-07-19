function playSoundGameOverRankFillTail()
{
    with (oResultsScreen)
    {
        var _rankFillTailSound = playSfxUI(hud_game_over_rank_fill_tail);
        audioSystemStopAsset(hud_game_over_rank_fill_lp_01);
        audioSystemStopAsset(hud_game_over_rank_fill_lp_02);
    }
}
