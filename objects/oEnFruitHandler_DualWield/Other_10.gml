imageAngle = 0;
draw_sprite_ext(sprite_index, image_index, x + dcx, y + dcy, xscale, yscale, imageAngle, c_white, 1);

if (instance_exists(myFruitLeft))
{
    with (myFruitLeft)
        event_user(0);
    
    var _handx = (myFruitLeft.x + myFruitLeft.cx) - (xDirection * 10);
    var _handy = myFruitLeft.y + myFruitLeft.cy + 2;
    var _handIndex = 0;
    
    switch (enemyState)
    {
        case "patrol":
            _handx = (myFruitLeft.x + myFruitLeft.cx) - (xDirection * 10);
            _handy = myFruitLeft.y + myFruitLeft.cy + 2;
            break;
        
        case "turn":
            _handx = myFruitLeft.x + myFruitLeft.cx;
            _handIndex = 1;
            break;
    }
    
    _handIndex = 1;
    draw_sprite_ext(sEnFruitHandlerHand, _handIndex, myFruitLeft.x, myFruitLeft.y + 3, handxscale, 0.1, handangle, c_white, 1);
}

if (instance_exists(myFruitRight))
{
    with (myFruitRight)
        event_user(0);
    
    var _handx = (myFruitRight.x + myFruitRight.cx) - (xDirection * 10);
    var _handy = myFruitRight.y + myFruitRight.cy + 2;
    var _handIndex = 0;
    
    switch (enemyState)
    {
        case "patrol":
            _handx = (myFruitRight.x + myFruitRight.cx) - (xDirection * 10);
            _handy = myFruitRight.y + myFruitRight.cy + 2;
            break;
        
        case "turn":
            _handx = myFruitRight.x + myFruitRight.cx;
            _handIndex = 1;
            break;
    }
    
    _handIndex = 1;
    draw_sprite_ext(sEnFruitHandlerHand, _handIndex, myFruitRight.x, myFruitRight.y + 3, -handxscale, 0.1, handangle, c_white, 1);
}
