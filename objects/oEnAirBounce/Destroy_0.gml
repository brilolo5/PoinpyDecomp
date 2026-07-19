event_inherited();

if (stomped && enemyState == "flutter with fruit")
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
