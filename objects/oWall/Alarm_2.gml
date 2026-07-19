function reinitializeTarget(arg0)
{
    arg0.alarm[1] = 1;
}

var checkThing = oWall;
var i = 0;
var _targetNeighbor = instance_place(x, y - 16, checkThing);

if (_targetNeighbor)
{
    i += 1;
    reinitializeTarget(_targetNeighbor);
}

_targetNeighbor = instance_place(x - 16, y, checkThing);

if (_targetNeighbor)
{
    i += 2;
    reinitializeTarget(_targetNeighbor);
}

_targetNeighbor = instance_place(x, y + 16, checkThing);

if (_targetNeighbor)
{
    i += 8;
    reinitializeTarget(_targetNeighbor);
}

_targetNeighbor = instance_place(x + 16, y, checkThing);

if (_targetNeighbor)
{
    i += 4;
    reinitializeTarget(_targetNeighbor);
}

sprite_index = sLevelTile00;
image_index = i;
