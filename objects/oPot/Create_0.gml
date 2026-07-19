event_inherited();
deadSprite = sDeadSpriteDefault;
enemyState = "idle";
stateTimer = 0;
myFruit = -4;
unstompable = 0;
damagePlayer = 0;
grounded = 0;
grav = 0;
gravityEnabled = 0;
maxFallSpeed = 16;
xsp = 0;
ysp = 0;
cx = 0;
cy = 0;
hitStop = 0;
xscaleBase = 0.1;
yscaleBase = 0.1;
xDirection = 1;
yDirection = 1;
xShrink = 1;
yShrink = 1;
xscale = xscaleBase * xDirection * xShrink;
yscale = yscaleBase * yDirection * yShrink;
mask_index = sprite_index;
sprite_index = sPot00;

if (abilityCheck(UnknownEnum.Value_17))
    alarm[0] = 2;
