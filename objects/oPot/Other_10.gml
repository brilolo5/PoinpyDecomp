draw_sprite_ext(sprite_index, 0, x, y, 0.1, 0.1, 0, c_white, 1);

if (instance_exists(myFruit))
{
    with (myFruit)
        draw_sprite_ext(sprIndex, 2, x + cx, y + cy, fruitScale, fruitScale, imageAngle, c_white, 1);
}
