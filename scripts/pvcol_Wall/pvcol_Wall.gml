function pvcol_Wall()
{
    var _target = instance_place(argument[0], argument[1], parentWall);
    
    if (_target)
        return true;
}
