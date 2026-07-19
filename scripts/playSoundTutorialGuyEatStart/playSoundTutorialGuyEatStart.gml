function playSoundTutorialGuyEatStart()
{
    with (oPlayer)
    {
        var _tutorialGuyEatStartSound = playSfxWorld(sfx_tutorial_guy_eat_head);
        var _tutorialGuyEatLoopSound = playSfxWorld(sfx_tutorial_guy_eat_lp, true);
    }
}
