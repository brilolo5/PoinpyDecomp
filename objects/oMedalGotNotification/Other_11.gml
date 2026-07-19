if (killTimer >= 0)
{
    killTimer -= 1;
    medalScaleTween = lerp(medalScaleTween, 1, 0.2);
    textScribble = scribble(loc("medal unlock")).typewriter_in(0.5, 10).typewriter_ease(UnknownEnum.Value_11, 0, 2, 1, 0.8, 0, 0.03).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).fit_to_box(128, 64, false).msdf_border(make_color_rgb(46, 50, 59), 2);
}
else
{
    textScribble.typewriter_out(0.5, 2, false);
    medalScaleTween = lerp(medalScaleTween, 0, 0.1);
    
    if (medalScaleTween <= 0.02)
        instance_destroy();
}

var _medalSprite = global.medalSprite[medalIndex];
var _medalIndex = 1;
var _medalx = global.windowLeft + 16;
var _medaly = global.windowMiddley;
var _medalScale = medalScaleTween * 0.05 * 2;
draw_sprite_ext(_medalSprite, _medalIndex, _medalx, _medaly, _medalScale, _medalScale, 0, c_white, 1);
_medalSprite = sTrophyCase;
draw_sprite_ext(_medalSprite, _medalIndex, _medalx, _medaly, _medalScale, _medalScale, 0, c_white, 1);
var _getTextScale = 0.25;
textScribble.transform(_getTextScale, _getTextScale, 0).align(1, 1).draw(_medalx, _medaly + 20);
