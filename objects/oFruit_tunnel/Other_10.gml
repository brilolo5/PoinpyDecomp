draw_sprite_ext(sprIndex, 3, x + cx, y + cy, fruitScale, fruitScale, imageAngle, make_color_rgb(176, 183, 195), outlineAlpha);
_time = global.timeScaledTime;
imageAngle = sin(_time / 10) * 10;

if (noWiggle)
    imageAngle = 0;

draw_sprite_ext(sprIndex, image_index, x + cx, y + cy, fruitScale, fruitScale, imageAngle, c_white, image_alpha);
