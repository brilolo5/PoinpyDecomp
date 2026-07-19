function playSoundTutorialGuyEatEnd()
{
    with (oPlayer)
    {
        var _tutorialGuyEatStopSound = playSfxWorld(sfx_tutorial_guy_eat_tail);
        audioSystemStopAsset(sfx_tutorial_guy_eat_lp);
    }
}
