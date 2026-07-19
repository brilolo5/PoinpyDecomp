var gts = global.timeScale;
var _draw = 1;
spinSpeed = approach(spinSpeed, 0, spinFriction);
imageAngle += (spinSpeed * gts);
startBlinkingAfter -= gts;
destroyAfter -= gts;

if (startBlinkingAfter <= 0)
{
    var _blinkRate = 2;
    var _time = round(abs(global.time) * (_blinkRate / 10));
    
    if ((_time % _blinkRate) == 0)
        _draw = 0;
}

if (destroyAfter <= 0 && (startBlinkingAfter == destroyAfter || !_draw))
    instance_destroy();

if (animationSpeed > 0)
{
    image_index += (animationSpeed * gts);
    
    if (image_index >= (image_number - 1) && destroyAfterAnimation)
        instance_destroy();
}

if (_draw)
    draw_sprite_ext(sprite_index, image_index, x + cx, y + cy, xscale, yscale, imageAngle * xDirection, color, 1);
