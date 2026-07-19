function instance_place_with(arg0, arg1, arg2, arg3)
{
    var _x = arg0;
    var _y = arg1;
    var _target = arg2;
    var _with = arg3;
    var _check = 0;
    
    with (_with)
        _check = instance_place(_x, _y, _target);
    
    return _check;
}
