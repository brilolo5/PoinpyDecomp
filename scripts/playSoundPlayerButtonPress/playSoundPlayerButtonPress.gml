function playSoundPlayerButtonPress()
{
    with (oPlayer)
    {
        var _buttonPressSound = playSfxWorld(sfx_button_press);
        audioSetSlowmo(_buttonPressSound);
    }
}
