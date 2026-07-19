var _sideCheck = 0;

if (place_meeting(x + 1, y, oOnewayPlatform) || place_meeting(x + 1, y, parentWall))
    _sideCheck += 1;

if (place_meeting(x - 1, y, oOnewayPlatform) || place_meeting(x - 1, y, parentWall))
    _sideCheck += 2;

switch (_sideCheck)
{
    case 0:
        platformIndex[0] = sOnewayPlatformLeft;
        platformIndex[platformSize - 1] = sOnewayPlatformRight;
        
        if (platformSize <= 1)
            platformIndex[0] = sOnewayPlatformMiddle;
        
        break;
    
    case 1:
        platformIndex[0] = sOnewayPlatformLeft;
        break;
    
    case 2:
        platformIndex[platformSize - 1] = sOnewayPlatformRight;
        break;
    
    case 3:
        break;
}
