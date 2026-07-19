with (parentEnemy)
    instance_destroy();

if (initialized)
{
    global.playerControlLock = 1;
    
    with (oPlayer)
        xsp = 0;
    
    switch (currentSequence)
    {
        case "template":
            if (sequenceInitialize())
            {
            }
            
            var _sequenceTime = 60;
            
            if (sequenceTimerIncrementAndCheck(_sequenceTime))
                nextSequence("gulp");
            
            break;
        
        case "gulp":
            if (sequenceInitialize())
            {
                beastGameStateChange("ending");
                timeScaleChange(0, 60, 1);
                timeScaleChange(1, 420, 0.01);
            }
            
            if (!instance_exists(oJuiceHomingParticleEmitter) || oPlayer.currentState == "ground")
            {
                _sequenceTime = 180;
                
                if (sequenceTimerIncrementAndCheck(_sequenceTime))
                    nextSequence("taste");
            }
            
            break;
        
        case "taste":
            if (sequenceInitialize())
            {
            }
            
            _sequenceTime = 240;
            
            if (sequenceTimerIncrementAndCheck(_sequenceTime))
            {
            }
            
            break;
        
        case "nudge player":
            if (sequenceInitialize())
            {
            }
            
            _sequenceTime = 240;
            
            if (sequenceTimerIncrementAndCheck(_sequenceTime))
                nextSequence("beam - appear");
            
            break;
        
        case "beam - appear":
            break;
        
        case "white out player visible":
            break;
        
        default:
            break;
    }
}
else
{
    initialized = 1;
}
