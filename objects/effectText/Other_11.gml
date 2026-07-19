if (drawGui)
{
    y = getViewy(global.cam);
    drawSetAlign(halign, valign);
    drawTextOutlined(drawx, drawy, text, mainColor, shadeColor, angle, size, wrapWidth);
}
