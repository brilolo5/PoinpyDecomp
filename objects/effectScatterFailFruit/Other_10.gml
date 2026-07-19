var gts = global.timeScale;
var _draw = 1;
startBlinkingAfter -= gts;
destroyAfter -= gts;

if (startBlinkingAfter <= 0)
{
    var _time = round(abs(startBlinkingAfter) * 0.2);
    
    if ((_time % 2) == 0)
        _draw = 0;
}

if (destroyAfter <= 0)
    instance_destroy();

if (_draw)
    draw_sprite_ext(sprite_index, image_index, x + cx, y + cy, xscale, yscale, imageAngle, c_white, 1);
