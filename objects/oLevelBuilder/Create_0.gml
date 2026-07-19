startingDifficulty = global.difficultyLevel;
nextUp = "level chunk";
levelNum = 0;
pLevelNum = 0;
levelPatternVar = 0;
finalAreaLock = 0;
wideSlimChunkDirection = 1;
discoveryQueue = false;
finalAreaTransition = UnknownEnum.Value_0;
spaceShaftChunkRepeatAmount = 40;
spaceShaftChunkRepeatAmount_tailEnd = 16;
areaChangeThreshold = 28;
queueTransitionChunk = 0;
startChunk = 1;

if (global.areaChangeTracker > (areaChangeThreshold - 6))
    global.areaChangeTracker = areaChangeThreshold - 6;

discoveryList[0][UnknownEnum.Value_0] = global.areaUnlockThreshold[0];
discoveryList[0][UnknownEnum.Value_1] = UnknownEnum.Value_2;
discoveryList[1][UnknownEnum.Value_0] = global.areaUnlockThreshold[1];
discoveryList[1][UnknownEnum.Value_1] = UnknownEnum.Value_3;
discoveryList[2][UnknownEnum.Value_0] = global.areaUnlockThreshold[2];
discoveryList[2][UnknownEnum.Value_1] = UnknownEnum.Value_4;
discoveryList[3][UnknownEnum.Value_0] = global.areaUnlockThreshold[3];
discoveryList[3][UnknownEnum.Value_1] = UnknownEnum.Value_5;
discoveryListEntries = 4;

with (oGameBackground)
{
    bgArea = global.currentLevelChunkSet;
    bgLayerData = getAreaColor(bgArea);
}
