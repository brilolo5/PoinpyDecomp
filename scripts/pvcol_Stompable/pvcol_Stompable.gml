function pvcol_Stompable(arg0, arg1)
{
    var _target = instance_place(arg0, arg1, parentStompable);
    
    if (_target)
    {
        if (ysp > 0)
        {
            switch (_target.object_index)
            {
                case oPot:
                    slamTargetx = _target.x;
                    
                    if (currentState == "slamming" || currentState == "slamming - invincible")
                    {
                        playerEntityBounce(_target);
                        slamBounceBack();
                    }
                    else
                    {
                        addHitStop(12);
                        screenShake(3, 3);
                        playerEntityBounce(_target);
                    }
                    
                    playSoundPlayerSmashPot();
                    refillJump1();
                    
                    if (abilityCheck(UnknownEnum.Value_1))
                    {
                        playSoundAbilityOctopup();
                        fruitSuckInRadius = max(fruitSuckInRadius, fruitSuckInRadiusSlam);
                    }
                    
                    with (_target)
                    {
                        generateEffect(x, y, "temp white flash", 0);
                        generateEffect(x, y, "pot full animation", 0);
                        
                        if (abilityCheck(UnknownEnum.Value_8))
                        {
                            with (instance_create_depth(x, y, 0, oJuiceHomingParticleEmitter))
                            {
                                initialized = 1;
                                myAlarm0.alarmTimer = 9999;
                                myAlarm1.alarmTimer = 6;
                                spawnCount = 0;
                                emitterFruitNum = 0;
                                totalGold = choose_weighted(1, 85, 5, 14, 20, 1);
                            }
                        }
                        
                        instance_destroy();
                    }
                    
                    break;
                
                case oArcadeUnlockSwitch:
                    if (!_target.pressed)
                    {
                        playSoundHangingChairRopeBreak();
                        _target.pressed = 1;
                        generateEffect(x, y, "temp white flash", 0);
                        addHitStop(10);
                        screenShake(3, 3);
                        refillJump1();
                        playerEntityBounce();
                        ysp = -3;
                        playerStateChange("slam bounce");
                        global.puzzleModeUnlocked = 1;
                        saveGame();
                        
                        with (oLockedThinkingChair)
                            hanging = 0;
                        
                        saveGame();
                    }
                    else
                    {
                        return false;
                    }
                    
                    global.arcadeUnlock = 1;
                    break;
                
                case oGimJumpPad:
                    var _red = 0;
                    
                    if (_target.padAngle == 0)
                    {
                        _red = 1;
                        ysp = -6.5;
                        xsp = _target.image_xscale * 1.5;
                    }
                    else
                    {
                        ysp = -3.5;
                        xsp = _target.image_xscale * 3.5;
                    }
                    
                    if (global.wideGame)
                    {
                        if (_target.padAngle == 0)
                        {
                            ysp = -6.75;
                            xsp = _target.image_xscale * 1.75;
                        }
                        else
                        {
                            ysp = -4;
                            xsp = _target.image_xscale * 4.5;
                        }
                    }
                    
                    y = _target.bbox_top - 8;
                    x = _target.x;
                    playSoundJumpPadExplode();
                    noStompFor(12);
                    addHitStop(4);
                    generateEffect(_target.x, _target.y - 12, "jump pad bomb", _red);
                    screenShake(5, 5);
                    playerStateChange("invincible spin jump");
                    instance_destroy(_target);
                    break;
                
                case oAbilityMenuOpener:
                    ysp = -1.5;
                    xsp = 2;
                    playerStateChange("slam bounce");
                    instance_create_depth(x, y, 0, oAbilityEquipMenu);
                    break;
                
                case oGachaSwitch:
                    break;
                
                case oTrophyRoomSwitch:
                    if (currentState == "slamming")
                    {
                        x = _target.x - 32;
                        y = _target.y - 16;
                        xsp = 0;
                        ysp = 0;
                        playerStateChange("free");
                        instance_create_depth(x, y, 0, oTrophyMenu);
                    }
                    else
                    {
                        return false;
                    }
                    
                    break;
                
                case oPuzzleSwitch:
                    playerControlLock();
                    addHitStop(4);
                    xsp = -(x - _target.x) / 29;
                    ysp = -2;
                    y = _target.bbox_top - 4;
                    playerStateChange("slam bounce - chair");
                    myAlarm8.setTimer(75);
                    oPuzzleSwitch.satOn = 1;
                    break;
                
                default:
                    return false;
            }
            
            return true;
        }
    }
}
