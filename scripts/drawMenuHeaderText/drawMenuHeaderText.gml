function drawMenuHeaderText(arg0)
{
    text = arg0;
    textSize = 2;
    visBlend = make_color_rgb(255, 255, 255);
    textElement = scribble(text).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 3).transform(0.5 * textSize, 0.5 * textSize, 0).scale_to_box(getParent().getShapeWidth() - 20, -1);
    headerTypist = scribble_typist();
    headerTypist.in(1, 5).ease(UnknownEnum.Value_6, 0, 5, 1, 1, 0, 0);
    var _bbox = textElement.get_bbox();
    setWidth(_bbox.width);
    setHeight(_bbox.height);
    eventAddFunction(UnknownEnum.Value_2, function()
    {
        textElement.starting_format(global.defaultFont, make_color_rgb(255, 255, 255)).blend(16777215, 1).msdf_border(make_color_rgb(46, 50, 59), 3).transform(textSize / 2, textSize / 2, 0).align(0, draw_get_valign()).draw(getDrawLeft(), getDrawTop(), headerTypist);
    });
}
