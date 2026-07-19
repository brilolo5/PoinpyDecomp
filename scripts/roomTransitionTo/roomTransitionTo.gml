function roomTransitionTo()
{
    playSoundTransition();
    
    if (!instance_exists(oRoomTransitionEffect))
    {
        with (instance_create_depth(0, 0, -1000, oRoomTransitionEffect))
        {
            destination = argument[0];
            global.gameReinitializeState = argument[1];
        }
    }
}
