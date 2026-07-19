function playerCannonLaunch(arg0)
{
    var _target = arg0;
    sleep(8);
    addHitStop(4);
    screenShake(4, 4);
    playerStateChange("invincible spin jump");
    yscale = 0.6;
    xscale = 1.4;
    imgAngle = 0;
    var _dir = _target.cannonAngle + 90;
    var _launchSpeed = 7;
    
    if (global.wideGame)
        _launchSpeed = 8;
    
    xsp = lengthdir_x(_launchSpeed, _dir);
    ysp = lengthdir_y(_launchSpeed, _dir);
    global.playerControlLock = 0;
    _target.cannonUseCount += 1;
}
