if (whiteOutAlpha > 0)
{
    draw_set_color(make_color_rgb(255, 255, 255));
    draw_set_alpha(whiteOutAlpha);
    drawRectFromCenter(global.windowCenterx, global.windowMiddley, global.viewWidth * 2, global.viewHeight * 2, 0);
    draw_set_alpha(1);
}

if (whiteOutTextAlpha > 0)
{
    draw_set_alpha(whiteOutTextAlpha);
    var _textx = global.windowCenterx;
    var _texty = global.windowMiddley;
    scribble(whiteOutText).starting_format(global.defaultFont, make_color_rgb(255, 255, 255)).blend(make_color_rgb(255, 255, 255), whiteOutTextAlpha).msdf_border(make_color_rgb(46, 50, 59), 3).transform(0.4, 0.4, 0).align(1, 1).wrap(280, -1, locIsAsian()).animation_wave(2, 50, 0.1).draw(_textx, _texty);
    draw_set_alpha(1);
}
