function playSoundJumpOrbAcquired()
{
    var _getJumpOrb = playSfxUI(sfx_jumpOrb_pickup);
    var _rewardSoundLoop = playSfxUI(sfx_rankup_reward_lp, true);
    audioSetVolume(_rewardSoundLoop, 0.6);
}
