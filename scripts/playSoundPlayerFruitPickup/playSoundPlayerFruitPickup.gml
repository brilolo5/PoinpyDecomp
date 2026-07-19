function playSoundPlayerFruitPickup()
{
    with (oPlayer)
    {
        var _fruitGetSound = playSfxWorld(choose(sfx_player_fruit_pickup_01, sfx_player_fruit_pickup_02, sfx_player_fruit_pickup_03, sfx_player_fruit_pickup_04, sfx_player_fruit_pickup_05, sfx_player_fruit_pickup_06));
        audioSetSlowmo(_fruitGetSound);
    }
}
