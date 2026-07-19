function uiTemplateTextScaled(arg0, arg1)
{
    text = arg0;
    textSize = arg1;
    visBlend = make_color_rgb(255, 255, 255);
    textElement = scribble(text).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 3).transform(0.5 * arg1, 0.5 * arg1, 0);
    var _bbox = textElement.get_bbox();
    setWidth(_bbox.width);
    setHeight(_bbox.height);
    eventAddFunction(UnknownEnum.Value_2, function()
    {
        drawTextOutlined(getDrawLeft(), getDrawTop(), text, visBlend, make_color_rgb(46, 50, 59), 0, textSize);
    });
}
