if (playerVisible)
{
    comboUI_x = deltaLerp(comboUI_x, x + dcx, 0.3 * global.timeScale_noDelta);
    comboUI_y = deltaLerp(comboUI_y, y + dcy, 0.5 * global.timeScale_noDelta);
    playerDrawComboUI(comboUI_x, comboUI_y);
    
    if (!getPlayerControlLock())
        playerDrawJumpUI(x + dcx, y + dcy);
}
