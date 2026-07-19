function playerStateChange()
{
    var _nextState = argument[0];
    
    with (oPlayer)
    {
        if (currentState != "dead")
        {
            switch (_nextState)
            {
                case "puzzle failed":
                case "damage knocked":
                    if (damageInvincibility <= 0)
                        playerPickDamagedSprite();
                    
                    break;
                
                case "slam bounce":
                case "slam bounce - chair":
                    generateEffect(x, y, "temp white flash", 0);
                    slamImageIndex = 0;
                    slamBounceTimer = slamBounceTimerMax;
                    playSoundPlayerSlamTail();
                    break;
                
                case "free":
                case "free - chair":
                case "free - after spin":
                    audioSystemStopAsset(sfx_player_spin_med);
                    xscale = 1.3;
                    yscale = 0.7;
                    break;
                
                case "ground":
                case "ground - chair":
                    playSoundPlayerLand();
                    audioSystemStopAsset(sfx_player_spin_med);
                    xscale = 1.3;
                    yscale = 0.7;
                    break;
                
                case "invincible spin jump":
                    instance_create_depth(x, y, 0, oPlayerInvincibleTrail);
                    break;
                
                default:
                    break;
            }
            
            currentState = _nextState;
        }
    }
}
