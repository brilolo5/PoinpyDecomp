if (live_call())
    return global.live_result;

var _gridIndex = recipeDataGrid;
var _gridHeight = ds_grid_height(_gridIndex);
var _banSignScale = 0.1;
var _banSignAlpha = 1;
var _banSignIndex = 0;

if (banPreActive > 0)
{
    _banSignScale = 0.11000000000000001;
    var _blink = round(current_time / 120) % 2;
    _banSignScale = _blink ? 0.1 : 0.1;
    _banSignAlpha = _blink ? 0.65 : 0.6;
    bannedFruitLockFlash = -1;
}
else if (bannedFruitLockFlash == -1)
{
    bannedFruitLockFlash = 1;
}

if (bannedFruitLockFlash > 0)
{
    bannedFruitLockFlash -= 0.25;
    _banSignScale = 0.12;
}

if (fruitBanIsActive() || banPreActive > 0)
{
    var _bannedListSize = ds_list_size(global.bannedFruitList);
    
    if (_bannedListSize > 0)
    {
        for (var i = 0; i < _bannedListSize; i += 1)
        {
            var _excludeIndex = global.bannedFruitList[| i];
            
            with (oFruit)
            {
                if (fruitType == _excludeIndex)
                    draw_sprite_ext(sOrderExcludeSign, _banSignIndex, x + cx, y + cy, _banSignScale, _banSignScale, 0, make_color_rgb(255, 255, 255), _banSignAlpha);
            }
        }
    }
}
