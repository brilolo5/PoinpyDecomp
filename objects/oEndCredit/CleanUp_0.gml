if (surface_exists(cropSurface))
    surface_free(cropSurface);

if (surface_exists(creditSurface))
    surface_free(creditSurface);

if (!musicFading)
    audioStop(creditMusic);
