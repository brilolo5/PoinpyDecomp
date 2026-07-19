depth = 10000;
layer0_y = y;
layer1_y = y;
bgArea = global.currentLevelChunkSet;

if (global.gameReinitializeState == "puzzle")
    bgArea = global.puzzleCurrentTheme;

if (room == rmTutorialMovement2)
    bgArea = 100;

finalAreaHorizonOffset = 0;
finalAreaStarScrollSpeed = 0;
finalAreaStarScrolly = 0;
bgLayerData = getAreaColor(bgArea);
drawAurora = 0;
drawApplePlanet = 0;
drawPlanetHorizon = 1;
drawTestHorizon = 0;
drawTestVerticalHorizon = 0;
