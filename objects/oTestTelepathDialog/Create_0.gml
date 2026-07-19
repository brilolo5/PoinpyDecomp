var _id = id;

with (oDiscoverNewAreaText)
{
    if (id != _id)
        instance_destroy();
}

endText[UnknownEnum.Value_0] = "POINPY...";
endText[UnknownEnum.Value_1] = "THANKS FOR THE FRUIT JUICE...\n\nI AM SO FULL!";
endText[UnknownEnum.Value_2] = "YOU HAVE TAKEN SUCH GOOD CARE OF ME,";
endText[UnknownEnum.Value_3] = "AS YOU ALWAYS HAVE...";
endText[UnknownEnum.Value_4] = "...";
endText[UnknownEnum.Value_5] = "YOU MAY FORGET THIS MOMENT SOON,";
endText[UnknownEnum.Value_6] = "BUT WHILE I CAN STILL SPEAK, I JUST WANTED TO SAY";
endText[UnknownEnum.Value_7] = "I LOVE YOU!";
endText[UnknownEnum.Value_8] = "...";
endText[UnknownEnum.Value_9] = "NOW WE MUST BID FAREWELL";
endText[UnknownEnum.Value_10] = "BUT WE WON'T BE APART FOR LONG";
endText[UnknownEnum.Value_11] = "SEE YOU SOON, POINPY!";
textInSpeed = 0.25;
textInSmoothness = 5;
textRemainTime = 210;
textOutSpeed = 0.95;
textOutSmoothness = textInSmoothness;
whisper[0] = "Poinpy...";
whisper[1] = "Poinpy...\n\nThanks for the juice!";
typist = scribble_typist();
typist.in(textInSpeed, textInSmoothness).ease(UnknownEnum.Value_2, 0, 1, 1, 1, 0, 0);
textSize = 0.9;
scrText = scribble(whisper[1]).starting_format(global.defaultFont, make_color_rgb(255, 255, 255)).line_height(10, 26).msdf_shadow(make_color_rgb(46, 50, 59), 0.1, 2, 2).transform(textSize / 2, textSize / 2, 0).align(1, 1);

_updateDialogBoxDimentions = function()
{
    dbCenter = global.windowCenterx;
    dbMiddle = global.windowMiddley;
    dbWidth = 130;
    dbHeight = 56;
    dbLeft = dbCenter - (dbWidth / 2);
    dbRight = dbLeft + dbWidth;
    dbTop = dbMiddle - (dbHeight / 2);
    dbBottom = dbTop + dbHeight;
};

sequenceIndex = "name call";
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
    draw_set_color(make_color_rgb(36, 145, 249));
    draw_set_alpha(0.7);
    draw_roundrect_ext(dbLeft, dbTop, dbRight, dbBottom, 8, 8, 0);
    draw_set_color(c_black);
    draw_set_alpha(1);
    return true;
};

_drawText = function()
{
    scrText.msdf_shadow(0, 0.3, 0, 0, 0.25).blend(16777215, 1).fit_to_box(dbWidth * 2, (dbHeight * 2) - 8, locIsAsian()).draw(dbCenter, dbMiddle, typist);
};

_clickToSkipOrClearText = function()
{
    if (mouse_check_button_pressed(mb_left))
    {
        if (typist.get_state() >= 1)
            typist.out(3, 1).skip();
        else
            typist.in(textInSpeed * 10, textInSmoothness);
    }
};

_nextText = function(arg0)
{
    scrText.overwrite("[wheel]" + arg0);
};

_drawProceedSign = function()
{
    if (typist.get_state() >= 1)
    {
        draw_set_color(make_color_rgb(46, 50, 59));
        draw_circle(dbCenter, dbBottom, 5, 0);
        draw_set_color(c_white);
        draw_circle(dbCenter, dbBottom, 4, 0);
    }
};

_typeInStart = function()
{
    typist.in(textInSpeed, textInSmoothness).ease(UnknownEnum.Value_2, 0, 1, 1, 1, 0, 0);
};

_nextSequence = function(arg0)
{
    sequenceIndex = arg0;
    sequenceInit = 1;
    sequenceTimer = 0;
};
