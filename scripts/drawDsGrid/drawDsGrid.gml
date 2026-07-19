function drawDsGrid(arg0, arg1, arg2, arg3)
{
    drawSetAlign(0, 0);
    var _gridText = "";
    var _drawx = arg0;
    var _drawy = arg1;
    _gridText = arg2;
    var _grid = arg3;
    
    if (ds_exists(_grid, ds_type_grid))
    {
        var _gridWidth = ds_grid_width(_grid);
        var _gridHeight = ds_grid_height(_grid);
        _gridText += (" (" + string(_gridWidth) + "," + string(_gridHeight) + ") \n");
        
        for (var i = 0; i < _gridHeight; i += 1)
        {
            for (var t = 0; t < _gridWidth; t += 1)
                _gridText += (string(_grid[# t, i]) + ", ");
            
            _gridText += "\n";
        }
    }
    else
    {
        _gridText += "-no data";
    }
    
    drawTextOutlined(_drawx, _drawy, _gridText, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 1);
}
