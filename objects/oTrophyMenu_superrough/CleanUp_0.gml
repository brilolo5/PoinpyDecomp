global.mainGamePaused = -1;
playerControlLockTimer(10);
instance_activate_all();

if (surface_exists(printScreen))
    surface_free(printScreen);

uiDestroy("debug menu root");
