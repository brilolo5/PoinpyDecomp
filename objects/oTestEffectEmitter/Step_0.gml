timer -= global.timeScale;

if (timer <= 0)
{
    timer = timerMax;
    
    repeat (effectAmount)
        instance_create_depth(x, y, depth, effect);
}
