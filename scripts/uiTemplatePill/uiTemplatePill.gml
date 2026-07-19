function uiTemplatePill(arg0, arg1)
{
    visBlend = arg0;
    visAlpha = arg1;
    eventAddFunction(UnknownEnum.Value_2, function()
    {
        drawPill(getDrawLeft() - (getDrawHeight() / 2), getDrawTop(), getDrawRight() + (getDrawHeight() / 2), getDrawBottom(), visBlend, visAlpha);
    });
}
