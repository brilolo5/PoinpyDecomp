function pcol_Fruit(arg0, arg1)
{
    touchScoreObject = instance_place(arg0, arg1, oFruit);
    
    if (touchScoreObject && !touchScoreObject.noGet && currentState != "grounded")
    {
        playSoundPlayerFruitPickup();
        
        if (touchScoreObject.golden)
        {
        }
        
        if (gainComboElement(touchScoreObject.sprite_index, touchScoreObject.fruitType, touchScoreObject.golden))
            generateEffect(touchScoreObject.x, touchScoreObject.y, "fruit get", 0);
        
        with (touchScoreObject)
            instance_destroy();
        
        return true;
    }
    
    return false;
}
