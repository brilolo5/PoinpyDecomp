var _id = id;

with (oDiscoverNewAreaText)
{
    if (id != _id)
        instance_destroy();
}

remainTimer = 0;
killTimer = 0;
textInSpeed = 0.75;
textInSmoothness = 5;
textRemainTime = 210;
textOutSpeed = 0.95;
textOutSmoothness = textInSmoothness;

with (oOrderControl)
    banPreActive = max(0.75, banPreActive);

areaNameText = "null";
mainColor = make_color_rgb(255, 255, 255);

switch (global.currentLevelChunkSet)
{
    case UnknownEnum.Value_1:
        areaNameText = "beginner (error)";
        mainColor = make_color_rgb(255, 255, 255);
        instance_destroy();
        break;
    
    case UnknownEnum.Value_2:
        areaNameText = loc("area name jungle");
        mainColor = make_color_rgb(65, 231, 125);
        break;
    
    case UnknownEnum.Value_3:
        areaNameText = loc("area name aqua");
        mainColor = make_color_rgb(36, 145, 249);
        break;
    
    case UnknownEnum.Value_4:
        areaNameText = loc("area name mines");
        mainColor = make_color_rgb(248, 45, 97);
        break;
    
    case UnknownEnum.Value_5:
        areaNameText = loc("area name temple");
        mainColor = make_color_rgb(225, 223, 1);
        break;
    
    case UnknownEnum.Value_6:
        areaNameText = loc("area name outerspace");
        mainColor = make_color_rgb(46, 50, 59);
        break;
}

textSize = 0.9;
scrText = scribble(areaNameText).typewriter_reset().starting_format(global.defaultFont, make_color_rgb(255, 255, 255)).line_height(10, 26).msdf_shadow(make_color_rgb(46, 50, 59), 0.1, 2, 2).transform(textSize / 2, textSize / 2, 5).fit_to_box(208, 72, 0).align(1, 1).typewriter_ease(UnknownEnum.Value_2, 0, 8, 1, 0, 0, 0.5).typewriter_in(textInSpeed, textInSmoothness);
