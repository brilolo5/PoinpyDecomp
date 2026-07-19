function debugRightClickFunction()
{
    if (live_call())
        return global.live_result;
    
    with (oOrderControl)
    {
        repeat (1)
            orderDebugGetAllFruit(recipeDataGrid, global.comboGrid);
    }
}
