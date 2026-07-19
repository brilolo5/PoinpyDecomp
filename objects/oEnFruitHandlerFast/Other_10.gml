imageAngle = 0;
draw_sprite_ext(sprite_index, image_index, x + dcx, y + dcy, xscale, yscale, imageAngle, c_white, 1);

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
    
    draw_sprite_ext(sEnFruitHandlerHand, _handIndex, _handx, _handy, xscaleBase * xDirection, yscaleBase, imageAngle, c_white, 1);
}
