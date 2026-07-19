global.printScreen = undefined;
global.printScreenSprite = undefined;

function pauseStart()
{
    if (!global.ingamePause)
    {
        global.ingamePause = true;
        global.mainGamePaused = 1;
        global.printScreen = surface_create_track(surface_get_width(application_surface), surface_get_height(application_surface));
        surface_copy(global.printScreen, 0, 0, application_surface);
        
        if (!(os_type == os_ios || os_type == os_android) || os_type == os_android)
        {
            global.printScreenSprite = sprite_create_from_surface(global.printScreen, 0, 0, surface_get_width(global.printScreen), surface_get_height(global.printScreen), false, false, 0, 0);
            surface_free(global.printScreen);
            global.printScreen = undefined;
        }
        
        instance_deactivate_all(true);
        instance_activate_object(oControl);
        instance_activate_object(oDraw);
        audioSystemPauseWorld();
    }
}
