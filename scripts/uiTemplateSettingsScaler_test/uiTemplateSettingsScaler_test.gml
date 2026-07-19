function uiTemplateSettingsScaler_test(arg0, arg1, arg2, arg3, arg4, arg5)
{
    rectangleBlend = make_color_rgb(218, 221, 226);
    val = variable_global_get(arg4);
    valRounded = val;
    valRounded_p = val;
    knobSizeScale = 1;
    testSound = arg5;
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
    eventAddFunction(UnknownEnum.Value_16, function()
    {
        textBlend = make_color_rgb(248, 45, 97);
        textXOffset = -2;
        textYOffset = -2;
        knobSizeScale = 1;
    });
    eventAddFunction(UnknownEnum.Value_18, function()
    {
        if (input_player_source_get() == UnknownEnum.Value_2 || !(os_type == os_ios || os_type == os_android))
            textBlend = make_color_rgb(255, 238, 96);
        else
            textBlend = make_color_rgb(255, 255, 255);
        
        knobSizeScale = 1;
        circleTweenA = variable_global_get(variableName);
        circleTweenB = !variable_global_get(variableName);
        circleTweenT = 0;
        
        if (testSound != -1)
            playSfxUI(testSound, 0, 1);
        
        variable_global_set(variableName, valRounded);
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
        val += (scrollTargetX / 50);
        val = clamp(val, 0, 1);
        valRounded = round(val * 10) / 10;
        
        if (valRounded_p != valRounded)
        {
            valRounded_p = valRounded;
            variable_global_set(variableName, valRounded);
            trace("uiTemplateSettingsToggle: Toggling ", variableName, " = ", variable_global_get(variableName));
            returnValue = 1;
        }
        
        finaltext = text;
        scribble(finaltext).starting_format(global.defaultFont, textBlend).scale_to_box(outVisWidth, -1).msdf_border(make_color_rgb(46, 50, 59), 3).transform(textSize, textSize, 0).align(2, 1).draw((getDrawX() + textXOffset) - 3, getDrawY() + textYOffset);
        var _pillL = getDrawX() + 8;
        var _pillT = getDrawTop() + 4;
        var _pillR = _pillL + 56.25;
        var _pillB = getDrawBottom() - 4;
        var _height = 4 * knobSizeScale;
        var _circleL = _pillL + (_height * 1.5);
        var _circleR = _pillR - (_height * 1.5);
        var _pillColour = make_color_rgb(90, 243, 145);
        var _circleColour = make_color_rgb(255, 255, 255);
        drawPillWithOutline(_pillL, _pillT, _pillR, _pillB, _pillColour, make_color_rgb(46, 50, 59), 1);
        drawPill(_pillL + 7, _pillT + 3.5, _pillR - 7, _pillB - 3.5, make_color_rgb(69, 80, 97), 1);
        var _x = lerp(_circleL, _circleR, 0.5);
        _x = lerp(_circleL, _circleR, valRounded / 1);
        drawCircleFast(_x, getDrawY(), _height - 1, make_color_rgb(46, 50, 59), 1);
        drawCircleFast(_x, getDrawY(), _height - 2, _circleColour, 1);
    });
}
