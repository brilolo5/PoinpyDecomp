function pauseDrawSurface()
{
    if (global.printScreenSprite != undefined && sprite_exists(global.printScreenSprite))
        draw_sprite_stretched(global.printScreenSprite, 0, global.windowLeft, global.windowTop, global.applicationSurfaceDrawWidth, global.applicationSurfaceDrawHeight);
    else if (global.ingamePause && global.printScreen != undefined && surface_exists(global.printScreen))
        draw_surface_stretched(global.printScreen, global.windowLeft, global.windowTop, global.applicationSurfaceDrawWidth, global.applicationSurfaceDrawHeight);
}
