var _wCenter = global.windowCenterx;
var _wMiddle = global.windowMiddley;
var _wLeft = global.windowLeft;
var _wRight = global.windowRight;
var _wTop = global.windowTop + 3;
var _wBottom = global.windowBottom;
var viewx = getViewx(global.cam);
var xcenter = global.windowCenterx;
var xLeft = xcenter - ((global.viewWidth / 4) + 5);
var xRight = xcenter + ((global.viewWidth / 4) + 4);
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
drawSetAlign(1, 1);
var _walletUIposx_goal = global.windowLeft - 32;

if (walletUIappearTime > 0)
{
    _walletUIposx_goal = global.windowLeft + 16 + 3;
    walletUIappearTime -= 1;
}

walletUIposx = lerp(walletUIposx, _walletUIposx_goal, 0.2);
walletWobble = approach(walletWobble, 0, 1/3);
var _walletScale = 0.8;
var _wobbleAmount = walletWobble * 2;
walletUIposy = global.windowMiddley + (global.viewHeight / 3);
var _moneyUISpritePosx = walletUIposx;
var _moneyUISpritePosy = walletUIposy + _wobbleAmount;

if (room == rmPlayableMainMenu)
{
    if (global.juicerRankProgress <= 0)
        _moneyUISpritePosx = 9000;
    
    _walletScale = 1.25;
    
    if (instance_exists(oCamera))
    {
        if (oCamera.playerHorizontalFrameNum == -1 && !instance_exists(oShopMenu))
            walletUIappearTime = 3;
    }
}

moneyTextScale = approach(moneyTextScale, 1, doDelta(0.025));
_walletScale = 1.25;
var _moneyUITextMainPosx = _moneyUISpritePosx;
var _moneyUITextMainPosy = (_moneyUISpritePosy + 6) - 2 - 1;
var _moneyUITextSubPosx = _moneyUITextMainPosx;
var _moneyUITextSubPosy = _moneyUITextMainPosy;
var _fruitUISpritePosx = _moneyUISpritePosx;
var _fruitUISpritePosy = _moneyUISpritePosy + 14;
var _fruitUITextMainPosx = _fruitUISpritePosx + 12;
var _fruitUITextMainPosy = _fruitUISpritePosy + 2;
_moneyUITextMainPosy += moneyUITextPosShake;

if (!moneyAmountCountUpDelay)
{
    if (moneyAmount_tween != shownMoneyAmount)
    {
        var _clampMax = 60;
        moneyTextScale = 1.1;
        moneyAmount_tween = clamp(moneyAmount_tween, shownMoneyAmount - _clampMax, shownMoneyAmount + _clampMax);
        moneyAmount_tween = approach(moneyAmount_tween, shownMoneyAmount, 1);
    }
}
else
{
    moneyAmountCountUpDelay -= doDelta(1);
}

var _moneyTextMain = moneyAmount_tween;
var _moneyTextMainSize = 0.7 * _walletScale;
var _moneyTextSub = "/ " + string(global.walletMax);
var _moneyTextSubSize = 0.75;
var _moneyTextMainLength = stringWidth(_moneyTextMain, _moneyTextMainSize) + 4;

if (!instance_exists(oAbilityEquipMenu) && !instance_exists(oPuzzleMenu) && !instance_exists(oLeaderboardsMenu) && !instance_exists(oEndCredit))
{
    var _seedScale = 0.06 * (_walletScale / 1 / 10);
    var _seedx = _moneyUISpritePosx;
    _moneyUITextMainPosx = _seedx;
    var _moneytext = string(_moneyTextMain);
    _moneyTextMainSize *= (0.35 * moneyTextScale);
    walletTextElement = scribble(_moneytext).scale_to_box(42, -1).starting_format(locGetNumFont(), make_color_rgb(255, 255, 255)).blend(16777215, 1).msdf_border(make_color_rgb(46, 50, 59), 4).transform(_moneyTextMainSize, _moneyTextMainSize, 0).align(1, 1);
    var _walletTextBbox = walletTextElement.get_bbox(_moneyUISpritePosx, _moneyUISpritePosy);
    var _walletTextLeft = _walletTextBbox.left;
    var _walletPillWidth = 28;
    var _walletPillHeight = 12;
    var _walletPillLeft = _moneyUISpritePosx - (_walletPillWidth / 2);
    var _walletPillRight = _moneyUISpritePosx + (_walletPillWidth / 2);
    var _walletPillTop = _moneyUISpritePosy - (_walletPillHeight / 2);
    var _walletPillBottom = _walletPillTop + _walletPillHeight;
    var _pillColor = make_color_rgb(255, 238, 96);
    
    if (walletWobble > 0.5)
        _pillColor = make_color_rgb(255, 255, 255);
    
    drawPillWithOutline(_walletPillLeft, _walletPillTop, _walletPillRight, _walletPillBottom, _pillColor, make_color_rgb(46, 50, 59), 0.7);
    walletTextElement.draw(_moneyUISpritePosx + 2, _moneyUISpritePosy);
    _seedScale = 0.05;
    draw_sprite_ext(sGoldenSeedUI, 1, _walletTextLeft - 3.5, _moneyUISpritePosy + 0.25, _seedScale, _seedScale, 0, c_white, 1);
    moneyUITextPosShake = approach(moneyUITextPosShake, 0, 1);
    
    walletChange = function(arg0)
    {
        walletChangeTextAmount = arg0;
        walletChangeTextDrawTimer = 180;
        walletChangeTextOffsety = 4;
    };
    
    if (walletChangeTextDrawTimer > 0)
    {
        var _walletChangeTextString = string(walletChangeTextAmount);
        
        if (walletChangeTextAmount > 0)
            _walletChangeTextString = "+" + _walletChangeTextString;
        
        walletChangeTextDrawTimer -= doDelta(1);
        walletChangeTextOffsety = approach(walletChangeTextOffsety, 0, doDelta(1));
        var _walletChangeTextSize = 0.3;
        var _walletChangeTextColor = make_color_rgb(255, 255, 255);
        
        if (walletChangeTextAmount < 0)
            _walletChangeTextColor = make_color_rgb(248, 45, 97);
        
        walletChangeTextElement = scribble(_walletChangeTextString).scale_to_box(42, -1).starting_format(locGetNumFont(), _walletChangeTextColor).blend(16777215, 1).msdf_border(make_color_rgb(46, 50, 59), 4).transform(_walletChangeTextSize, _walletChangeTextSize, 0).align(1, 1).draw(_moneyUISpritePosx + 2, (_moneyUISpritePosy - 8 - 4 - _wobbleAmount) + walletChangeTextOffsety);
    }
    else
    {
        walletChangeTextOffsety = 4;
        walletChangeTextAmount = 0;
    }
}
