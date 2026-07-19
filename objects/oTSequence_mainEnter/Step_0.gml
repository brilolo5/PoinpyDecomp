if (delay <= 0)
{
    if (init)
    {
        myClosingCircle = instance_create_depth(x, y, 0, oTE_circleCloseOnPlayer);
        myClosingCircle.seqTimerLength = 18;
        myOpeningCircle = -1;
        init = 0;
    }
    
    if (instance_exists(myClosingCircle))
    {
        if (myClosingCircle.seqTimer >= 3)
        {
            room_goto(rmMainGame);
            TextureManagerGoto(rmMainGame);
            global.gameReinitializeState = "main game normal";
            myOpeningCircle = instance_create_depth(x, y, 0, oTE_circleCloseOnPlayer);
            myOpeningCircle.seqReverse = 1;
            myOpeningCircle.seqTimer = -0.5;
            myOpeningCircle.seqTimerLength = 15;
            instance_destroy(myClosingCircle);
        }
    }
    
    if (myOpeningCircle != -1)
    {
        if (instance_exists(myOpeningCircle))
        {
        }
        else
        {
            instance_destroy();
        }
    }
}

delay -= doDelta(1);
