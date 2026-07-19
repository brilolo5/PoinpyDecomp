vspeed = vsp * global.timeScale;

if (y < (getViewy(global.cam) - 160))
    instance_destroy();

image_index += (global.timeScale * 0.25);
var _viewCenter = getViewx(global.cam) + (global.viewWidth / 2);
drawSpriteSetSize(sprite_index, image_index, _viewCenter, y, global.viewWidth, sprite_get_height(sprite_index));
