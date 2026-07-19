function playSoundButtonPressSpawnLevel()
{
    with (oPlayer)
    {
        var _buttonPressSpawnLevelSound = playSfxWorld(sfx_button_press_spawnLevel);
        audioSetSlowmo(_buttonPressSpawnLevelSound);
    }
}
