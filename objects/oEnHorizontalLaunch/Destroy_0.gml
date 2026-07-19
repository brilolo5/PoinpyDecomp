if (stomped)
{
    var _headSpeed = 0.75;
    var _tailSpeed = 1;
    var _headOffset = 0;
    var _tailOffset = 4;
    var playerTowardHead = sign(oPlayer.x - x - 0.1) * xDirection;
    
    if (playerTowardHead)
    {
        _headSpeed = 1;
        _tailSpeed = 0.75;
        _headOffset = 4;
        _tailOffset = 0;
    }
    
    var _dir2p = point_direction(oPlayer.x, oPlayer.y, x, y);
    _dir2p = 270 + (5 * xDirection);
    var _speed = _headSpeed;
    var _parse_xsp = lengthdir_x(_speed, _dir2p);
    var _parse_ysp = lengthdir_y(_speed, _dir2p);
    
    with (instance_create_depth(x + (12 * xDirection), y + _headOffset, depth, oDeadbodyEnemy))
    {
        wallCollision = 0;
        sprite_index = sDrillfish_dead_head;
        mask_index = other.mask_index;
        image_index = irandom(sprite_get_number(sprite_index) - 1);
        yscale = other.yscale;
        xscale = other.xscale;
        xDirection = other.xDirection;
        yDirection = other.yDirection;
        yscaleBase = other.yscaleBase;
        xscaleBase = other.xscaleBase;
        xsp = _parse_xsp * 3;
        ysp = _parse_ysp * 3;
        fric = 0.1;
        jobutsuTimer = 48;
        hitStop = 6;
        grav = 0.05;
        gravityEnabled = 1;
    }
    
    _dir2p = 270 - (5 * xDirection);
    _speed = _tailSpeed;
    _parse_xsp = lengthdir_x(_speed, _dir2p);
    _parse_ysp = lengthdir_y(_speed, _dir2p);
    
    with (instance_create_depth(x - (12 * xDirection), y + _tailOffset, depth, oDeadbodyEnemy))
    {
        sprite_index = sDrillfish_dead_tail;
        mask_index = other.mask_index;
        image_index = irandom(sprite_get_number(sprite_index) - 1);
        flashDisappear = 1;
        wallCollision = 0;
        yscale = other.yscale;
        xscale = other.xscale;
        xDirection = other.xDirection;
        yDirection = other.yDirection;
        yscaleBase = other.yscaleBase * 1.1;
        xscaleBase = other.xscaleBase * 1.1;
        xsp = _parse_xsp * 3;
        ysp = _parse_ysp * 3;
        fric = 0.1;
        jobutsuTimer = 18;
        hitStop = 6;
        grav = 0.05;
        gravityEnabled = 1;
        var _whileLoopStopper = 0;
    }
}
