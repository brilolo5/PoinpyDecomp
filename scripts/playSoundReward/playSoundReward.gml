function playSoundReward()
{
    with (oResultsScreen)
    {
        var _rewardSoundHead = playSfxUI(sfx_rankup_reward_head);
        var _rewardSoundLoop = playSfxUI(sfx_rankup_reward_lp, true);
    }
}
