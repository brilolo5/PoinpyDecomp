size = image_xscale;
partIndex = 0;
var _leftSprite = sFloorGrass_left;
var _rightSprite = sFloorGrass_right;
var _centerSprite = sFloorGrass_center;
var _singleSprite = sFloorGrass_single;
partSprite = array_create(1, _singleSprite);
partImageIndex = array_create(1, 0);
partx = array_create(1, x);
var _imageIndex = x + abs(y);
leftStart = bbox_left + 8;
spacing = 16;
var _x = leftStart;
drawy = y - 8;

if (size == 1)
{
    partx[partIndex] = _x;
    partSprite[partIndex] = _singleSprite;
    partImageIndex[partIndex] = _imageIndex % 3;
}
else
{
    partx[partIndex] = _x;
    partSprite[partIndex] = _leftSprite;
    partImageIndex[partIndex] = _imageIndex % 3;
    
    for (var _i = 1; _i < (size - 1); _i += 1)
    {
        partx[_i] = _x + (spacing * _i);
        partSprite[_i] = _centerSprite;
        partImageIndex[_i] = (_imageIndex + _i) % 6;
    }
    
    partIndex = size - 1;
    partx[partIndex] = _x + (spacing * partIndex);
    partSprite[partIndex] = _rightSprite;
    partImageIndex[partIndex] = (_imageIndex + partIndex) % 3;
}
