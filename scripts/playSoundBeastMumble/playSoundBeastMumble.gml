function playSoundBeastMumble()
{
    with (oBeastInLobby)
        var _beastMumbleSound = playSfxWorld(choose(sfx_beast_mumble_01, sfx_beast_mumble_02, sfx_beast_mumble_03, sfx_beast_mumble_04));
}
