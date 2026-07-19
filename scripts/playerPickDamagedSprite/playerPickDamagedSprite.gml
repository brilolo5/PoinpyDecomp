function playerPickDamagedSprite()
{
    with (oPlayer)
    {
        image_index = choose(0, 1, 2);
        image_speed = 0;
    }
}

function playerPickSleepSprite()
{
    with (oPlayer)
    {
        randomize();
        image_index = irandom(sprite_get_number(sPlayerGroundAsleep));
        image_speed = 0;
    }
}

function playerPickPuzzleChairSprite()
{
    with (oPlayer)
    {
        randomize();
        image_index = irandom(sprite_get_number(sPlayerGroundPuzzleChair));
        image_index = 2;
        image_speed = 0;
    }
}
