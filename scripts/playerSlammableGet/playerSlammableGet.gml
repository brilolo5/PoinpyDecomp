function playerSlammableGet(arg0)
{
    var _slamTarget = arg0;
    
    if (slam)
        ysp = -4;
    
    screenShake(3, 4);
    global.jumpTimes += 1;
    gainComboElement(_slamTarget.sprite_index, 1, 0);
    
    with (_slamTarget)
        instance_destroy();
    
    slam = 0;
}
