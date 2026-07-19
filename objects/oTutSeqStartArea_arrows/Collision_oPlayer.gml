if (oPlayer.bbox_bottom < bbox_bottom)
{
    with (oTutorialWalljumpArrows)
        stateChange("pause before appear");
    
    instance_destroy();
}
