sprite_index = sLevelTile00;

if (image_yscale > 1)
{
    var _topy = bbox_top + 8;
    var i = 0;
    
    repeat (image_yscale)
    {
        wallImageIndex[i] = getWallImageFromSurroundings_justSides(x, _topy);
        i += 1;
        _topy += 16;
    }
}
else
{
    wallImageIndex[0] = getWallImageFromSurroundings(x, y);
}

imageYscale = image_yscale;
