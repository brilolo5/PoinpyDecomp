input_tick();
input_hotswap_tick();
diagboxTick(diagbox);

if (input_check_pressed("select"))
{
    if (diagboxTextFadedIn(diagbox))
    {
        dialogueIndex = (dialogueIndex + 1) % array_length(dialogueArray);
        diagboxSetText(diagbox, dialogueArray[dialogueIndex]);
    }
    else
    {
        diagboxTextSkip(diagbox);
    }
}

diagboxSetKnobTarget(diagbox, mouse_x, mouse_y);

if (mouse_check_button_pressed(mb_middle))
    diagbox.knobShow = !diagbox.knobShow;

if (mouse_check_button_pressed(mb_right))
{
    if (diagboxIsFloating(diagbox))
        diagboxLock(diagbox, room_width / 2, room_height);
    else
        diagboxFloat(diagbox, 0, -30);
}
