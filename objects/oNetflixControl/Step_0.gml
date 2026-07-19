if (live_call())
    return global.live_result;

if (!global.netflixEnabled)
    exit;

if (room == rmPlayableMainMenu && ((global.mainGamePaused != 1 && !getPlayerControlLock() && !instance_exists(oEndCredit) && !instance_exists(oTE_thoughtBubbleOpen) && global.tutorialOver >= 1) || instance_exists(oPauseMenu)))
{
    if (!global.allowNetflixButton)
    {
        NetflixCheckUserAuth();
        NetflixShowMenu();
    }
    
    global.allowNetflixButton = true;
}
else if (room == rmTutorialMovement2 && (instance_exists(oPauseMenu) || tutorial_allowNButtonAtStart))
{
    if (!global.allowNetflixButton)
    {
        NetflixCheckUserAuth();
        NetflixShowMenu();
    }
    
    global.allowNetflixButton = true;
}
else if (room == rmMainGame && instance_exists(oPauseMenu))
{
    if (!global.allowNetflixButton)
    {
        NetflixCheckUserAuth();
        NetflixShowMenu();
    }
    
    global.allowNetflixButton = true;
}
else
{
    if (global.allowNetflixButton)
        NetflixHideMenu();
    
    global.allowNetflixButton = false;
}
