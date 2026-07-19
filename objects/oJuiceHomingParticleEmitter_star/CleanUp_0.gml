if (receivedComboGrid != undefined && ds_exists(receivedComboGrid, ds_type_grid))
{
    ds_grid_destroy(receivedComboGrid);
    receivedComboGrid = undefined;
}
