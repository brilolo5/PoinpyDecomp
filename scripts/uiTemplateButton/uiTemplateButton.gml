function uiTemplateButton(arg0, arg1)
{
    uiTemplatePill(make_color_rgb(218, 221, 226), 0.75);
    text = arg0;
    textBlend = make_color_rgb(255, 255, 255);
    textSize = 0.5 * arg1;
    textXOffset = 0;
    textYOffset = 0;
    var _textElement = scribble(text).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 3).transform(textSize, textSize, 0).align(1, 1);
    var _bbox = _textElement.get_bbox();
    setWidth(_bbox.width);
    setHeight(_bbox.height);
    eventAddFunction(UnknownEnum.Value_4, function()
    {
        if (input_player_source_get() == UnknownEnum.Value_2 || !(os_type == os_ios || os_type == os_android))
        {
            visBlend = make_color_rgb(255, 255, 255);
            textBlend = make_color_rgb(255, 238, 96);
        }
    });
    eventAddFunction(UnknownEnum.Value_7, function()
    {
        visBlend = make_color_rgb(218, 221, 226);
        textBlend = make_color_rgb(255, 255, 255);
        textXOffset = 0;
        textYOffset = 0;
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
        
        textXOffset = 0;
        textYOffset = 0;
    });
    eventAddFunction(UnknownEnum.Value_2, function()
    {
        scribble(text).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 3).transform(textSize, textSize, 0).align(1, 1).blend(textBlend, visBlend).draw(getDrawX() + textXOffset, getDrawY() + textYOffset);
    });
}
