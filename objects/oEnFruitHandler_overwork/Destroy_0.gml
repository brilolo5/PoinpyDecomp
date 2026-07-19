event_inherited();

if (stomped)
{
    if (instance_exists(myFruitInstance))
    {
        myFruitInstance.suckResist = 1;
        myFruitInstance.suckResistTimer = 3;
        myFruitInstance.noWiggle = 0;
        var _parseFruitId = myFruitInstance;
        
        with (oPlayer)
            ds_list_add(fruitVicinityList, _parseFruitId);
        
        throwPlate(myFruitInstance.x, myFruitInstance.y, xDirection);
    }
    
    if (instance_exists(myFruitInstance_top))
    {
        myFruitInstance_top.suckResist = 1;
        myFruitInstance_top.suckResistTimer = 5;
        myFruitInstance_top.noWiggle = 0;
        var _parseFruitId = myFruitInstance_top;
        
        with (oPlayer)
            ds_list_add(fruitVicinityList, _parseFruitId);
    }
}
