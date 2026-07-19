if (oPlayer.bbox_bottom < bbox_bottom)
{
    with (parentTutorialSequence)
        currentSequence = "fade";
    
    instance_create_depth(x, y, depth, tutSeqObject);
    instance_destroy();
}
