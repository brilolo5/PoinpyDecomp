var _roomWidth;
var _flip = choose(0, 1);
var _tempSideWallFiller = 1;
var _newAreaDiscovery = false;

while ((getViewy(global.cam) - y) < 128)
{
    var _difficulty = clamp(floor((global.difficultyLevel - startingDifficulty) / 2), 0, 999) + global.juicerRank;
    levelNum = _difficulty;
    
    if (!finalAreaLock)
    {
        if (getAreaDiscoveryThreshold() != -1)
        {
            if (global.difficultyLevel >= getAreaDiscoveryThreshold())
                global.areaChangeTracker = max(global.areaChangeTracker, areaChangeThreshold - 1);
        }
        
        if (global.finalStretchSequence > UnknownEnum.Value_0)
            global.areaChangeTracker = 0;
        
        if (global.areaChangeTracker > areaChangeThreshold)
        {
            queueTransitionChunk = 1;
            
            if (ds_list_size(global.areaOrderList) > 1)
            {
                ds_list_delete(global.areaOrderList, 0);
            }
            else
            {
                var _lastAreaInList = global.areaOrderList[| 0];
                ds_list_clear(global.areaOrderList);
                ds_list_copy(global.areaOrderList, global.areaUnlockedList);
                
                while (true)
                {
                    show_debug_message("shuffled");
                    ds_list_shuffle(global.areaOrderList);
                    
                    if (global.areaOrderList[| 0] != _lastAreaInList)
                    {
                        show_debug_message("last area " + string(_lastAreaInList) + ", next area " + string(global.areaOrderList[| 0]));
                        break;
                    }
                    else if (ds_list_size(global.areaOrderList) <= 1)
                    {
                        if (global.areaUnlockedList[| 0] == UnknownEnum.Value_2 || global.areaUnlockedList[| 0] == UnknownEnum.Value_1)
                            queueTransitionChunk = 0;
                        
                        break;
                    }
                }
            }
            
            if (!instance_exists(oDiscoveryLine))
            {
                _newAreaDiscovery = areaDiscoveryCheck();
                
                if (_newAreaDiscovery != false)
                {
                    ds_list_insert(global.areaOrderList, 0, _newAreaDiscovery);
                    queueTransitionChunk = 1;
                }
            }
            
            global.areaChangeTracker = 0;
            global.previousLevelChunkSet = global.currentLevelChunkSet;
        }
        
        global.currentLevelChunkSet = global.areaOrderList[| 0];
        
        if (global.finalStretchSequence == UnknownEnum.Value_2)
        {
            finalAreaLock = 1;
            queueTransitionChunk = 1;
            global.previousLevelChunkSet = global.currentLevelChunkSet;
            global.currentLevelChunkSet = UnknownEnum.Value_6;
        }
    }
    else
    {
        global.currentLevelChunkSet = UnknownEnum.Value_6;
    }
    
    if (global.debugAreaLock > 0)
    {
        global.currentLevelChunkSet = global.debugAreaAllList[| global.debugAreaLock];
        queueTransitionChunk = 0;
        
        with (oTunnelBackground)
            bgChange = 0;
        
        with (oGameBackground)
        {
            bgArea = global.currentLevelChunkSet;
            bgLayerData = getAreaColor(bgArea);
        }
        
        if (global.currentLevelChunkSet == UnknownEnum.Value_6)
        {
            if (!instance_exists(oMagma))
                instance_create_depth(room_width / 2, oPlayer.y + 96, depth, oMagma);
        }
    }
    
    var json_rooms;
    
    if (!global.wideGame)
        json_rooms = getCurrentLevelChunk();
    else
        json_rooms = getCurrentLevelChunk_wide();
    
    if (queueTransitionChunk)
    {
        _tempSideWallFiller = 1;
        
        switch (global.currentLevelChunkSet)
        {
            case UnknownEnum.Value_1:
                json_rooms = ((global.areaChangeTracker % 2) != 0) ? roompack_BeginnerLevel00() : roompack_BeginnerInterval00();
                break;
            
            case UnknownEnum.Value_2:
                json_rooms = roompack_TransitionVines00();
                break;
            
            case UnknownEnum.Value_3:
                json_rooms = roompack_TransitionBubble00();
                break;
            
            case UnknownEnum.Value_5:
                json_rooms = roompack_TransitionCannon00();
                break;
            
            case UnknownEnum.Value_4:
                json_rooms = roompack_TransitionPad00();
                break;
            
            case UnknownEnum.Value_6:
                finalAreaTransition = UnknownEnum.Value_1;
                break;
            
            default:
                json_rooms = roompack_TransitionVines00();
                break;
        }
        
        if (global.currentLevelChunkSet != UnknownEnum.Value_6)
            json_rooms = roompack_Transition00();
        
        queueTransitionChunk = 0;
    }
    
    if (startChunk)
    {
        switch (global.currentLevelChunkSet)
        {
            case UnknownEnum.Value_1:
                json_rooms = roompack_BeginnerStart00();
                break;
            
            case UnknownEnum.Value_2:
                json_rooms = roompack_VineStart00();
                break;
            
            case UnknownEnum.Value_3:
                json_rooms = roompack_BubbleStart00();
                break;
            
            case UnknownEnum.Value_5:
                json_rooms = roompack_CannonStart00();
                break;
            
            case UnknownEnum.Value_4:
                json_rooms = roompack_JumppadStart00();
                break;
            
            default:
                json_rooms = roompack_VineStart00();
                break;
        }
        
        startChunk = 0;
        global.areaChangeTracker -= 1;
    }
    
    if (finalAreaTransition > 0)
    {
        switch (finalAreaTransition)
        {
            case UnknownEnum.Value_1:
                json_rooms = roompack_spaceShaftBottom();
                finalAreaTransition = UnknownEnum.Value_2;
                break;
            
            case UnknownEnum.Value_2:
                json_rooms = roompack_spaceShaftInbetween();
                break;
            
            case UnknownEnum.Value_3:
                json_rooms = roompack_spaceShaftSpaceView();
                break;
            
            case UnknownEnum.Value_4:
                json_rooms = roompack_spaceShaftTop();
                finalAreaTransition = UnknownEnum.Value_0;
                break;
        }
    }
    
    global.areaChangeTracker += 1;
    var name = ds_map_find_first(json_rooms);
    
    repeat (irandom_range(0, ds_map_size(json_rooms) - 1))
        name = ds_map_find_next(json_rooms, name);
    
    var _roomIndexMap = json_rooms[? name];
    
    if (_flip)
    {
        if (ds_exists(_roomIndexMap, ds_type_map))
        {
            var _roomLayerList = _roomIndexMap[? "layers"];
            
            if (ds_exists(_roomLayerList, ds_type_list))
            {
                var _layerNum = ds_list_size(_roomLayerList);
                var _layerIndex = 0;
                
                repeat (_layerNum)
                {
                    var _roomInstanceLayerMap = _roomLayerList[| _layerIndex];
                    
                    if (ds_exists(_roomInstanceLayerMap, ds_type_map))
                    {
                        if (ds_map_exists(_roomInstanceLayerMap, "instances"))
                        {
                            var _roomInstanceLayerInstanceList = _roomInstanceLayerMap[? "instances"];
                            
                            if (ds_exists(_roomInstanceLayerInstanceList, ds_type_list))
                            {
                                var i = 0;
                                
                                repeat (ds_list_size(_roomInstanceLayerInstanceList))
                                {
                                    var _roomInstanceLayerInstanceListMap = _roomInstanceLayerInstanceList[| i];
                                    var _instx = _roomInstanceLayerInstanceListMap[? "x"];
                                    var _roomSettings = _roomIndexMap[? "roomSettings"];
                                    _roomWidth = _roomSettings[? "Width"];
                                    var _roomCenterx = _roomWidth / 2;
                                    _instx = _roomCenterx - (_instx - _roomCenterx);
                                    _roomInstanceLayerInstanceListMap[? "x"] = _instx;
                                    i += 1;
                                }
                            }
                        }
                    }
                    
                    _layerIndex += 1;
                }
            }
        }
    }
    
    roomLength = ds_map_find_value(ds_map_find_value(json_rooms, name), "roomSettings")[? "Height"];
    _roomWidth = ds_map_find_value(ds_map_find_value(json_rooms, name), "roomSettings")[? "Width"];
    var _roomLoadCoordinatex = (room_width / 2) - (_roomWidth / 2);
    
    if (_tempSideWallFiller)
    {
        var _fillerYscale = roomLength / 16;
        
        with (instance_create_depth(-32, y, 0, oWall))
        {
            image_yscale = _fillerYscale;
            image_xscale = 3;
            y -= ((_fillerYscale * 16) / 2);
            y += 8;
        }
        
        with (instance_create_depth(192, y, 0, oWall))
        {
            image_yscale = _fillerYscale;
            image_xscale = 3;
            y -= ((_fillerYscale * 16) / 2);
            y += 8;
        }
    }
    
    y -= roomLength;
    room_pack_load_map(_roomIndexMap, _roomLoadCoordinatex, y + 16, global.room_pack_flag_instances);
    ds_map_destroy(json_rooms);
    
    if (_newAreaDiscovery != false)
    {
        with (instance_create_depth(80, y + 48, depth, oDiscoveryLine))
            areaIndex = _newAreaDiscovery;
    }
}
