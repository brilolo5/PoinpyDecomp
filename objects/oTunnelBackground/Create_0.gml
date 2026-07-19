depth = 10000;
layer0_y = y;
layer1_y = y;
previousLevelChunk = global.previousLevelChunkSet;
nextLevelChunk = global.currentLevelChunkSet;
bgChange = 1;
var _myid = id;

with (oTunnelBackground)
{
    if (id != _myid)
        bgChange = 0;
}
