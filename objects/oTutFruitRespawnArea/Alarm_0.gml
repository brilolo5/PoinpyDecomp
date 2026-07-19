instance_activate_object(oTutFruitRespawnAreaPointer);
fruitPositionArray[0][0] = x;
fruitPositionArray[0][1] = y;
fruitPositionCount = 0;

while (true)
{
    show_debug_message("looking at pointers");
    var _pointer = instance_place(x, y, oTutFruitRespawnAreaPointer);
    
    if (_pointer)
    {
        fruitPositionArray[fruitPositionCount][0] = _pointer.x;
        fruitPositionArray[fruitPositionCount][1] = _pointer.y;
        instance_destroy(_pointer);
        fruitPositionCount += 1;
    }
    else
    {
        break;
    }
}

set = 1;
growTutFruit();
