if (place_meeting(x, y, oPlayer))
{
    var _switchCount = 0;
    var _pressedCount = 0;
    
    with (oTutorialSlamSwitch)
    {
        if (position_meeting(x, y, other.id))
        {
            _switchCount += 1;
            
            if (pressed >= 1)
                _pressedCount += 1;
        }
    }
    
    if ((_switchCount > 0 && _switchCount == _pressedCount) || forceActivate)
    {
        playSoundButtonPressSpawnLevel();
        
        with (oTutorialPlatformSpawn)
        {
            if (place_meeting(x, y, other.id))
            {
                generateEffect(x, y, "temp white flash", 0);
                instance_create_depth(x, y, 0, oOnewayPlatform);
                
                if (room == rmTutorialMovement2)
                    instance_create_depth(x, y, 0, dFloorCloud);
                else
                    instance_create_depth(x, y, 0, dLevel00_GroundGrass);
                
                instance_destroy();
            }
        }
        
        with (oTutorialSlamSwitchSpawnMarker)
        {
            if (place_meeting(x, y, other.id))
            {
                generateEffect(x, y, "temp white flash", 0);
                instance_create_depth(x, y, 0, oTutorialSlamSwitch);
                instance_destroy();
            }
        }
        
        with (oTutorialWallSpawn)
        {
            if (place_meeting(x, y, other.id))
            {
                generateEffect(x, y, "temp white flash", 0);
                instance_create_depth(x, y, 0, oWall);
                instance_destroy();
            }
        }
        
        with (oTutorialSoftWallSpawn)
        {
            if (place_meeting(x, y, other.id))
            {
                generateEffect(x, y, "temp white flash", 0);
                instance_create_depth(x, y, 0, oSoftWall);
                instance_destroy();
            }
        }
        
        instance_destroy();
    }
}
