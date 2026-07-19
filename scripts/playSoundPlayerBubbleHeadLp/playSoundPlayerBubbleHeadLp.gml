function playSoundPlayerBubbleHeadLp()
{
    with (oPlayer)
    {
        var _bubbleHead = playSfxWorld(sfx_bubble_head);
        audioSetSlowmo(_bubbleHead);
    }
}
