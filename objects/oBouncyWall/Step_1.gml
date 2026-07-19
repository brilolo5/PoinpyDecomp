if (!set)
{
    while (true)
    {
        cannibalizeTarget = instance_place(x, y + 1, oMovingWall);
        
        if (cannibalizeTarget)
        {
            expandSize = cannibalizeTarget.wallSizey;
            wallSizey += expandSize;
            image_yscale += expandSize;
            y += (expandSize * 8);
            
            with (cannibalizeTarget)
                instance_destroy();
        }
        else
        {
            break;
        }
    }
}
