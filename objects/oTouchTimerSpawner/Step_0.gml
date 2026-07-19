if (cracked)
{
    crackTimer += global.timeScale;
    
    if (crackTimer >= crackTimerThreshold)
    {
        instance_create_depth(x, y, 0, oEnHoming);
        instance_destroy();
    }
}
