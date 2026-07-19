function uiTemplateText()
{
    var _string = "";
    var _i = 0;
    
    repeat (argument_count)
    {
        _string += string(argument[_i]);
        _i++;
    }
    
    return uiTemplateTextExt(_string, 16777215, 0, 3);
}

function uiTemplateTextExt(arg0, arg1, arg2, arg3)
{
    text = arg0;
    visBlend = arg1;
    borderColor = arg2;
    borderThickness = arg3;
    textElement = scribble(text);
    setWidth(textElement.get_width());
    setHeight(textElement.get_height());
    eventAddFunction(UnknownEnum.Value_2, function()
    {
        textElement.starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).blend(visBlend, visAlpha).msdf_border(borderColor, borderThickness).draw(getDrawLeft(), getDrawTop());
    });
    return textElement;
}
