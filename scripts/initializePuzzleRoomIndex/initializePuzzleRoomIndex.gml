function initializePuzzleRoomIndex()
{
    for (var i = 0; i < global.puzzleLevelCount; i += 1)
    {
        global.puzzleRoomList[UnknownEnum.Value_1][i] = rmPuzzle_beginner00;
        global.puzzleRoomList[UnknownEnum.Value_2][i] = rmPuzzle_beginner00;
        global.puzzleRoomList[UnknownEnum.Value_3][i] = rmPuzzle_beginner00;
        global.puzzleRoomList[UnknownEnum.Value_4][i] = rmPuzzle_beginner00;
        global.puzzleRoomList[UnknownEnum.Value_5][i] = rmPuzzle_beginner00;
        global.puzzleRoomList[UnknownEnum.Value_6][i] = rmPuzzle_beginner00;
    }
    
    global.puzzleRoomList[UnknownEnum.Value_1][0] = rmPuzzle_beginner00;
    global.puzzleRoomList[UnknownEnum.Value_1][1] = rmPuzzle_beginner02;
    global.puzzleRoomList[UnknownEnum.Value_1][2] = rmPuzzle_beginner01;
    global.puzzleRoomList[UnknownEnum.Value_1][3] = rmPuzzle_beginner03;
    global.puzzleRoomList[UnknownEnum.Value_1][4] = rmPuzzle_beginner05;
    global.puzzleRoomList[UnknownEnum.Value_2][0] = rmPuzzle_vine03;
    global.puzzleRoomList[UnknownEnum.Value_2][1] = rmPuzzle_vine01;
    global.puzzleRoomList[UnknownEnum.Value_2][2] = rmPuzzle_vine02;
    global.puzzleRoomList[UnknownEnum.Value_2][3] = rmPuzzle_vine00;
    global.puzzleRoomList[UnknownEnum.Value_2][4] = rmPuzzle_vine04;
    global.puzzleRoomList[UnknownEnum.Value_3][0] = rmPuzzle_bubble00;
    global.puzzleRoomList[UnknownEnum.Value_3][1] = rmPuzzle_bubble01;
    global.puzzleRoomList[UnknownEnum.Value_3][2] = rmPuzzle_bubble05;
    global.puzzleRoomList[UnknownEnum.Value_3][3] = rmPuzzle_bubble02;
    global.puzzleRoomList[UnknownEnum.Value_3][4] = rmPuzzle_bubble04;
    global.puzzleRoomList[UnknownEnum.Value_4][0] = rmPuzzle_jumpPad02;
    global.puzzleRoomList[UnknownEnum.Value_4][1] = rmPuzzle_jumpPad00;
    global.puzzleRoomList[UnknownEnum.Value_4][2] = rmPuzzle_jumpPad04;
    global.puzzleRoomList[UnknownEnum.Value_4][3] = rmPuzzle_jumpPad06;
    global.puzzleRoomList[UnknownEnum.Value_4][4] = rmPuzzle_jumpPad05;
    global.puzzleRoomList[UnknownEnum.Value_5][0] = rmPuzzle_cannon00;
    global.puzzleRoomList[UnknownEnum.Value_5][1] = rmPuzzle_cannon01;
    global.puzzleRoomList[UnknownEnum.Value_5][2] = rmPuzzle_cannon02;
    global.puzzleRoomList[UnknownEnum.Value_5][3] = rmPuzzle_cannon03;
    global.puzzleRoomList[UnknownEnum.Value_5][4] = rmPuzzle_cannon04;
    global.puzzleRoomList[UnknownEnum.Value_6][0] = rmPuzzle_finalMix00;
    global.puzzleRoomList[UnknownEnum.Value_6][1] = rmPuzzle_finalMix01;
    global.puzzleRoomList[UnknownEnum.Value_6][2] = rmPuzzle_finalMix02;
    global.puzzleRoomList[UnknownEnum.Value_6][3] = rmPuzzle_finalMix04;
    global.puzzleRoomList[UnknownEnum.Value_6][4] = rmPuzzle_finalMix03;
}
