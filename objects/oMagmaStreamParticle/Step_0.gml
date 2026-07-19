var gts = global.timeScale;
cx += (xsp * gts);
cy += (ysp * gts);
var xspRound = floor(abs(cx)) * sign(cx);
var yspRound = floor(abs(cy)) * sign(cy);
cx -= xspRound;
cy -= yspRound;
ysp += ((grav * gts) / 2);

repeat (abs(xspRound))
    x += sign(xspRound);

repeat (abs(yspRound))
    y += sign(yspRound);

ysp += ((grav * global.timeScale) / 2);

if (y > (ystart + 200))
{
    instance_destroy();
}
else if (instance_exists(oMagma))
{
    if (y > oMagma.bbox_top)
        instance_destroy();
}
