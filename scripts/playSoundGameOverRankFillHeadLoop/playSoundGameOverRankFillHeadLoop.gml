function playSoundGameOverRankFillHeadLoop()
{
    with (oResultsScreen)
    {
        var _RankFillHeadSound = playSfxUI(hud_game_over_rank_fill_head);
        var _RankFillLoopSound1 = playSfxUI(hud_game_over_rank_fill_lp_01, true);
        var _RankFillLoopSound2 = playSfxUI(hud_game_over_rank_fill_lp_02, true);
    }
}
