function debugGameRestart()
{
    instance_activate_all();
    instance_destroy(-3);
    audioSystemStopAll();
    trace("Restart: Re-initializing");
    initializeGame();
    trace("Restart: Loading savedata");
    instance_create_depth(0, 0, -10000, oNetflixControl);
    loadGame(true);
    initCheckAndSetLanguage();
    toggleEquippedAbility();
    juicerRankUpdate();
    trace("Restart: Resizing window");
    initializeWindow(true);
    trace("Restart: Creating controllers");
    instance_create_depth(0, 0, -10000, oControl);
    instance_create_depth(0, 0, -10000, obj_gmlive);
    instance_create_depth(0, 0, -10000, oAudioController);
    instance_create_depth(0, 0, -10000, oDraw);
    trace("Restart: Choosing room");
    initializeGotoNextRoom();
}
