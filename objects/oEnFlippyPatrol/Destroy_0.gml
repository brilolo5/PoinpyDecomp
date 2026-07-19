if (stomped)
{
    var _dir2p = point_direction(oPlayer.x, oPlayer.y, x, y);
    var _parse_xsp = lengthdir_x(1, _dir2p);
    var _parse_ysp = lengthdir_y(1, _dir2p);
    
    with (instance_create_depth(x, y, depth, oDeadbodyEnemy))
    {
        sprite_index = other.deadSprite;
        mask_index = other.mask_index;
        image_index = other.side;
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
    
    generateEffect(x, y, "temp white flash", 0);
}
