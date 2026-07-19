imageAngle = 0;
doy = -1.5;
draw_sprite_ext(sprite_index, image_index, x + dcx, y + dcy + doy, xscale, yscale, imageAngle, c_white, 1);

if (drawTears)
    draw_sprite_ext(sHacobow_tears, tearFrame, x + dcx, y + dcy + doy, xscale, yscale, imageAngle, c_white, 1);

if (instance_exists(myFruitInstance_top))
{
    with (myFruitInstance_top)
        event_user(0);
}

if (instance_exists(myFruitInstance))
{
    with (myFruitInstance)
        event_user(0);
    
    var _handx = (myFruitInstance.x + myFruitInstance.cx) - (xDirection * 10);
    var _handy = myFruitInstance.y + myFruitInstance.cy + 2;
    var _handIndex = 0;
    
    switch (enemyState)
    {
        case "patrol":
            _handx = (myFruitInstance.x + myFruitInstance.cx) - (xDirection * 10);
            _handy = myFruitInstance.y + myFruitInstance.cy + 2;
            break;
        
        case "turn":
            _handx = myFruitInstance.x + myFruitInstance.cx;
            _handIndex = 1;
            break;
    }
    
    _handIndex = 1;
    draw_sprite_ext(handSprite, handIndex, handx, handy + doy, handxscale, 0.1, handangle, c_white, 1);
}
