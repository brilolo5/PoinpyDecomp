function initializeGotoNextRoom()
{
    if (!global.tutorialOver)
    {
        TextureManagerGoto("tutorial");
        room_goto(rmTutorialMovement2);
    }
    else
    {
        TextureManagerGoto(room_next(rmInit));
        room_goto(room_next(rmInit));
        instance_create_depth(0, 0, 0, oTE_thoughtBubbleOpen);
    }
}
