if (oPlayer.bbox_bottom < bbox_bottom)
{
    with (oBeastMainGame)
        switchRoomEntered = 1;
    
    instance_destroy();
}
