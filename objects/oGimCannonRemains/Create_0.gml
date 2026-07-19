image_speed = 0;
imageIndex = 0;
cannonAngle = choose(-30, 30);
cannonTime = 0;
cannonUseCount = 0;
inactive = 0;
image_xscale = 1;
spriteIndex = sCannonParts_gray;

if (atFinalArea())
    spriteIndex = sCannonParts_gray_neon;
