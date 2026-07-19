function playerControlLockTimer(arg0)
{
    global.playerControlLock = 1;
    global.playerControlLockReleaseTimer = arg0;
}

function playerControlLock()
{
    global.playerControlLock = 1;
}

function playerControlLockRelease()
{
    global.playerControlLock = 0;
}

function getPlayerControlLock()
{
    return global.playerControlLock;
}
