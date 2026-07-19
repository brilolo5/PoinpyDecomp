event_inherited();
audioVarHoodedHopperAlert = 0;
enemyState = "idle";
stateTimer = 0;
spriteIndex = sHoodedHopper_idle;
deadSprite = sHoodedHopper_dead;
imageIndex = 0;
unstompable = 0;
grounded = 0;
grav = 0.1;
gravityEnabled = 1;
maxFallSpeed = 4;
xsp = 0;
ysp = 0;
cx = 0;
cy = 0;
hitStop = 0;
y -= 4;
xDirection = (x > (room_width / 2)) ? -1 : 1;

if (randomDirection)
    xDirection = choose(1, -1);

yDirection = 1;
xscaleBase = 0.1;
yscaleBase = 0.1;
xShrink = 1;
yShrink = 1;
xscale = xShrink * xDirection * xscaleBase;
yscale = yShrink * yDirection * yscaleBase;
