if (input_check_pressed("select"))
    diagboxTextFadeOut(diagbox);

if (diagboxTextFadedOut(diagbox))
{
    var _str = choose("I'm the player character", "Hello there!");
    diagboxSetText(diagbox, _str, 1/3);
    diagboxFloat(diagbox, 0, -8);
}

diagboxSetKnobTarget(diagbox, roomXToGui(oPlayer.x), roomYToGui(oPlayer.y) - 16);
diagboxSetLimits(diagbox, global.windowLeft + 15, global.windowTop + 20, global.windowRight - 15, global.windowBottom - 15);
draw_set_colour(c_white);
diagboxDraw(diagbox, 1);
diagboxTick(diagbox);
