function recipeStateChange(arg0)
{
    with (oOrderControl)
    {
        recipeListState = arg0;
        recipeListTimer = 0;
        recipeListStateInitialize = 1;
    }
}

function recipeStateInitialize()
{
    if (recipeListStateInitialize)
    {
        recipeListStateInitialize = 0;
        return true;
    }
    else
    {
        return false;
    }
}

function recipeStateTimer(arg0)
{
    recipeListTimer += (1 / arg0);
    
    if (recipeListTimer >= 1)
        return true;
}
