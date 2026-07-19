_time = global.timeScaledTime;

if (golden)
{
    _time /= 2;
    var _glowRadius = 0.1 * (sin(_time / 5) * 0.5);
    var _goldenOutlineScale = fruitScale * (1.3 + _glowRadius);
    draw_sprite_ext(sprIndex, 3, x + cx, y + cy, _goldenOutlineScale, _goldenOutlineScale, imageAngle, make_color_rgb(249, 221, 40), image_alpha);
    _goldenOutlineScale = fruitScale * 1;
    draw_sprite_ext(sprIndex, 3, x + cx, y + cy, _goldenOutlineScale, _goldenOutlineScale, imageAngle, c_white, image_alpha);
}

imageAngle = sin(_time / 10) * 10;
draw_sprite_ext(sprIndex, image_index, x + cx, y + cy, fruitScale, fruitScale, imageAngle, c_white, image_alpha);
