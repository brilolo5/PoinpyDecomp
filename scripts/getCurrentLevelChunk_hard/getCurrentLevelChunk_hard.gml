function getCurrentLevelChunk_hard()
{
    var json_rooms = -1;
    var _chunkSpawnRate = 2;
    var _chunkOrInterval = (ceil(global.areaChangeTracker / 2) % _chunkSpawnRate) != 0;
    
    switch (global.areaChangeTracker % 5)
    {
        case 0:
            _chunkOrInterval = 1;
            break;
        
        case 1:
            _chunkOrInterval = 0;
            break;
        
        case 2:
            _chunkOrInterval = 1;
            break;
        
        case 3:
            _chunkOrInterval = 1;
            break;
        
        case 4:
            _chunkOrInterval = 0;
            break;
        
        case 5:
            _chunkOrInterval = 0;
            break;
    }
    
    switch (global.currentLevelChunkSet)
    {
        case UnknownEnum.Value_1:
            json_rooms = _chunkOrInterval ? roompack_BeginnerLevel00() : roompack_BeginnerInterval00();
            break;
        
        case UnknownEnum.Value_2:
            json_rooms = _chunkOrInterval ? roompack_VineHard() : roompack_interval00();
            break;
        
        case UnknownEnum.Value_3:
            json_rooms = _chunkOrInterval ? roompack_BubbleLevelHard() : roompack_BubbleInterval00();
            break;
        
        case UnknownEnum.Value_5:
            json_rooms = _chunkOrInterval ? roompack_CannonLevelHard() : roompack_CannonInterval00();
            break;
        
        case UnknownEnum.Value_4:
            json_rooms = _chunkOrInterval ? roompack_PadLevelHard() : roompack_PadInterval00();
            break;
        
        case UnknownEnum.Value_6:
            json_rooms = _chunkOrInterval ? roompack_MixLevel00() : roompack_MixInterval00();
            break;
        
        default:
            json_rooms = _chunkOrInterval ? roompack_BeginnerLevel00() : roompack_BeginnerInterval00();
            break;
    }
    
    return json_rooms;
}
