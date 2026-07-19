function fruitGetRandomFromCycle()
{
    if (ds_exists(global.fruitRandomSpawnGrid, ds_type_grid))
    {
        if (ds_grid_get_sum(global.fruitRandomSpawnGrid, UnknownEnum.Value_1, 0, UnknownEnum.Value_1, ds_grid_height(global.fruitRandomSpawnGrid)) >= ds_grid_height(global.fruitRandomSpawnGrid))
            ds_grid_set_region(global.fruitRandomSpawnGrid, UnknownEnum.Value_1, 0, UnknownEnum.Value_1, ds_grid_height(global.fruitRandomSpawnGrid) - 1, 0);
        
        var randomFruit;
        
        while (true)
        {
            randomFruit = irandom(ds_grid_height(global.fruitRandomSpawnGrid));
            
            if (global.fruitRandomSpawnGrid[# UnknownEnum.Value_1, randomFruit] == 0)
            {
                global.fruitRandomSpawnGrid[# UnknownEnum.Value_1, randomFruit] = 1;
                break;
            }
        }
        
        var _fruit = global.fruitRandomSpawnGrid[# UnknownEnum.Value_0, randomFruit];
        return _fruit;
    }
    else
    {
        return UnknownEnum.Value_0;
    }
}
