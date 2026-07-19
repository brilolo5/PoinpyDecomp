function playSoundTutorialGuySpeakBubbleDisappear()
{
    with (oPlayer)
    {
        var _tutorialGuySpeechBubbleDisappearSound = playSfxWorld(sfx_tutorial_guy_speechBubble_out);
        audioSystemStopAsset(sfx_tutorial_guy_speech_text_lp);
    }
}
