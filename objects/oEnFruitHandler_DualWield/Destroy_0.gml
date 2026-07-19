event_inherited();

if (stomped)
{
    if (instance_exists(myFruitLeft))
    {
        myFruitLeft.suckResist = 1;
        myFruitLeft.suckResistTimer = 3;
        myFruitLeft.noWiggle = 0;
        var _parseFruitId = myFruitLeft;
        
        with (oPlayer)
            ds_list_add(fruitVicinityList, _parseFruitId);
        
        generateEffect(myFruitLeft.x, myFruitLeft.y, "fruit plate flying", -1);
    }
    
    if (instance_exists(myFruitRight))
    {
        myFruitRight.suckResist = 1;
        myFruitRight.suckResistTimer = 3;
        myFruitRight.noWiggle = 0;
        var _parseFruitId = myFruitRight;
        
        with (oPlayer)
            ds_list_add(fruitVicinityList, _parseFruitId);
        
        generateEffect(myFruitRight.x, myFruitRight.y, "fruit plate flying", 1);
    }
}
