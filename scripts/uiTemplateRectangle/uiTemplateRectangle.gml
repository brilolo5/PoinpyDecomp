function uiTemplateRectangle(arg0, arg1)
{
    visBlend = arg0;
    visAlpha = arg1;
    eventAddFunction(UnknownEnum.Value_2, function()
    {
        drawRectangleFast(getDrawLeft(), getDrawTop(), getDrawRight(), getDrawBottom(), visBlend, visAlpha);
    });
}
