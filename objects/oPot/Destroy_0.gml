if (instance_exists(myFruit))
{
    var _parseMyFruit = myFruit;
    
    with (myFruit)
    {
        outlineAlpha = 0;
        image_alpha = 1;
        fruitScale = 0.1;
        noWiggle = 0;
        noGet = 0;
        suckResist = 1;
        suckResistTimer = 16;
    }
    
    with (oPlayer)
        ds_list_add(fruitVicinityList, _parseMyFruit);
}
