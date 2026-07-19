var _rectCenter, _rectTop, _rectBottom;

if (rectScale > 0)
{
    var _rectHeightBase = 192;
    var _rectHeight = (_rectHeightBase + 8) * rectScale;
    var _rectWidth = 160;
    var _rectMiddle = global.windowMiddley;
    _rectCenter = global.windowCenterx;
    _rectTop = _rectMiddle - (_rectHeight / 2);
    _rectBottom = _rectMiddle + (_rectHeight / 2);
    var _rectLeft = _rectCenter - (_rectWidth / 2);
    var _rectRight = _rectCenter + (_rectWidth / 2);
    draw_set_color(make_color_rgb(176, 183, 195));
    draw_rectangle(_rectLeft, _rectTop, _rectRight, _rectBottom, 0);
    _rectHeight = _rectHeightBase * rectScale;
    _rectWidth = 160;
    _rectMiddle = global.windowMiddley;
    _rectCenter = global.windowCenterx;
    _rectTop = _rectMiddle - (_rectHeight / 2);
    _rectBottom = _rectMiddle + (_rectHeight / 2);
    _rectLeft = _rectCenter - (_rectWidth / 2);
    _rectRight = _rectCenter + (_rectWidth / 2);
    draw_set_color(make_color_rgb(122, 131, 146));
    draw_rectangle(_rectLeft, _rectTop, _rectRight, _rectBottom, 0);
}

sequenceInit = function(arg0)
{
    if (sequenceInitializedUpTo < arg0)
    {
        sequenceInitializedUpTo = arg0;
        return true;
    }
    else
    {
        return false;
    }
};

sequenceTracker += 0.011111111111111112;

if (sequenceTracker >= 0)
{
    if (sequenceInit(0))
        playSoundPostEndScreenOpen();
    
    rectScale = lerp(rectScale, 1, 0.2);
}

if (sequenceTracker >= 1)
{
    if (sequenceInit(1))
        playSoundPostEndHeaderText();
    
    var _textScale = 0.75;
    scribble("[wave]" + loc("ending post end unlock header")).scale_to_box(200, -1).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 2.5).transform(_textScale, _textScale, 0).align(1, 0).draw(_rectCenter, _rectTop + 4);
}

var _lerpSpeed, _medalTexty;

if (sequenceTracker >= 2)
{
    if (sequenceInit(2))
        playSoundPostEndMedalMenu();
    
    _lerpSpeed = 1;
    medalScale = lerp(medalScale, 1, _lerpSpeed);
    var _textScale = 0.4 * medalScale;
    _medalTexty = _rectTop + 4 + 16 + 8 + 8 + 4;
    scribble(loc("ending post end unlock medal menu")).scale_to_box(280, -1).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 2.5).transform(_textScale, _textScale, 0).align(1, 1).draw(_rectCenter, _medalTexty);
    var _medalSprite = sMedal_clearBy10;
    var _medalIndex = 1;
    var _medalx = _rectCenter;
    var _medaly = _medalTexty + 20;
    var _medalScale = 0.05 * medalScale * 2;
    
    if (!global.achievementTrophyGotList[| UnknownEnum.Value_0])
        _medalIndex = 0;
    
    draw_sprite_ext(_medalSprite, _medalIndex, _medalx, _medaly, _medalScale, _medalScale, 0, c_white, 1);
    _medalSprite = sTrophyCase;
    draw_sprite_ext(_medalSprite, _medalIndex, _medalx, _medaly, _medalScale, _medalScale, 0, c_white, 1);
}

var _sleepingGearTexty;

if (sequenceTracker >= 3)
{
    if (sequenceInit(3))
        playSoundPostEndPajamas();
    
    sleepingGearScale = lerp(sleepingGearScale, 1, _lerpSpeed);
    var _textScale = 0.4 * sleepingGearScale;
    _sleepingGearTexty = _medalTexty + 32 + 16;
    scribble(loc("ending post end unlock sleeping gear")).scale_to_box(280, -1).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 2.5).transform(_textScale, _textScale, 0).align(1, 1).draw(_rectCenter, _sleepingGearTexty);
    var _pajamaAbilityList = array_create(0, -1);
    array_insert(_pajamaAbilityList, 0, global.upgradeIcon[| UnknownEnum.Value_22], global.upgradeIcon[| UnknownEnum.Value_23], global.upgradeIcon[| UnknownEnum.Value_24], global.upgradeIcon[| UnknownEnum.Value_25], global.upgradeIcon[| UnknownEnum.Value_26]);
    var _arraySize = array_length(_pajamaAbilityList);
    var _spriteSpace = 26;
    var _spriteLeftMost = _rectCenter - (_spriteSpace * ((_arraySize - 1) / 2));
    var _spritey = _sleepingGearTexty + 20;
    var _spriteScale = 0.1 * sleepingGearScale;
    
    for (var _i = 0; _i < _arraySize; _i += 1)
    {
        var _spriteIndex = _pajamaAbilityList[_i];
        draw_sprite_ext(_spriteIndex, 0, _spriteLeftMost + (_i * _spriteSpace), _spritey, _spriteScale, _spriteScale, 0, c_white, 1);
    }
}

if (sequenceTracker >= 4)
{
    if (sequenceInit(4))
        playSoundPostEndPajamas();
    
    sleepingGearScale = lerp(sleepingGearScale, 1, _lerpSpeed);
    var _textScale = 0.4 * sleepingGearScale;
    var _leaderboardsUnlockTexty = _sleepingGearTexty + 32 + 16 + 8;
    scribble(loc("leaderboards title")).scale_to_box(280, -1).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 2.5).transform(_textScale, _textScale, 0).align(1, 1).draw(_rectCenter, _leaderboardsUnlockTexty);
}

if (sequenceTracker >= 5)
{
    if (sequenceInit(5))
        playSoundPostEndReturnAppear();
    
    var _textScale = 0.5;
    var _okTexty = _rectBottom - 16;
    var _pillWidth = 64;
    var _pillHeight = 16;
    drawPill(_rectCenter - (_pillWidth / 2), _okTexty - (_pillHeight / 2), _rectCenter + (_pillWidth / 2), _okTexty + (_pillHeight / 2), make_color_rgb(255, 255, 255), 0.5);
    scribble(loc("UI general return")).scale_to_box((_pillWidth - 8) * 2, -1).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 2.5).transform(_textScale, _textScale, 0).align(1, 1).draw(_rectCenter, _okTexty);
    
    if (input_check_pressed("jump") || mouse_check_button_released(mb_left))
        sequenceTracker = -9999;
}

if (sequenceTracker < 0)
{
    if (sequenceInit(6))
        playSoundPostEndScreenClose();
    
    rectScale = lerp(rectScale, -0.1, 0.2);
    rectScale = clamp(rectScale, 0, 1);
    
    if (rectScale <= 0)
    {
        destroyTimer += 1;
        
        if (destroyTimer > 60)
        {
            instance_destroy();
            instance_create_depth(x, y, 0, oResultsScreen);
        }
    }
}
