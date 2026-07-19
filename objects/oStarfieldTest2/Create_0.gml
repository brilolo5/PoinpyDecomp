starCount = 128;
zMax = 64;
starSpeed = zMax / 12;
starBaseScale = 0.5;
posOffsetRangex = 64;
posOffsetRangey = 128;
posAvoidSpace = 8;
baseAppleSize = 0.1;
appleSize = 0.81;
appleSizeGoal = 8;
appleSizeIncreaseRate = appleSizeGoal / 36000;
appleShadeAlpha = 0.35;
appleShadeClearRate = appleShadeAlpha / 1200;
centeryOffset = 0;

for (var _i = 0; _i < starCount; _i += 1)
{
    star_x[_i] = random_range(posAvoidSpace, posOffsetRangex) * choose(-1, 1);
    star_y[_i] = random_range(posAvoidSpace / 2, posOffsetRangey) * choose(-1, 1);
    star_z[_i] = random(zMax);
    star_pz[_i] = star_z[_i];
}
