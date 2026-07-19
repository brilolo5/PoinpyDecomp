event_inherited();
breathStateInit = 1;
briefBounceAudio = 0;
pressed = 0;
progressRemain = global.juicerRankProgress;

for (i = 0; i <= global.juicerRankMax; i += 1)
{
    if (progressRemain >= global.juicerRankUpThreshold[i])
        progressRemain -= global.juicerRankUpThreshold[i];
    else
        break;
}

xsp = 0;
ysp = 0;
breath = pi;
briefBounce = 0;
breathState = "breathe in";
breathRatio = 0;
faceOffsety = 0;
beastFaceSprite = sBeastPart_FaceAsleep_BreatheIn;
beastFaceIndex = 0;
breathStateSwitchDelayTimer = 0;
breathStop = 0;
beastBreatheCount = 0;
beastMumbleLoopCount = 0;
leftEarIndex = 0;
leftEarOffsety = 0;
rightEarIndex = 0;
rightEarOffsety = 0;
audioVarBeastMumble = 0;
