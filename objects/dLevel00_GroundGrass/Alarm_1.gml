var _target = instance_place(x + 16, y, object_index);

if (_target)
{
    x += (_target.image_xscale * 8);
    image_xscale += _target.image_xscale;
    instance_destroy(_target);
}

_target = instance_place(x - 16, y, object_index);

if (_target)
{
    x -= (_target.image_xscale * 8);
    image_xscale += _target.image_xscale;
    instance_destroy(_target);
}
