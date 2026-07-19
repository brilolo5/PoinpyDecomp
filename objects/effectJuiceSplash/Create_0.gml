event_inherited();
enemyState = "idle";
unstompable = 0;
grounded = 0;
grav = 0.2;
gravityEnabled = 1;
maxFallSpeed = 16;
launchSpeed = random_range(2, 5);
launchDirection = random_range(15, 40);

if (choose(0, 1))
    launchDirection = 90 + abs(launchDirection - 90);

xsp = lengthdir_x(launchSpeed, launchDirection);
ysp = lengthdir_y(launchSpeed, launchDirection);
cx = 0;
cy = 0;
hitStop = 0;
xDirection = 1;
yDirection = 1;
xShrink = 1;
yShrink = 1;
xscale = 1;
yscale = 1;
image_index = choose(0, 1, 2, 3);
image_xscale = random_range(1, 2);
image_yscale = image_xscale;
alarm[0] = random_range(60, 90);
