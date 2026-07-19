myAlarm0 = new makeAlarm(0, function()
{
    if (textboxAppearAnimationTimer >= 1)
    {
        _typeInStart();
    }
    else
    {
        typist.pause();
        myAlarm0.setTimer(1);
    }
});
var _id = id;

with (oDiscoverNewAreaText)
{
    if (id != _id)
        instance_destroy();
}

dialogMusic = -1;
localTime = 0;
beastImageIndex = 0;
beastImageIndexTimer = 0;
beastSurface = -1;
beastAlpha = 0;
textBoxShadowSurface = -1;
textboxAppearAnimationTimer = 0;
textboxAppearAnimationTimerGoal = 1;
fakeRecipeCloudAnimationTimer = 0;
doTheWheel = 1;
textInSpeed = 0.25;
textInSpeed = !locIsAsian() ? (1/3) : 0.25;
textInSmoothness = 5;
textRemainTime = 210;
textOutSpeed = 0.95;
textOutSmoothness = textInSmoothness;
allowNextText = 0;
proceedSignAnimation = 0;
soundArray[0] = sfx_ending_beast_text_01;
array_push(soundArray, sfx_ending_beast_text_02, sfx_ending_beast_text_03, sfx_ending_beast_text_04, sfx_ending_beast_text_05, sfx_ending_beast_text_06, sfx_ending_beast_text_07, sfx_ending_beast_text_08, sfx_ending_beast_text_09, sfx_ending_beast_text_10, sfx_ending_beast_text_11);
typist = scribble_typist();
typist.in(textInSpeed, textInSmoothness).ease(UnknownEnum.Value_2, 0, 1, 1, 1, 0, 0).sound_per_char(soundArray, 0.5, 1.5);
textSize = 0.9;
scrText = scribble("null").starting_format(global.defaultFont, make_color_rgb(255, 255, 255)).line_height(10, 26).transform(textSize / 2, textSize / 2, 0).align(1, 1);

_updateDialogBoxDimentions = function()
{
    dbCenter = global.windowCenterx;
    dbMiddle = global.windowMiddley;
    dbWidth = 170;
    dbHeight = 48;
    var _breatheOffset = 0;
    dbMiddle += _breatheOffset;
    dbLeft = dbCenter - (dbWidth / 2);
    dbRight = dbLeft + dbWidth;
    dbTop = dbMiddle - (dbHeight / 2);
    dbBottom = dbTop + dbHeight;
};

sequenceIndex = "moment before beast appear";
sequenceInit = 1;
sequenceTimer = 0;

_sequenceInitialize = function()
{
    if (sequenceInit)
    {
        sequenceInit = 0;
        return true;
    }
    else
    {
        return false;
    }
};

_drawTextBox = function()
{
    var _offsetVal = 4;
    draw_set_color(getAuroraColor(localTime / 10000));
    draw_set_alpha(1);
    draw_roundrect_ext(dbLeft - _offsetVal, dbTop + _offsetVal, dbRight - _offsetVal, dbBottom + _offsetVal, 8, 8, 0);
    var _outlineWidth = 1;
    draw_set_color(make_color_rgb(176, 183, 195));
    draw_set_alpha(1);
    draw_roundrect_ext(dbLeft - _outlineWidth, dbTop - _outlineWidth, dbRight + _outlineWidth, dbBottom + _outlineWidth, 8, 8, 0);
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_roundrect_ext(dbLeft, dbTop, dbRight, dbBottom, 8, 8, 0);
    draw_set_color(c_black);
    draw_set_alpha(1);
    return true;
};

_drawText = function(arg0 = 0.25)
{
    var _colorCycleValue = 4.25;
    var _waveColorCycleRate = (current_time / 1000 / _colorCycleValue) % 1;
    var _whiteMixRate = 0.5;
    var _waveColor = getAuroraColor(0.8, make_color_rgb(255, 255, 255), _whiteMixRate, _waveColorCycleRate);
    scrText.msdf_shadow(_waveColor, arg0, 0, 0, 0.5).blend(make_color_rgb(46, 50, 59), 1).fit_to_box(dbWidth * 2, (dbHeight * 2) - 8, locIsAsian()).draw(dbCenter, dbMiddle, typist);
};

_clickToSkipOrClearText = function()
{
    if (mouse_check_button_pressed(mb_left))
    {
        if (typist.get_state() == 1 && allowNextText == 1)
        {
            typist.out(3, 1).skip();
            return true;
        }
        else
        {
            typist.in(textInSpeed * 10, textInSmoothness);
            allowNextText = 1;
            return false;
        }
    }
    else
    {
        return false;
    }
};

_nextText = function(arg0)
{
    var __text = arg0;
    
    if (doTheWheel)
        __text = "[wheel]" + arg0;
    
    scrText.overwrite(__text);
    myAlarm0.setTimer(10);
};

_drawProceedSign = function()
{
    if (typist.get_state() == 1)
        allowNextText = approach(allowNextText, 1, doDelta(0.08333333333333333));
    
    if (typist.get_state() == 1 && allowNextText == 1)
    {
        var _signPosy = dbBottom + 1;
        var _signSizeOut = 4;
        var _signSizeIn = _signSizeOut - 1;
        proceedSignAnimation = approach(proceedSignAnimation, 1, doDelta(0.05555555555555555));
        var _procSignScale = 1.2 - (0.2 * animcurveGetValueAtPos(curveBackInv, "curve1", proceedSignAnimation));
        draw_set_color(make_color_rgb(69, 80, 97));
        draw_circle(dbCenter, _signPosy, _signSizeOut * _procSignScale, 0);
        draw_set_color(c_white);
        draw_circle(dbCenter, _signPosy, _signSizeIn * _procSignScale, 0);
        return true;
    }
    else
    {
        proceedSignAnimation = 0;
        return false;
    }
};

_typeInStart = function()
{
    typist.unpause().in(textInSpeed, textInSmoothness).ease(UnknownEnum.Value_2, 0, 1, 1, 1, 0, 0);
    
    if (!doTheWheel)
        typist.ease(UnknownEnum.Value_2, 0, 0, 1, 1, 0, 0);
    
    allowNextText = 0;
};

_nextSequence = function(arg0)
{
    sequenceIndex = arg0;
    sequenceInit = 1;
    sequenceTimer = 0;
};

_sequenceTimerIncrementAndCheck = function(arg0)
{
    sequenceTimer += doDelta(1 / arg0);
    return sequenceTimer >= 1;
};
