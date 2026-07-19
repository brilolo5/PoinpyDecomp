myAlarm0.tick();
effectProgress += doDelta(1 / effectDuration);
var _viewx = getViewx(global.cam);
var _viewy = getViewy(global.cam);
imageIndex += doDelta(0.3);
var _imgIndex = imageIndex;
var _scale = 0.4;
var _posx = _viewx + (global.viewWidth / 2);
var _posy = (_viewy + global.viewHeight) - 64 - 16;
var _firePartsNum = clamp(round(effectProgress * 20), 0, 3);
var _fireTailEnd = clamp(floor((effectProgress - 1) * 8), 0, 100);
var _flameLoop = 2;
var _flameFrames = sprite_get_number(sBeastFire);
var _flameTotalFrames = _flameFrames * _flameLoop;
var _tailFrames = sprite_get_number(sBeastFireTail);
var _totalFrames = _flameTotalFrames + _tailFrames;

for (var i = _firePartsNum; i >= _fireTailEnd; i -= 1)
{
    var _ii = clamp(_imgIndex - (i * 1), 0, _totalFrames);
    var _sp = sBeastFire;
    
    if (_ii >= (_flameTotalFrames + 1))
    {
        _sp = sBeastFireTail;
        _ii -= (_flameTotalFrames + 1);
    }
    
    draw_sprite_ext(_sp, _ii, _posx, _posy + (i * -64), _scale, _scale, 0, c_white, 1);
}

if (effectProgress >= 1)
    instance_destroy();
