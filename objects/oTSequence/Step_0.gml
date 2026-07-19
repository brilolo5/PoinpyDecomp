if (delay <= 0)
{
    if (init)
    {
        myClosingCircle = instance_create_depth(x, y, 0, oTE_circleCloseOnPlayer);
        myClosingCircle.seqTimerLength = 24;
        myOpeningCircle = -1;
        init = 0;
    }
    
    if (instance_exists(myClosingCircle))
    {
        if (myClosingCircle.seqTimer >= 2)
        {
            room_goto(destination);
            myOpeningCircle = instance_create_depth(x, y, 0, oTE_circleCloseOnPlayer);
            myOpeningCircle.seqReverse = 1;
            myOpeningCircle.seqTimer = 0;
            myOpeningCircle.seqTimerLength = 24;
            instance_destroy(myClosingCircle);
            timeScaleChange(0, 24, 1);
        }
    }
    
    if (myOpeningCircle != -1)
    {
        if (instance_exists(myOpeningCircle))
        {
        }
        else
        {
            timeScaleClear();
            timeScaleChange(1, 1, 1);
            instance_destroy();
        }
    }
}

delay -= doDelta(1);
