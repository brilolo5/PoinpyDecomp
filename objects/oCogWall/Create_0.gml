if ((abs(image_xscale) + abs(image_yscale)) > 2)
{
    var _wallSize = 16;
    var _xscale = 1;
    var _yscale = image_yscale;
    var _startingLeft = bbox_left;
    var _startingTop = bbox_top;
    
    for (var i = 0; i < _yscale; i += 1)
    {
        for (var t = 0; t < _xscale; t += 1)
        {
            var _posx = _startingLeft + (_wallSize * t) + (_wallSize / 2);
            var _posy = _startingTop + (_wallSize * i) + (_wallSize / 2);
            instance_create_depth(_posx, _posy, 0, object_index);
        }
    }
    
    instance_destroy();
}

set = 0;
flowerSprite = sVineFlower;
flowerIndex = choose(1, 2);
mask_index = mask_16x16;
sprite_index = sVinePart;

if (global.currentLevelChunkSet == UnknownEnum.Value_6)
{
    flowerSprite = sVineFlower_neon;
    sprite_index = sVinePart_neon;
}

image_speed = 0;
wallSprite = sLevelTile00;
wallIndex = 0;
wallImageIndex[0] = 15;
imageYscale = 1;
flowerOpen = 0;
facingDirection = getHDirectionOnCreate(noFlip, oppositeSide, image_xscale);
alarm[0] = 1;

drawFunction = function()
{
    draw_sprite_ext(sprite_index, image_index, x + (facingDirection * 5), y, ((image_xscale * 1) / 10) * -facingDirection, (image_yscale * 1) / 10, 0, c_white, 1);
};
