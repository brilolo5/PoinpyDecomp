function playSoundCannonLaunch()
{
    with (oGimCannon)
        var _cannonLaunchSound = playSfxWorld(choose(sfx_cannon_launch_01, sfx_cannon_launch_02, sfx_cannon_launch_03, sfx_cannon_launch_04));
}
