draw_sprite_ext(sprite_index, image_index, x + dcx, y + dcy, xscale, yscale, imageAngle * xDirection, c_white, 1);

if (instance_exists(myFruitInstance))
{
    with (myFruitInstance)
        event_user(0);
}
