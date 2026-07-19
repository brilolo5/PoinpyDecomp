function shootEnemyBullet(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
{
    var _x = arg0;
    var _y = arg1;
    var _sprite = arg2;
    var _mask = arg3;
    var _xscale = arg4;
    var _yscale = arg5;
    var _direction = arg6;
    var _speed = arg7;
    var _grav = arg8;
    var _fric = arg9;
    var _wallCollision = arg10;
    var _killTimer = arg11;
    var _hitEnemy = arg12;
    var _ImageAngleIsDirection = arg13;
    var _bullet = instance_create_depth(_x, _y, 0, oGeneralEnemyBullet);
    
    with (_bullet)
    {
        sprite_index = _sprite;
        mask_index = _mask;
        xsp = lengthdir_x(_speed, _direction);
        ysp = lengthdir_y(_speed, _direction);
        grav = _grav;
        fric = _fric;
        wallCollision = _wallCollision;
        killTimer = _killTimer;
        hitEnemy = _hitEnemy;
        angleIsDirecion = _ImageAngleIsDirection;
        xscaleBase = _xscale;
        yscaleBase = _yscale;
        xscale = xscaleBase * xDirection * xShrink;
        yscale = yscaleBase * yDirection * yShrink;
    }
    
    return _bullet;
}
