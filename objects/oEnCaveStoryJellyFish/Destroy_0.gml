if (stomped)
{
    var _dir2p = point_direction(oPlayer.x, oPlayer.y, x, y);
    _dir2p = lerp(_dir2p, 270, 0.5);
    var _speed = 1.25;
    var _parse_xsp = lengthdir_x(_speed, _dir2p);
    var _parse_ysp = lengthdir_y(_speed, _dir2p);
    
    with (instance_create_depth(x, y, depth, oDeadbodyEnemy))
    {
        sprite_index = sEnemyJelly_dead;
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
    
    _dir2p = 270;
    _speed = 0.5;
    _parse_xsp = lengthdir_x(_speed, _dir2p);
    _parse_ysp = lengthdir_y(_speed, _dir2p);
    
    with (instance_create_depth(x, y - 8, depth, oDeadbodyEnemy))
    {
        sprite_index = sEnemyJelly_dead_jellyTop;
        mask_index = other.mask_index;
        image_index = 1;
        flashDisappear = 1;
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
        hitStop = 10;
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
    
    if (enemyState == "flutter with fruit")
    {
        if (instance_exists(myFruitInstance))
        {
            myFruitInstance.suckResist = 1;
            myFruitInstance.suckResistTimer = 3;
            var _parseFruitId = myFruitInstance;
            
            with (oPlayer)
                ds_list_add(fruitVicinityList, _parseFruitId);
        }
    }
}
