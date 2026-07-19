function uiTemplateSettingsToggle(arg0, arg1, arg2, arg3, arg4)
{
    rectangleBlend = make_color_rgb(218, 221, 226);
    text = arg0;
    textSize = 0.5 * arg1;
    textBlend = make_color_rgb(255, 255, 255);
    textMaxWidth = arg2;
    textMaxHeight = arg3;
    textXOffset = 0;
    textYOffset = 0;
    variableName = arg4;
    circleTweenA = variable_global_get(variableName);
    circleTweenB = variable_global_get(variableName);
    circleTweenT = 0;
    var _textElement = scribble(text).starting_format(global.defaultFont, make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 3).transform(textSize, textSize, 0);
    var _bbox = _textElement.get_bbox();
    setWidth(_bbox.width);
    setHeight(_bbox.height);
    eventAddFunction(UnknownEnum.Value_4, function()
    {
        if (input_player_source_get() == UnknownEnum.Value_2 || !(os_type == os_ios || os_type == os_android))
            textBlend = make_color_rgb(255, 238, 96);
    });
    eventAddFunction(UnknownEnum.Value_5, function()
    {
        rectangleBlend = make_color_rgb(255, 255, 255);
    });
    eventAddFunction(UnknownEnum.Value_7, function()
    {
        rectangleBlend = make_color_rgb(218, 221, 226);
        textBlend = make_color_rgb(255, 255, 255);
    });
    eventAddFunction(UnknownEnum.Value_8, function()
    {
        textBlend = make_color_rgb(248, 45, 97);
        textXOffset = -2;
        textYOffset = -2;
    });
    eventAddFunction(UnknownEnum.Value_10, function()
    {
        if (input_player_source_get() == UnknownEnum.Value_2 || !(os_type == os_ios || os_type == os_android))
            textBlend = make_color_rgb(255, 238, 96);
        else
            textBlend = make_color_rgb(255, 255, 255);
        
        circleTweenA = variable_global_get(variableName);
        circleTweenB = !variable_global_get(variableName);
        circleTweenT = 0;
        variable_global_set(variableName, !variable_global_get(variableName));
        trace("uiTemplateSettingsToggle: Toggling ", variableName, " = ", variable_global_get(variableName));
    });
    eventAddFunction(UnknownEnum.Value_11, function()
    {
        textXOffset = 0;
        textYOffset = 0;
    });
    eventAddFunction(UnknownEnum.Value_1, function()
    {
        circleTweenT = approach(circleTweenT, 1, 0.14285714285714285);
    });
    eventAddFunction(UnknownEnum.Value_2, function()
    {
        drawPill(getDrawLeft(), getDrawTop(), getDrawRight(), getDrawBottom(), rectangleBlend, outCursorInside ? 0.75 : 0);
        scribble(text).starting_format(global.defaultFont, textBlend).scale_to_box(outVisWidth, -1).msdf_border(make_color_rgb(46, 50, 59), 3).transform(textSize, textSize, 0).align(2, 1).draw((getDrawX() + textXOffset) - 3, getDrawY() + textYOffset);
        var _pillL = getDrawX() + 8;
        var _pillT = getDrawTop() + 3;
        var _pillR = _pillL + 25;
        var _pillB = getDrawBottom() - 3;
        var _height = 0.5 * (_pillB - _pillT);
        var _circleL = _pillL + _height;
        var _circleR = _pillR - _height;
        var _pillColour = variable_global_get(variableName) ? make_color_rgb(90, 243, 145) : make_color_rgb(198, 203, 211);
        var _circleColour = variable_global_get(variableName) ? make_color_rgb(255, 255, 255) : make_color_rgb(122, 131, 146);
        var _x = lerp(_circleL, _circleR, lerp(circleTweenA, circleTweenB, power(circleTweenT, 4)));
        drawPillWithOutline(_pillL, _pillT, _pillR, _pillB, _pillColour, make_color_rgb(46, 50, 59), 1);
        drawCircleFast(_x, getDrawY(), _height - 1, make_color_rgb(46, 50, 59), 1);
        drawCircleFast(_x, getDrawY(), _height - 2, _circleColour, 1);
    });
}

