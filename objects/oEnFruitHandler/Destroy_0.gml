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
        
        generateEffect(myFruitInstance.x, myFruitInstance.y, "fruit plate flying", xDirection);
    }
}
