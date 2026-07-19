if (!textSpawned)
{
    global.finalStretchSequence = UnknownEnum.Value_3;
    
    with (instance_create_depth(x, y, depth, effectText))
    {
        text = loc("main game notification final stretch");
        drawx = global.windowCenterx;
        drawy = global.viewHeight / 3.5;
        drawGui = true;
        mainColor = make_color_rgb(255, 255, 255);
        shadeColor = make_color_rgb(46, 50, 59);
        angle = 0;
        size = 1;
        halign = 1;
        valign = 1;
        killTimer = 240;
    }
    
    textSpawned = 1;
    alarm[0] = 120;
}
