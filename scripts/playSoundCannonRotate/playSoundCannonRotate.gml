function playSoundCannonRotate()
{
    with (oGimCannon)
    {
        var _cannonRotateHead = playSfxWorld(sfx_cannon_rotate_head);
        var _cannonRotateLoop = playSfxWorld(sfx_cannon_rotate_lp, true, true);
        audioSetInViewOnly(_cannonRotateHead, x, y);
        audioSetInViewOnly(_cannonRotateLoop, x, y);
    }
}
