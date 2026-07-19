function dsGridDeleteRow()
{
    var grid = argument[0];
    var row = argument[1];
    var grid_width = ds_grid_width(grid);
    var grid_height = ds_grid_height(grid);
    ds_grid_set_grid_region(grid, grid, 0, row + 1, grid_width - 1, grid_height - 1, 0, row);
    ds_grid_resize(grid, grid_width, grid_height - 1);
}
