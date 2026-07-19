global.mainGamePaused = -1;
instance_activate_all();

if (surface_exists(printScreen))
    surface_free(printScreen);
