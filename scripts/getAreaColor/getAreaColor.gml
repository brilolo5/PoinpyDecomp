function getAreaColor(arg0)
{
    var _result = array_create(5, undefined);
    
    switch (arg0)
    {
        case UnknownEnum.Value_1:
            array_set(_result, 0, 14933981);
            array_set(_result, 1, sBgLayer_VineBush_parts);
            array_set(_result, 2, sBgLayer_VineBush_parts);
            break;
        
        case UnknownEnum.Value_2:
            array_set(_result, 0, 7272880);
            array_set(_result, 1, undefined);
            array_set(_result, 2, sBgLayer_VineBush_parts);
            break;
        
        case UnknownEnum.Value_3:
            array_set(_result, 0, 16755277);
            array_set(_result, 1, sBgLayer_BubbleBackFog_parts);
            array_set(_result, 2, sBgLayer_BubbleFrontFog_parts);
            break;
        
        case UnknownEnum.Value_4:
            array_set(_result, 0, 6772297);
            array_set(_result, 1, sBgLayer_JumppadFar_parts);
            array_set(_result, 2, sBgLayer_JumppadFront_parts);
            break;
        
        case UnknownEnum.Value_5:
            array_set(_result, 0, 10904344);
            array_set(_result, 1, sBgLayer_CannonStars_parts);
            array_set(_result, 2, undefined);
            array_set(_result, 3, sBgLayer_CannonClouds_parts);
            array_set(_result, 4, sBgLayer_CannonStructure_parts);
            break;
        
        case UnknownEnum.Value_6:
            array_set(_result, 0, 6700046);
            array_set(_result, 1, 10904344);
            array_set(_result, 2, sBgLayer_CannonStars_parts);
            array_set(_result, 3, sBgLayer_CannonClouds_parts);
            array_set(_result, 4, undefined);
            break;
    }
    
    return _result;
}
