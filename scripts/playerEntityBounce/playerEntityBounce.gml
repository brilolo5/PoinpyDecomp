function playerEntityBounce()
{
    var _bounceTarget = -1;
    
    if (argument_count > 0)
    {
        _bounceTarget = argument[0];
    }
    else
    {
    }
    
    noStompFor(12);
    ysp = -3.5;
    addHitStop(6);
    
    if (currentState != "dead")
    {
        if (!(_bounceTarget && currentState == "spin jump"))
            currentState = "free";
        
        var _parent = (_bounceTarget != -1) ? object_get_parent(_bounceTarget.object_index) : noone;
        
        if (_parent == parentEnemy || _parent == parentStompable)
        {
            playSoundPlayerSlamBounce();
            
            if (abilityCheck(UnknownEnum.Value_9))
            {
                playSoundAbilityBouncySpring();
                ysp = -5.5;
            }
            
            playerStateChange("spin jump");
            entitySlamHitStop = 1;
            spinSpeed = 20;
        }
    }
    
    yscale = 0.6;
    xscale = 1.4;
    imgAngle = 0;
}
