global.playerControlLock = 1;

if (!atDestination && endTimer >= 0.5)
{
    atDestination = 1;
    TextureManagerGoto("main menu");
    room_goto(rmPlayableMainMenu);
}

if (endTimer >= 1)
{
    global.playerControlLockReleaseTimer = 30;
    instance_destroy();
}
