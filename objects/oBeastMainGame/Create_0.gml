beastyTween = 0;
beastGameState = "enter intro";
beastGameStateUpdate = 1;
switchRoomEntered = 0;
angerTimerRatio = 1;
faceAnimFrame = 0;
faceState = "wait level 1";
faceStateTimer = 0;
faceStateInit = 1;
faceSprite = sBeastPart_FaceWaitLevel1;
pFaceSprite = faceSprite;
deliciousFaceIndex = 0;
deliciousFaceArray = getBeastDelicousFaceSet(deliciousFaceIndex);
faceAnimLoopCount = 0;
faceImageIndex = 0;
p_faceImageIndex = 0;
faceAngle_xOffsetRateTween = 0;
faceAngleLock = 0;
beastForcePos = 0;
beastForcePosy = -1;
beastForcePosx = -1;
beastShakeTime = 0;
beastShakeAmount = 0;
beastStateInitialize = 1;
earSprite = sBeastPart_Ear;
drawEar = 1;
drawBody = 1;
shrinkScalex = 1;
shrinkScaley = 1;
baseShrinkScale = 1;
shrinkScaleOffset = 0;
shrinkAnimCurve = animcurve_get(curveElasticInv);
shrinkAnimCurveChannel = animcurve_get_channel(shrinkAnimCurve, "curve1");
shrinkAnimCurvePos = 0;
springWobbleValue = 0;
springWobbleSpeed = 0;
breatheValue = 0;
breatheSpeed = 0.016666666666666666;
angerFlashDarkAlpha = 0;
waitStateLevel = 0;
p_waitStateLevel = -1;
fruitReceiveWobbleScale = 0.1;
beastFlash = 0;
postFailureAnger = 1;
angerLevel4ratio = 0;
beastFaceStateChange("wait level 3");
enterIntroOffsety = 80;
enterIntroOffsetyDefault = 80;

if (room != rmMainGame)
{
    enterIntroOffsetyDefault = 0;
    beastFaceStateChange("ending");
    beastFaceStateChange("end glug start");
}

gameStartBeastEnterTweenStart = 0;
gameStartBeastEnterTweenPos = 0;
effectMap = ds_map_create();
effectMapIndex = 0;

newBeastEffect = function(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = 1, arg9 = 1, arg10 = 0, arg11 = 0, arg12 = 9999, arg13 = 0) constructor
{
    static _tick = function()
    {
        if (delay > 0)
        {
            delay -= doDelta(1);
        }
        else
        {
            imageIndex += doDelta(imageSpeed);
            x += doDelta(xsp);
            y += doDelta(ysp);
            killTimer -= doDelta(1);
        }
    };
    
    static _draw = function()
    {
        if (delay <= 0)
        {
            var _drawx = root.beastBasex + x;
            var _drawy = root.beastDrawy + y;
            draw_sprite_ext(sprite, imageIndex, _drawx, _drawy, xscale, yscale, angle, c_white, 1);
        }
    };
    
    static _checkDestroy = function()
    {
        if (imageIndex >= spriteNumber)
            return true;
        else if (killTimer <= 0)
            return true;
        else
            return false;
    };
    
    root = arg0;
    mapIndex = root.effectMapIndex;
    sprite = arg1;
    scale = arg5;
    xscale = arg8 * scale;
    yscale = arg9 * scale;
    imageIndex = 0;
    x = arg2;
    y = arg3;
    imageSpeed = arg4;
    angle = arg6;
    delay = arg7;
    xsp = arg10;
    ysp = arg11;
    killTimer = arg12;
    isStar = arg13;
    spriteNumber = sprite_get_number(sprite);
};

beastEffect = function(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7 = 1, arg8 = 1, arg9 = 0, arg10 = 0, arg11 = undefined, arg12 = undefined)
{
    ds_map_add(effectMap, effectMapIndex, new newBeastEffect(id, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12));
    effectMapIndex += 1;
};

testEffect = -1;
