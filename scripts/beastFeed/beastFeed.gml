function beastFeed()
{
    var _food = argument[0];
    global.bossLife = approach(global.bossLife, 0, _food);
    
    if (global.bossLife <= 0)
        playerStateChange("beast full");
}
