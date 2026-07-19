var xDirection = sign(x - (room_width / 2));

with (instance_create_depth(x, y, 0, oMagmaStreamParticle))
{
    x += random_range(-2, 2);
    xsp = random_range(0.1, 1) * -xDirection;
    ysp = random_range(-1, 0);
    imageAngle = random(360);
    var _scale = random_range(0.5, 0.75);
    xscale = _scale;
    yscale = _scale;
    grav = 0.1;
}

alarm[0] = timeBetweenEmit;

if (instance_exists(oMagma))
{
    if (y > oMagma.bbox_top)
        instance_destroy();
}
