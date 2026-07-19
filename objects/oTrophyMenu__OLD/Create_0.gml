global.mainGamePaused = 1;
printScreen = surface_create_track(surface_get_width(application_surface), surface_get_height(application_surface));
surface_copy(printScreen, 0, 0, application_surface);
instance_deactivate_all(1);
instance_activate_object(oControl);
