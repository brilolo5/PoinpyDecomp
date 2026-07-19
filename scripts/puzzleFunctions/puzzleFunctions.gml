function puzzleRecipeInit()
{
    recipeDataGrid = ds_grid_create(UnknownEnum.Value_5, 0);
    ds_list_clear(global.bannedFruitList);
}

function puzzleRecipeAdd(arg0, arg1, arg2)
{
    var _gridHeight = ds_grid_height(recipeDataGrid);
    _gridHeight += 1;
    ds_grid_resize(recipeDataGrid, UnknownEnum.Value_5, _gridHeight);
    _gridHeight = ds_grid_height(recipeDataGrid) - 1;
    recipeDataGrid[# UnknownEnum.Value_0, _gridHeight] = arg0;
    recipeDataGrid[# UnknownEnum.Value_1, _gridHeight] = arg2;
    recipeDataGrid[# UnknownEnum.Value_3, _gridHeight] = 0;
    recipeDataGrid[# UnknownEnum.Value_4, _gridHeight] = arg1;
}

function puzzleRecipeBan(arg0)
{
    ds_list_add(global.bannedFruitList, arg0);
}

function sortRecipe()
{
    ds_grid_sort(recipeDataGrid, UnknownEnum.Value_1, false);
    var _gridHeight = ds_grid_height(recipeDataGrid);
    var _bunchYpos = ds_grid_value_y(recipeDataGrid, UnknownEnum.Value_4, 0, UnknownEnum.Value_4, _gridHeight, UnknownEnum.Value_4);
    
    if (_bunchYpos != -1)
    {
        var _bunchAmount = recipeDataGrid[# UnknownEnum.Value_1, _bunchYpos];
        recipeDataGrid[# UnknownEnum.Value_1, _bunchYpos] = 99;
        ds_grid_sort(recipeDataGrid, UnknownEnum.Value_1, false);
        recipeDataGrid[# UnknownEnum.Value_1, 0] = _bunchAmount;
        recipeDataGrid[# UnknownEnum.Value_0, 0] = -1;
    }
}
