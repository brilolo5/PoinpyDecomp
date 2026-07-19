if (place_meeting(x, y, oPlayer))
{
    with (oPlayer)
    {
        playerStateChange("spin jump");
        xsp = 0;
        ysp = -1;
        x = other.x;
        y = other.y;
    }
    
    global.jumpTimesMax = 2;
    global.jumpTimes = 0;
    instance_destroy();
    
    if (room == rmTutorialMovement2)
    {
        instance_create_depth(x, y, 0, oTutSeq_JumpOrb);
        instance_create_depth(x, y, 0, oTut_JumpOrbGetNotification);
    }
}
