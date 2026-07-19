image_speed = 0;
imageIndex = 0;
cannonDefaultAngle = image_angle * getHDirectionOnCreate(noFlip, -oppositeSide, image_xscale);
cannonAngle = choose(-30, 30);
cannonTime = 0;
pCannonTempSlingAngle = global.cannonTempSlingAngle;
cannonMotionActive = 1;
cannonUseCount = 0;
inactive = 0;
image_xscale = 1;
spriteIndex = sCannonParts;
afterImageIndex = sCannonParts_gray;

if (atFinalArea())
{
    spriteIndex = sCannonParts_neon;
    afterImageIndex = sCannonParts_gray_neon;
}

trajectoryTweenXsp = 0;
trajectoryTweenYsp = 0;
trajecoryDashAppearTween = 0;
cannonAuraRadius = 0;
audioVarCannon = 0;
audioVarCannonTail = 1;
