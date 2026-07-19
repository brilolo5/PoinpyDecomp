killTimer -= doDelta(1);

if (killTimer <= 0)
    instance_destroy();

drawx += xsp;
drawy += ysp;
xsp = approach(xsp, 0, xfric);
ysp = approach(ysp, 0, yfric);
