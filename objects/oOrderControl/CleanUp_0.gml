if (ds_exists(comboCheckGrid, ds_type_grid))
    ds_grid_destroy(comboCheckGrid);

if (ds_exists(recipeDataGrid, ds_type_grid))
    ds_grid_destroy(recipeDataGrid);

function freeSurface(arg0)
{
    if (surface_exists(arg0))
        surface_free(arg0);
}

freeSurface(_baseSurface);
freeSurface(_meterSurface);
freeSurface(_croppingSurface);
freeSurface(thoughtCloudSurface_pie);
freeSurface(thoughtCloudSurface_bg);
freeSurface(thoughtCloudSurface_crop);
