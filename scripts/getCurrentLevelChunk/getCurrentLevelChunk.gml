function getCurrentLevelChunk()
{
    var json_rooms = -1;
    
    switch (global.currentLevelChunkSet)
    {
        case UnknownEnum.Value_1:
            json_rooms = ((global.areaChangeTracker % 2) != 0) ? roompack_BeginnerLevel00() : roompack_BeginnerInterval00();
            break;
        
        case UnknownEnum.Value_2:
            json_rooms = ((global.areaChangeTracker % 2) != 0) ? roompack_level00() : roompack_interval00();
            break;
        
        case UnknownEnum.Value_3:
            json_rooms = ((global.areaChangeTracker % 2) != 0) ? roompack_BubbleLevel00() : roompack_BubbleInterval00();
            break;
        
        case UnknownEnum.Value_5:
            json_rooms = ((global.areaChangeTracker % 2) != 0) ? roompack_CannonLevel00() : roompack_CannonInterval00();
            break;
        
        case UnknownEnum.Value_4:
            json_rooms = ((global.areaChangeTracker % 2) != 0) ? roompack_PadLevel00() : roompack_PadInterval00();
            break;
        
        case UnknownEnum.Value_6:
            json_rooms = ((global.areaChangeTracker % 2) != 0) ? roompack_MixLevel00() : roompack_MixInterval00();
            break;
        
        default:
            json_rooms = ((global.areaChangeTracker % 2) != 0) ? roompack_BeginnerLevel00() : roompack_BeginnerInterval00();
            break;
    }
    
    return json_rooms;
}
