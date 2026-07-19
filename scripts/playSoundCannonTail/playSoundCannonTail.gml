function playSoundCannonTail()
{
    with (oGimCannon)
    {
        var _cannonTailSound = playSfxWorld(sfx_cannon_rotate_tail);
        audioSetInViewOnly(_cannonTailSound, x, y);
    }
}
