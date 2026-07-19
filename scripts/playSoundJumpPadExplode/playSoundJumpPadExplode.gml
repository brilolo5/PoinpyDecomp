function playSoundJumpPadExplode()
{
    with (oPlayer)
        var _jumpPadExplodeSound = playSfxWorld(choose(sfx_jumpPad_launch_01, sfx_jumpPad_launch_02, sfx_jumpPad_launch_03, sfx_jumpPad_launch_04, sfx_jumpPad_launch_05));
}
