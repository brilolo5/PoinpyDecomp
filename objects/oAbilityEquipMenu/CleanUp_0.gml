saveGame();
pauseEnd();
uiDestroy("AE root");
audioSetVolumeTarget(global.areaMusic, 1, 0.16666666666666666);
audioSetVolumeTarget(global.equipmentMusic, 0, 0.16666666666666666);
toggleEquippedAbility();
global.mainGamePaused = -1;
global.playerControlLockReleaseTimer = 10;
instance_activate_all();

with (oPlayer)
{
    currentState = "free";
    global.jumpTimes = 0;
    ysp = 0;
}
