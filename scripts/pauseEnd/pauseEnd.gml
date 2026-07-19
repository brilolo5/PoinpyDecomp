function pauseEnd()
{
    if (global.ingamePause)
    {
        global.ingamePause = false;
        global.mainGamePaused = -1;
        instance_activate_all();
        audioSystemResumeAll();
        
        if (global.printScreen != undefined && surface_exists(global.printScreen))
        {
            surface_free(global.printScreen);
            global.printScreen = undefined;
        }
        
        if (global.printScreenSprite != undefined && sprite_exists(global.printScreenSprite))
        {
            sprite_delete(global.printScreenSprite);
            global.printScreenSprite = undefined;
        }
    }
}
