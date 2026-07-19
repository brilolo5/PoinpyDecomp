var _gridIndex = recipeDataGrid;
var _gridHeight = ds_grid_height(_gridIndex);
var _bannedListSize = ds_list_size(global.bannedFruitList);

if (_bannedListSize > 0)
{
    for (var i = 0; i < _bannedListSize; i += 1)
    {
        var _excludeIndex = global.bannedFruitList[| i];
        
        with (oFruit)
        {
            if (fruitType == _excludeIndex)
                draw_sprite_ext(sOrderExcludeSign, 0, x + cx, y + cy, 0.1, 0.1, 0, make_color_rgb(255, 255, 255), 1);
        }
    }
}
