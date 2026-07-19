audio_resume_sound(audioGetAsset(global.areaMusic));
var _rewardSoundLoopID = audioGetByAsset(sfx_rankup_reward_lp);
audioFadeOut(_rewardSoundLoopID, 1/30);
uiDestroy("results root");
