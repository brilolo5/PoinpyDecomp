if (stomped)
{
    with (instance_create_depth(x, y, depth, effectStatic))
    {
        sprite_index = sFlashCircle24;
        imageSpeed = 0.5;
    }
    
    generateEffect(x, y, "pot full animation", 0);
}
