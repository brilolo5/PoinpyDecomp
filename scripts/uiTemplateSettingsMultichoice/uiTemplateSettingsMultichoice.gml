function uiTemplateSettingsMultichoice(arg0, arg1, arg2, arg3, arg4)
{
    rectangleBlend = make_color_rgb(218, 221, 226);
    text = arg0;
    textSize = 0.5 * arg1;
    textBlend = make_color_rgb(255, 255, 255);
    textMaxWidth = arg2;
    textMaxHeight = arg3;
    textXOffset = 0;
    textYOffset = 0;
    getterFunction = arg4;
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
    });
    eventAddFunction(UnknownEnum.Value_11, function()
    {
        textXOffset = 0;
        textYOffset = 0;
    });
    eventAddFunction(UnknownEnum.Value_2, function()
    {
        drawPill(getDrawLeft(), getDrawTop(), getDrawRight(), getDrawBottom(), rectangleBlend, outCursorInside ? 0.75 : 0);
        scribble(text).blend(textBlend, 1).starting_format(global.defaultFont, 16777215).scale_to_box(outVisWidth, -1).msdf_border(make_color_rgb(46, 50, 59), 3).transform(textSize, textSize, 0).align(2, 1).draw((getDrawX() + textXOffset) - 3, getDrawY() + textYOffset);
        scribble(locGetLanguageNameInTheirLanguage(getterFunction())).blend(textBlend, 1).starting_format(global.defaultFont, 16777215).scale_to_box(outVisWidth, -1).msdf_border(make_color_rgb(46, 50, 59), 3).transform(textSize, textSize, 0).align(0, 1).draw(getDrawX() + textXOffset + 8, getDrawY() + textYOffset);
    });
}