function uiTemplateSettingsCredits(arg0, arg1, arg2, arg3, arg4)
{
    rectangleBlend = make_color_rgb(218, 221, 226);
    text = arg0;
    textSize = 0.65 * arg1;
    textBlend = make_color_rgb(255, 255, 255);
    textMaxWidth = arg2;
    textMaxHeight = arg3;
    textXOffset = 0;
    textYOffset = 0;
    variableName = arg4;
    circleTweenA = variable_global_get(variableName);
    circleTweenB = variable_global_get(variableName);
    circleTweenT = 0;
    var _textElement = scribble(text).starting_format(global.defaultFont, make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 3).transform(textSize, textSize, 0);
    var _bbox = _textElement.get_bbox();
    setWidth(_bbox.width);
    setHeight(_bbox.height);
    eventAddFunction(UnknownEnum.Value_4, function()
    {
        if (input_player_source_get() == UnknownEnum.Value_2 || !(os_type == os_ios || os_type == os_android))
            textBlend = make_color_rgb(255, 238, 96);
    });
    eventAddFunction(UnknownEnum.Value_5, function()
    {
        rectangleBlend = make_color_rgb(255, 255, 255);
    });
    eventAddFunction(UnknownEnum.Value_7, function()
    {
        rectangleBlend = make_color_rgb(218, 221, 226);
        textBlend = make_color_rgb(255, 255, 255);
    });
    eventAddFunction(UnknownEnum.Value_8, function()
    {
        textBlend = make_color_rgb(248, 45, 97);
        textXOffset = -2;
        textYOffset = -2;
    });
    eventAddFunction(UnknownEnum.Value_10, function()
    {
        if (input_player_source_get() == UnknownEnum.Value_2 || !(os_type == os_ios || os_type == os_android))
            textBlend = make_color_rgb(255, 238, 96);
        else
            textBlend = make_color_rgb(255, 255, 255);
        
        circleTweenA = variable_global_get(variableName);
        circleTweenB = !variable_global_get(variableName);
        circleTweenT = 0;
        instance_create_depth(mouse_x, mouse_y, 0, oEndCredit);
        instance_destroy(rootInstance);
    });
    eventAddFunction(UnknownEnum.Value_11, function()
    {
        textXOffset = 0;
        textYOffset = 0;
    });
    eventAddFunction(UnknownEnum.Value_1, function()
    {
        circleTweenT = approach(circleTweenT, 1, 0.14285714285714285);
    });
    eventAddFunction(UnknownEnum.Value_2, function()
    {
        drawPill(getDrawLeft(), getDrawTop(), getDrawRight(), getDrawBottom(), rectangleBlend, outCursorInside ? 0.75 : 0);
        scribble(text).starting_format(global.defaultFont, textBlend).scale_to_box(outVisWidth, -1).msdf_border(make_color_rgb(46, 50, 59), 3).transform(textSize, textSize, 0).align(1, 1).draw((getDrawX() + textXOffset) - 3, getDrawY() + textYOffset);
        var _pillL = getDrawX() + 8;
        var _pillT = getDrawTop() + 3;
        var _pillR = _pillL + 25;
        var _pillB = getDrawBottom() - 3;
        var _height = 0.5 * (_pillB - _pillT);
        var _circleL = _pillL + _height;
        var _circleR = _pillR - _height;
        var _pillColour = variable_global_get(variableName) ? make_color_rgb(90, 243, 145) : make_color_rgb(198, 203, 211);
        var _circleColour = variable_global_get(variableName) ? make_color_rgb(255, 255, 255) : make_color_rgb(122, 131, 146);
    });
}
