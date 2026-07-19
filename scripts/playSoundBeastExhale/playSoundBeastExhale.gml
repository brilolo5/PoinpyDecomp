function playSoundBeastExhale()
{
    with (oBeastInLobby)
        var _beastExhaleSound = playSfxWorld(choose(sfx_beast_breath_in_01_V2, sfx_beast_breath_in_02_V2, sfx_beast_breath_in_03_V2, sfx_beast_breath_in_04_V2));
}
