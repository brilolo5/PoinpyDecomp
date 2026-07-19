function areaFlowerSway()
{
    var _offset = x / 2;
    var _time = global.timeScaledTime + _offset;
    var _swayAngle = sin(_time / 25) * 5;
    draw_sprite_ext(spriteIndex, imageIndex, x, y, 0.1 * image_xscale, 0.1 * image_yscale, _swayAngle, c_white, 1);
}
