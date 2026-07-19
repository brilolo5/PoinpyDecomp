function playSoundTutorialGuySpeakLoop()
{
    with (oPlayer)
    {
        var _tutorialGuySpeechSound = playSfxWorld(sfx_tutorial_guy_speech_text_lp, true);
        var _tutorialGuySpeechBubbleAppear = playSfxWorld(sfx_tutorial_guy_speechBubble_in);
    }
}
