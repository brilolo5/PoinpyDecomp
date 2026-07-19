var _screenLeft = global.windowLeft;
var _screenRight = global.windowRight;
var _screenCenter = global.windowCenterx;
var _screenTop = global.windowTop;
var _screenBottom = global.windowBottom;
var _screenMiddle = global.windowMiddley;
var _forceSkip = mouse_check_button_pressed(mb_right);

if (_forceSkip && global.debugControl)
    currentSequence = "fade";

guide.x = global.windowCenterx;
guide.y = global.windowMiddley - (global.windowMiddley / 2);
guide.drawx = guide.x;
guide.drawy = guide.y;

function drawFingerGuide()
{
    var _spr = guide.sprite;
    
    if (isGamepadEnabled())
        _spr = guide.gamepadSprite;
    
    draw_sprite_ext(_spr, guide.frame, guide.drawx, guide.drawy, guide.scale, guide.scale, 0, c_white, guide.alpha);
}

function drawGuideText()
{
    var _str = guide.string;
    
    if (isGamepadEnabled())
        _str = guide.gamepadString;
    
    scribble(_str).starting_format(global.defaultFont, make_color_rgb(255, 255, 255)).blend(make_color_rgb(255, 255, 255), guide.alpha).msdf_border(make_color_rgb(46, 50, 59), 3).wrap(300, -1, locIsAsian()).transform(0.4, 0.4, 0).align(1, 1).draw(guide.drawx, guide.drawy + 32 + 8);
}

switch (currentSequence)
{
    case "appear":
        guide.alpha = deltaLerp(guide.alpha, 1, 0.025);
        
        if (guide.alpha > 0.95)
            guide.frame += doDelta(0.175);
        
        guide.drawy = guide.y + (-guide.yTweenOffset * guide.alpha);
        drawFingerGuide();
        drawGuideText();
        break;
    
    case "fade":
        guide.frame += doDelta(0.175);
        guide.alpha = approach(guide.alpha, 0, doDelta(0.016666666666666666));
        
        if (guide.alpha <= 0)
            instance_destroy();
        
        guide.drawy = guide.y + (-guide.yTweenOffset * 1) + (-guide.yTweenOffset * (1 - guide.alpha));
        drawFingerGuide();
        drawGuideText();
        break;
}
