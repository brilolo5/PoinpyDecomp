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

if (abilityCheck(UnknownEnum.Value_22))
{
    var _drawAverageList = true;
    var _drawAverageValue = true;
    var _drawBestAverageList = true;
    var _drawBestAverageValue = true;
    var _drawHighScore = true;
    var _averageScoreOffsetY = 0;
    var _pauseMenuExists = instance_exists(oPauseMenu);
    
    switch (room)
    {
        case rmMainGame:
            var _inGameOrPauseMenu = _pauseMenuExists || !global.mainGamePaused;
            _drawAverageList = _inGameOrPauseMenu;
            _drawAverageValue = _inGameOrPauseMenu;
            _drawBestAverageList = _pauseMenuExists;
            _drawBestAverageValue = _inGameOrPauseMenu;
            _drawHighScore = _inGameOrPauseMenu;
            break;
        
        case rmPlayableMainMenu:
            _inGameOrPauseMenu = _pauseMenuExists || !global.mainGamePaused;
            _drawAverageList = _pauseMenuExists;
            _drawAverageValue = _pauseMenuExists;
            _drawBestAverageList = _pauseMenuExists;
            _drawBestAverageValue = _pauseMenuExists;
            _drawHighScore = _inGameOrPauseMenu;
            break;
        
        default:
            _drawAverageList = false;
            _drawAverageValue = false;
            _drawBestAverageList = false;
            _drawBestAverageValue = false;
            _drawHighScore = false;
            break;
    }
    
    var _freeTexty = global.windowBottom - 2 - 10;
    var _freeTextScale = 0.375;
    var _averageListTextScale = 0.425;
    var _spaceBetweenNumberAndText = 1.5;
    var _averageListWidth = 85;
    var _averageListLeft = global.windowCenterx - (_averageListWidth / 2);
    _averageListLeft = global.windowRight - _averageListWidth - 12;
    var _averageListSpace = _averageListWidth / 4;
    _averageListSpace = _averageListWidth / 3;
    var _averageListDrawy = (global.windowBottom - 2 - (5 * sign(global.notchOffset)) - 6) + _averageScoreOffsetY;
    var _averageListRight = _averageListLeft + (_averageListSpace * 3);
    var _averageListOffsetx = -averageListScrollScaler * _averageListSpace;
    var _averageListLeft_final = _averageListLeft + _averageListOffsetx;
    var _averageValueTextLeft = global.windowLeft + 4;
    var _averageValueTextRight = global.windowRight - 4;
    var _averageValueTexty = _averageListDrawy - 8 - 2;
    var _averageValueTextScale = 1.1;
    var _mainValueTextScale = 0.6 * _averageValueTextScale;
    var _elementTitleTextScale = 0.3 * _averageValueTextScale;
    averageListScrollScaler = lerp(averageListScrollScaler, 0, 0.075);
    var _averageNA = 0;
    drawSetAlign(1, 2);
    
    if (_drawAverageList)
    {
        for (var i = 0; i < 4; i += 1)
        {
            var _value = array_get(global.endlessAverageList_current, global.endlessMode)[| i];
            
            if (_value <= 0)
            {
                _value = "-";
                _averageNA = 1;
            }
            
            var _valuex = _averageListLeft_final + (_averageListSpace * i);
            var _pillWidth = 20;
            var _pillHeight = 12;
            var _pillLeft = _valuex - (_pillWidth / 2);
            var _pillRight = _valuex + (_pillWidth / 2);
            var _pillTop = _averageListDrawy - (_pillHeight / 2);
            var _pillBottom = _averageListDrawy + (_pillHeight / 2);
            drawPill(_pillLeft, _pillTop, _pillRight, _pillBottom, make_color_rgb(255, 255, 255), 0.75);
            var _textScale = 0.375;
            scribble(_value).starting_format(locGetNumFont(), make_color_rgb(255, 255, 255)).blend(16777215, 1).line_height(10, 26).msdf_border(make_color_rgb(46, 50, 59), 2.5).transform(_averageListTextScale, _averageListTextScale, 0).align(1, 1).draw(_valuex, _averageListDrawy);
        }
    }
    
    if (_drawBestAverageList)
    {
        var _bestAverageListDrawy = _averageListDrawy - 16 - 4 - 4;
        
        for (var i = 0; i < 4; i += 1)
        {
            var _value = array_get(global.endlessAverageList_best, global.endlessMode)[| i];
            
            if (_value <= 0)
            {
                _value = "-";
                _averageNA = 1;
            }
            
            var _valuex = _averageListLeft_final + (_averageListSpace * i);
            var _pillWidth = 18;
            var _pillHeight = 10;
            var _pillLeft = _valuex - (_pillWidth / 2);
            var _pillRight = _valuex + (_pillWidth / 2);
            var _pillTop = _bestAverageListDrawy - (_pillHeight / 2);
            var _pillBottom = _bestAverageListDrawy + (_pillHeight / 2);
            drawPill(_pillLeft, _pillTop, _pillRight, _pillBottom, make_color_rgb(255, 255, 255), 0.75);
            _averageListTextScale = 0.35;
            scribble(_value).starting_format(locGetNumFont(), make_color_rgb(255, 255, 255)).blend(make_color_rgb(255, 238, 96), 1).line_height(10, 26).msdf_border(make_color_rgb(46, 50, 59), 2.5).transform(_averageListTextScale, _averageListTextScale, 0).align(1, 1).draw(_valuex, _bestAverageListDrawy);
        }
    }
    
    var _averageValue = meanFromList(global.endlessAverageList_current[global.endlessMode], 4);
    
    if (_averageNA)
    {
        _averageValue = "-";
    }
    else
    {
        averageScoreTweenGoal = _averageValue;
        averageScoreTween = lerp(averageScoreTweenPrevious, averageScoreTweenGoal, 1 - averageScoreTweenScaler);
        averageScoreTweenScaler = approach(averageScoreTweenScaler, 0, 0.016666666666666666);
        _averageValue = string_format(averageScoreTween, 2, 1);
    }
    
    var _averageList_best = global.endlessAverageList_best[global.endlessMode];
    var _averageValue_best = meanFromList(_averageList_best, 4);
    _averageValue_best = string_format(_averageValue_best, 2, 1);
    
    if (_averageValue_best <= 0)
        _averageValue_best = "-";
    
    var _averageTextx = _averageListLeft - 6;
    var _averageTexty = _averageListDrawy - 16 - 4 - 6;
    
    if (_drawAverageValue)
    {
        scribble(_averageValue).starting_format(locGetNumFont(), make_color_rgb(255, 255, 255)).blend(16777215, 1).line_height(10, 26).msdf_border(make_color_rgb(46, 50, 59), 2.5).transform(_mainValueTextScale, _mainValueTextScale, 0).align(0, 0).draw(_averageValueTextLeft, _averageValueTexty);
        var _averageText = loc("main game UI average");
        scribble(_averageText).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).blend(16777215, 1).line_height(10, 26).msdf_border(make_color_rgb(46, 50, 59), 2.5).transform(_elementTitleTextScale, _elementTitleTextScale, 0).align(0, 2).draw(_averageValueTextLeft, _averageValueTexty + _spaceBetweenNumberAndText);
    }
    
    if (_drawBestAverageValue)
    {
        _averageTextx = _averageListRight + 6;
        var _averageText = loc("main game UI best average");
        var _halign = 0;
        _averageValueTextRight = global.windowLeft + 4;
        _averageValueTexty = (((((global.windowTop + 32 + 64) - 20 - 10) + 180 + 20 + 32 + 10) - 5) + 10) - 2 - 2;
        _averageValueTexty = global.windowBottom - 32 - 5;
        _averageValueTexty = (_averageListDrawy - 32) + 3;
        var _miniScale = 0.6;
        scribble(_averageValue_best).starting_format(locGetNumFont(), make_color_rgb(255, 255, 255)).blend(16777215, 1).line_height(10, 26).msdf_border(make_color_rgb(46, 50, 59), 2.5).transform(_mainValueTextScale * _miniScale, _mainValueTextScale * _miniScale, 0).align(_halign, 0).draw(_averageValueTextRight, _averageValueTexty);
        scribble(_averageText).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).blend(16777215, 1).line_height(10, 26).msdf_border(make_color_rgb(46, 50, 59), 2.5).transform(_elementTitleTextScale * _miniScale, _elementTitleTextScale * _miniScale, 0).align(_halign, 2).draw(_averageValueTextRight, (_averageValueTexty + _spaceBetweenNumberAndText) - 1);
    }
    
    if (_drawHighScore)
    {
        var _mode = getEndlessMode();
        var _endlessScore = global.endlessHighScore[_mode];
        var _bestScoreTextx = global.windowLeft + 4;
        var _bestScoreTexty = (_hpPosy + 8 + 2 + 2 + 2 + 2) - 8;
        var _bestScoreText = loc("main game UI highscore");
        scribble(_endlessScore).starting_format(locGetNumFont(), make_color_rgb(255, 255, 255)).blend(16777215, 1).line_height(10, 26).msdf_border(make_color_rgb(46, 50, 59), 2.5).transform(_mainValueTextScale, _mainValueTextScale, 0).align(0, 0).draw(_bestScoreTextx, _bestScoreTexty + 9);
        scribble(_bestScoreText).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).blend(16777215, 1).line_height(10, 26).msdf_border(make_color_rgb(46, 50, 59), 2.5).transform(_elementTitleTextScale, _elementTitleTextScale, 0).align(0, 2).draw(_bestScoreTextx, _bestScoreTexty + _spaceBetweenNumberAndText);
        var _jumpCountTop = _bestScoreTexty + 6;
        var _jumpCountx = _bestScoreTextx;
        var _jumpCategory = getMaxJump();
        var _jumpCountString = locGetNumFont(true) + string(_jumpCategory);
        var _orbSize = 12;
        drawSpriteSetSize(sJumpCounts00, 0, _jumpCountx + 2, _jumpCountTop, _orbSize, _orbSize);
        drawSetAlign(0, 1);
        drawTextOutlined(_jumpCountx + 6, _jumpCountTop, _jumpCountString, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 0.7);
    }
}
