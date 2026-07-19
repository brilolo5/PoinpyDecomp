with (instance_create_depth(x, y, depth, effectText))
{
    text = loc("main game notification x remaining", "5");
    drawx = global.windowCenterx;
    drawy = (global.viewHeight / 3.5) + 32;
    drawGui = true;
    mainColor = make_color_rgb(255, 255, 255);
    shadeColor = make_color_rgb(46, 50, 59);
    angle = 0;
    size = 1;
    halign = 1;
    valign = 1;
    killTimer = 240;
}

instance_destroy();
