if (instance_exists(myClosingCircle))
{
    if (myClosingCircle.seqTimer >= 1.2)
    {
        var _room = global.puzzleRoomList[areaIndex][levelIndex];
        TextureManagerGoto("gameplay");
        room_goto(_room);
        global.gameReinitializeState = "puzzle";
        myOpeningCircle = instance_create_depth(x, y, 0, oTE_circleCloseOnPlayer);
        myOpeningCircle.seqReverse = 1;
        myOpeningCircle.seqTimer = -0.5;
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
