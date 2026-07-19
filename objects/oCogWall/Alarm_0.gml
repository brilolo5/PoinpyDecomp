instance_activate_object(oCogWall);
var _check = 0;

if (place_meeting(x, y + 8, oCogWall))
    _check += 1;

if (place_meeting(x, y - 8, oCogWall))
    _check -= 1;

switch (_check)
{
    case 0:
        var _imageNumber = sprite_get_number(sVinePart) - 1;
        image_index = irandom_range(2, _imageNumber);
        break;
    
    case 1:
        image_index = 0;
        break;
    
    case -1:
        image_index = 1;
        break;
}

var checkThing = oWall;
var i = 0;
var _targetNeighbor = instance_place(x, y - 16, checkThing);

if (_targetNeighbor)
{
    i += 1;
    
    if (_targetNeighbor.set)
        _targetNeighbor.set = 0;
}

_targetNeighbor = instance_place(x - 16, y, checkThing);

if (_targetNeighbor)
{
    i += 2;
    
    if (_targetNeighbor.set)
        _targetNeighbor.set = 0;
}

_targetNeighbor = instance_place(x, y + 16, checkThing);

if (_targetNeighbor)
{
    i += 8;
    
    if (_targetNeighbor.set)
        _targetNeighbor.set = 0;
}

_targetNeighbor = instance_place(x + 16, y, checkThing);

if (_targetNeighbor)
{
    i += 4;
    
    if (_targetNeighbor.set)
        _targetNeighbor.set = 0;
}

wallIndex = i;
