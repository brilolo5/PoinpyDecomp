var gts = global.timeScale;
cx += (xsp * global.timeScale);
cy += (ysp * global.timeScale);
var xspRound = floor(abs(cx)) * sign(cx);
var yspRound = floor(abs(cy)) * sign(cy);
cx -= xspRound;
cy -= yspRound;
ysp += (((grav * gts) / 2) * gravityEnabled);

repeat (abs(xspRound))
    x += sign(xspRound);

repeat (abs(yspRound))
    y += sign(yspRound);

ysp += (((grav * gts) / 2) * gravityEnabled);

if (ysp > maxFallSpeed)
    ysp = maxFallSpeed;

xShrink = approach(xShrink, 1, 0.05 * gts);
yShrink = approach(yShrink, 1, 0.05 * gts);
xscale = xShrink * xscaleBase;
yscale = yShrink * yscaleBase;
image_angle = point_direction(0, 0, xsp, ysp);
