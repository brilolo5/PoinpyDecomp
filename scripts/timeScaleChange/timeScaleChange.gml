function timeScaleChange()
{
    with (oControl)
    {
        var _tsGridHeight = ds_grid_height(timeScaleGrid);
        ds_grid_resize(timeScaleGrid, UnknownEnum.Value_3, _tsGridHeight + 1);
        _tsGridHeight = clamp(ds_grid_height(timeScaleGrid) - 1, 0, 999);
        timeScaleGrid[# UnknownEnum.Value_0, _tsGridHeight] = argument[0] * global.timeScaleDefault;
        timeScaleGrid[# UnknownEnum.Value_1, _tsGridHeight] = argument[1];
        timeScaleGrid[# UnknownEnum.Value_2, _tsGridHeight] = argument[2];
    }
}

function timeScaleClear()
{
    with (oControl)
        ds_grid_resize(timeScaleGrid, UnknownEnum.Value_3, 0);
}
