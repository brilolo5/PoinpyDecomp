function wallDrawFunction(arg0, arg1)
{
    var _topCull = bbox_bottom < arg0;
    var _bottomCull = bbox_top > arg1;
    var _cull = _topCull || _bottomCull;
    
    if (!_cull)
    {
        var i = 0;
        var _drawy = bbox_top + 8;
        
        repeat (imageYscale)
        {
            draw_sprite_ext(wallSprite, wallImageIndex[i], x, _drawy, 0.1, 0.1, 0, c_white, 1);
            i += 1;
            _drawy += 16;
        }
    }
}

function getWallImageFromSurroundings(arg0, arg1)
{
    var checkThing = oWall;
    instance_activate_object(checkThing);
    var i = 0;
    
    if (place_meeting(arg0, arg1 - 16, checkThing))
        i += 1;
    
    if (place_meeting(arg0 - 16, arg1, checkThing))
        i += 2;
    
    if (place_meeting(arg0, arg1 + 16, checkThing))
        i += 8;
    
    if (place_meeting(arg0 + 16, arg1, checkThing))
        i += 4;
    
    return i;
}

function getWallImageFromSurroundings_justSides(arg0, arg1)
{
    var checkThing = oWall;
    instance_activate_object(checkThing);
    var i = 0;
    
    if (collision_point(arg0, arg1 - 16, checkThing, 0, 0))
        i += 1;
    
    if (collision_point(arg0 - 16, arg1, checkThing, 0, 0))
        i += 2;
    
    if (collision_point(arg0, arg1 + 16, checkThing, 0, 0))
        i += 8;
    
    if (collision_point(arg0 + 16, arg1, checkThing, 0, 0))
        i += 4;
    
    return i;
}
