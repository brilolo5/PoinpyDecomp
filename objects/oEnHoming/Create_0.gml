event_inherited();
blinkAlarm = new makeAlarm(0, function()
{
    blinking = 1;
});

blinkTime = function()
{
    return 6 + irandom(120);
};

editing = 1;
eyeAngle = random(360);
eyeIndex = 3;
spriteIndex = sEnemyHomer_Body;
imageIndex = 0;
mask_index = sEnTesthoming;
deadSprite = sEnemyHomer_Dead;
enemyState = "idle";
stateTimer = 0;
flutterIndex = 0;
flutterSpeed = 0.05;
eyelidIndex = 0;
blinking = 0;
unstompable = 0;
damagePlayer = 1;
grounded = 0;
grav = 0;
gravityEnabled = 0;
maxFallSpeed = 16;
xsp = 0;
ysp = 0;
cx = 0;
cy = 0;
hitStop = 0;
facing = sign((80 - x) + 1);
xDirection = facing;

if (facing == 1)
    facing = -30;
else
    facing = 210;

xscaleBase = 0.1;
yscaleBase = 0.1;
yDirection = 1;
xShrink = 1;
yShrink = 1;
xscale = xscaleBase * xDirection * xShrink;
yscale = yscaleBase * yDirection * yShrink;
tailArray[0][0] = x;
tailArray[0][1] = y;
tailArrayDelay = 20;

for (var i = 1; i <= tailArrayDelay; i += 1)
{
    tailArray[i][0] = x;
    tailArray[i][1] = y;
}

frameTimeTracker = 0;

tailArrayPush = function()
{
    tailArray[0][0] = x + cx;
    tailArray[0][1] = y + cy;
    
    for (var i = tailArrayDelay; i >= 1; i -= 1)
    {
        tailArray[i][0] = tailArray[i - 1][0];
        tailArray[i][1] = tailArray[i - 1][1];
    }
};
