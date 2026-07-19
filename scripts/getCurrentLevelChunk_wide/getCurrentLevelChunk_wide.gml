function getCurrentLevelChunk_wide()
{
    var json_rooms = -1;
    
    switch (global.currentLevelChunkSet)
    {
        case UnknownEnum.Value_1:
            json_rooms = ((global.areaChangeTracker % 2) != 0) ? roompack_BeginnerLevel00() : roompack_BeginnerInterval00();
            break;
        
        case UnknownEnum.Value_2:
            _tempSideWallFiller = 0;
            json_rooms = ((global.areaChangeTracker % 2) != 0) ? roompackwide_VineLevel00() : roompackwide_VineInterval00();
            break;
        
        case UnknownEnum.Value_3:
            _tempSideWallFiller = 0;
            json_rooms = ((global.areaChangeTracker % 2) != 0) ? roompackwide_BubbleLevel00() : roompackwide_BubbleInterval00();
            break;
        
        case UnknownEnum.Value_5:
            _tempSideWallFiller = 0;
            json_rooms = ((global.areaChangeTracker % 2) != 0) ? roompackwide_CannonLevel00() : roompackwide_CannonInterval00();
            break;
        
        case UnknownEnum.Value_4:
            _tempSideWallFiller = 0;
            json_rooms = ((global.areaChangeTracker % 2) != 0) ? roompackwide_PadLevel00() : roompackwide_PadInterval00();
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
