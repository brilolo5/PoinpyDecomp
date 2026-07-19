y = lerp(y, ystart + textGoal_y, 0.1);

if (round(y) == round(ystart + textGoal_y))
{
    if (destroyTimer && !--destroyTimer)
        instance_destroy();
}
