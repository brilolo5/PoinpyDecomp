function uiTemplateTextSimple()
{
    var _font = argument[0];
    var _text = argument[1];
    font = _font;
    text = _text;
    visBlend = 16777215;
    visAlpha = 1;
    var _old_font = draw_get_font();
    draw_set_font(font);
    setWidth(string_width(text));
    setHeight(string_height(text));
    draw_set_font(_old_font);
    
    eventDraw = function()
    {
        var _old_halign = draw_get_halign();
        var _old_valign = draw_get_valign();
        var _old_font = draw_get_font();
        var _old_blend = draw_get_colour();
        var _old_alpha = draw_get_alpha();
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_font(font);
        draw_set_colour(visBlend);
        draw_set_alpha(visAlpha);
        draw_text(getDrawLeft(), getDrawTop(), text);
        draw_set_halign(_old_halign);
        draw_set_valign(_old_valign);
        draw_set_font(_old_font);
        draw_set_colour(_old_blend);
        draw_set_alpha(_old_alpha);
    };
}
