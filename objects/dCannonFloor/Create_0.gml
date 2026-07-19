image_speed = 0;
imageIndex = 0;
size = abs(image_xscale);
var _target = instance_place(x + 1, y, object_index);

if (_target)
{
    var _targetXscale = abs(_target.image_xscale);
    size += _targetXscale;
    x += (_targetXscale * 8);
    instance_destroy(_target);
}

_target = instance_place(x - 1, y, object_index);

if (_target)
{
    var _targetXscale = abs(_target.image_xscale);
    size += _targetXscale;
    x -= (_targetXscale * 8);
    instance_destroy(_target);
}

image_xscale = getHDirectionOnCreate(noFlip, oppositeSide, image_xscale);
xDirection = 1;
cornerOrigin = x - ((size - 1) * 8 * xDirection);
