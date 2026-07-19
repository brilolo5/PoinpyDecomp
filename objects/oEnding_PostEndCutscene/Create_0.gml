targetDelta = 0.016666666666666666;
actualDelta = delta_time / 1000000;
deltaRate = actualDelta / targetDelta;
endingAudio = -1;
endingAudioPosition = 0;
endSkipHold = -1;
skipped = 0;
audioStartAlarm = 60;
audioStart = 0;
currentAnimCurve = acEnd_00_PoinpuWakes;
currentSceneSprite = sEnd_00_PoinpuWakes_op;
currentSceneSpriteIndex = 0;
currentSequence = seqEnd_00_PoinpuWakes;
currentSceneBgSprite = sEnd_00_PoinpuWakes_op;
currentSceneBgIndex = 0;
dreamBubbleZoomOutSequence = "thank you rising";
dreamBubbleZoomOutSequenceTimer = 0;
var _cr = global.surfaceCompressionRate;
var _bubbleW = sprite_get_width(sUItestThoughtCloud);
var _bubbleH = sprite_get_height(sUItestThoughtCloud);
var _surfW = global.viewWidth * _cr;
var _surfH = global.viewHeight * _cr;
dbCropSurface = surface_create_track(_surfW, _surfH);
dbInsideSurface = surface_create_track(_surfW, _surfH);
dbShrink = 1;
dbOffsetx = 16;
dbOffsety = -76;
initialThankYouTextOffsetRate = 1;
sceneEnd = 0;
darkAlpha = 0;
thankYouTextAppearTimer = 0;
thankYouTextDisappearTimer = 0;
resultScreenAppearTimer = 0;
resultScreenAppear = 0;
curvePos = 0;
audioStop(global.areaMusic);
assetIndex = -1;

function getSequenceSpeed(arg0)
{
    var _seq = sequence_get(arg0);
    return _seq.playbackSpeed / 60 / _seq.length;
}

function addScene(arg0, arg1, arg2)
{
    assetIndex += 1;
    sceneSpeed[assetIndex] = tempGetSequenceSpeed(arg0);
    sceneCurve[assetIndex] = arg1;
    sceneSprite[assetIndex] = arg2;
    sceneBgSprite[assetIndex] = -1;
    sceneBgIndex[assetIndex] = -1;
    
    if (argument_count > 3)
    {
        sceneBgSprite[assetIndex] = argument[3];
        sceneBgIndex[assetIndex] = argument[4];
    }
}

addScene(seqEnd_00_PoinpuWakes, acEnd_00_PoinpuWakes, sEnd_00_PoinpuWakes_op, sEnd_00_PoinpuWakes_op, 0);
addScene(seqEnd_01_Window, acEnd_01_Window, sEnd_01_LooksOutTheWindow_op, sEnd_01_LooksOutTheWindow_op, 0);
addScene(seqEnd_02_NussieLunges, acEnd_02_NussieLunges, sEnd_02_NussieLunges_op, sEnd_02_NussieLunges_op, 19);
addScene(seqEnd_03insert01_NussieLooking, acEnd_03insert01_NussieLooking, sEnd_02_00_PoinpuPOV);
addScene(seqEnd_03insert00_Stares, acEnd_03insert02_Stares, sEnd_02_NussieLunges_op, sEnd_02_NussieLunges_op, 19);
addScene(seqEnd_03_Pets, acEnd_03_Pets, sEnd_02_NussieLunges_op, sEnd_02_NussieLunges_op, 19);
addScene(seqEnd_03insert00_Pets, acEnd_03insert00_Pets, sEnd_02_NussieLunges_op, sEnd_02_NussieLunges_op, 19);
addScene(seqEnd_04_RunsThrough, acEnd_04_RunsThrough, sEnd_03_NussieRunsThrough_op, sEnd_03_NussieRunsThrough_opBG, 0);
addScene(seqEnd_05_AtFoodBowl, acEnd_05_AtFoodBowl, sEnd_04_NussieAtFoodBowl_op, sEnd_04_NussieAtFoodBowl_opBG, 0);
addScene(seqEnd_06_OpenCupboard, acEnd_06_OpenCupboard, sEnd_05_OpensCupboard, sEnd_05_OpensCupboard, 0);
addScene(seqEnd_07_FoodIntoBowl1, acEnd_07_FoodIntoBowl, sEnd_06_FoodIntoBow_op, sEnd_06_FoodIntoBow_op, 0);
addScene(seqEnd_0701_NussieStartsEating, acEnd_0701_FoodIntoBowl2, sEnd_07_FoodIntoBowl2_op, sEnd_07_FoodIntoBowl2_op, 0);
addScene(seqEnd_08_PoinpuSmiling, acEnd_08_PoinpuSmiling, sEnd_08_Eating_op, sEnd_08_Eating_op, 0);
addScene(seqEnd_0801_PoinpuSmilingLoop, acEnd_0801_loop, sEnd_08_Eating_op, sEnd_08_Eating_op, 0);
assetIndexMax = assetIndex;
assetIndex = 0;
curveSp = sceneSpeed[0];
