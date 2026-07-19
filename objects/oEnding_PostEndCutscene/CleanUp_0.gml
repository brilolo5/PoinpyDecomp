if (audioAssetIsPlaying(sfx_ending_full))
    audio_stop_sound(sfx_ending_full);

if (surface_exists(dbCropSurface))
    surface_free(dbCropSurface);

if (surface_exists(dbInsideSurface))
    surface_free(dbInsideSurface);
