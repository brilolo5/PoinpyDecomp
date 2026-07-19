global.cam = camera_create_view(0, 0, global.viewWidth, global.viewHeight, 0, -1, -1, -1, -1, -1);
view_set_camera(0, global.cam);
view_visible[0] = 1;
view_enabled = 1;
camera_set_view_size(global.cam, global.viewWidth, global.viewHeight);
cameraPosy_offset = -(global.viewHeight / 10);
inPuzzleMode = 0;
scrollButtonActive = 0;
puzzleStarted = 0;
puzzleScrollMode = 0;
puzzleScrollExit = 0;
puzzleScrollUpInput = 0;
puzzleScrollDownInput = 0;
puzzleBinocularAlpha = 0;
puzzleBinocularPupilOffset = 0;
puzzleScrollInputPressed = 0;
introOffsety = 0;
introOffsetyAmount = 0;

if (room == rmMainGame)
{
    introOffsety = 1;
    introOffsetyAmount = 60;
}

if (room == rmPlayableMainMenu)
{
    if (global.tutorialOver >= 1)
        alarm[0] = 1;
}

camDebugLock = -1;
camManualControl = 0;
camPosx = 80;
camGoalPosx = camPosx;
camPosy = y + introOffsetyAmount;
camGoalPosy = y;
playerHorizontalFrameNum = 0;
prv_playerHorizontalFrameNum = 0;

if (instance_exists(oPlayer) && room != rmMainGame)
{
    camPosy = oPlayer.y;
    camGoalPosy = oPlayer.y;
    playerHorizontalFrameNum = floor(oPlayer.x / 160);
}

screenShakeTimer = 0;
screenShakeAmount = 0;
frameTimer = 1;
horizontalFollow = 0;

if (room == rmPlayableMainMenu)
    horizontalFollow = 0;
