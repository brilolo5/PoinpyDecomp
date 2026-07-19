shadeCol = merge_color(mainColor, make_color_rgb(46, 50, 59), 0.95);
TextCol = merge_color(mainColor, make_color_rgb(255, 255, 255), 0.95);
var _viewy = getViewy();
var _viewx = getViewx();
var _textPosx = global.windowCenterx;
var _textPosy = global.windowMiddley / 1.05;
scrText.overwrite(areaNameText).msdf_shadow(0, 0.3, 0, 0, 0.25).blend(TextCol, 1).draw(_textPosx, _textPosy);

if (scrText.get_typewriter_state() >= 1)
{
    remainTimer += ((1 / textRemainTime) * global.deltaTimeRate);
    
    if (remainTimer >= 1)
        scrText.typewriter_ease(UnknownEnum.Value_2, 0, -8, 1, 0, 0, 0.5).typewriter_out(textOutSpeed, textOutSmoothness);
    
    if (scrText.get_typewriter_state() == 2)
    {
        killTimer += 0.004166666666666667;
        
        if (killTimer >= 1)
        {
            scrText.typewriter_reset();
            instance_destroy();
        }
    }
}
