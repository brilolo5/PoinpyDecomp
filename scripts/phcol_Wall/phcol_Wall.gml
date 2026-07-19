function phcol_Wall()
{
    var _target = instance_place(argument[0], argument[1], parentWall);
    
    if (_target != -4)
        return _target;
}
