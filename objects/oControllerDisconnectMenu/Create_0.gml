with (parentMenu)
{
    if (id != other.id)
        instance_destroy();
}

pauseEnd();
pauseStart();
draw_set_halign(fa_left);
draw_set_valign(fa_top);

with (uiCreate("disconnect root"))
{
    eventAddFunction(UnknownEnum.Value_0, function()
    {
        setLTRBToWindow();
    });
    updateShape();
    
    with (newChild("disconnect header"))
    {
        setX(0.5 * getParent().getShapeWidth());
        setY(0.33 * getParent().getShapeHeight());
        uiTemplateTextScaledLimit(loc("pause header"), 2, getParent().getShapeWidth() - 20);
    }
    
    with (newChild())
    {
        setX(0.5 * getParent().getShapeWidth());
        setY(0.5 * getParent().getShapeHeight());
        var _width = getParent().getShapeWidth() - 20;
        textElement = scribble("[scale,0.5]Your controller has been disconnected.").starting_format(undefined, make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 6).wrap(_width, -1, locIsAsian());
        setWidth(textElement.get_width());
        setHeight(textElement.get_height());
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            textElement.draw(getDrawLeft(), getDrawTop());
        });
    }
    
    with (newChild())
    {
        uiTemplateButtonLimit("Resume", 1, 100);
        setX(0.5 * getParent().getShapeWidth());
        setY(0.66 * getParent().getShapeHeight());
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            instance_destroy(rootInstance);
            pauseEnd();
        });
    }
}
