var _food = instance_place(x, y + 16, dCannonPillar);

if (_food)
{
    image_yscale += _food.image_yscale;
    y += (8 * _food.image_yscale);
    instance_destroy(_food);
}

image_xscale = getHDirectionOnCreate(noFlip, oppositeSide, image_xscale);
var _height = (bbox_bottom - bbox_top) + 1;
extraTiles = ((_height - sprite_get_height(sprite_index)) / 16) - 1;
noDraw = 0;

if (extraTiles < -1)
    noDraw = 1;
