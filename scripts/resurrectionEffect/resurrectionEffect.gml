function resurrectionEffect(arg0)
{
    if (instance_exists(oPlayer))
    {
        with (instance_create_depth(oPlayer.x, oPlayer.y, 0, effectResurrection))
            sprite_index = arg0;
    }
}
