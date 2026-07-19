if (stomped)
{
    var _dir2p = point_direction(oPlayer.x, oPlayer.y, x, y);
    _dir2p = lerp(_dir2p, 270, 0.5);
    var _speed = 1.25;
    var _parse_xsp = lengthdir_x(_speed, _dir2p);
    var _parse_ysp = lengthdir_y(_speed, _dir2p);
    var _rareBody = random(64) < 1;
    
    with (instance_create_depth(x, y, depth, oDeadbodyEnemy))
    {
        sprite_index = sTentoBall_DeadInner;
        mask_index = other.mask_index;
        image_index = irandom(sprite_get_number(sprite_index) - 2);
        
        if (_rareBody)
            image_index = sprite_get_number(sprite_index) - 1;
        
        yscale = other.yscale;
        xscale = other.xscale;
        xDirection = other.xDirection;
        yDirection = other.yDirection;
        yscaleBase = other.yscaleBase;
        xscaleBase = other.xscaleBase;
        xsp = _parse_xsp * 3;
        ysp = 2;
        fric = 0.1;
        jobutsuTimer = 48;
        hitStop = 8;
        grav = 0.05;
        gravityEnabled = 1;
        var _whileLoopStopper = 0;
        
        while (place_meeting(x, y, parentWall) || place_meeting(x, y, oOnewayPlatform))
        {
            x -= _parse_xsp;
            y -= _parse_ysp;
            _whileLoopStopper += 1;
            
            if (_whileLoopStopper > 60)
                break;
        }
    }
    
    generateEffect(x, y, "tento shells", 1);
}
