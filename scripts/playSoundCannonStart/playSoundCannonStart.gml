function playSoundCannonStart()
{
    with (oGimCannon)
    {
        var _cannonStartSound = playSfxWorld(choose(sfx_cannon_start_01, sfx_cannon_start_02, sfx_cannon_start_03, sfx_cannon_start_04));
        audioSetInViewOnly(_cannonStartSound, x, y);
    }
}
