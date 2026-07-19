var _targetWall;
myAlarm3.tick();
myAlarm4.tick();
myAlarm6.tick();
myAlarm7.tick();
myAlarm8.tick();
myAlarm9.tick();
myAlarm10.tick();
audio_listener_position(x, y, 0);
var gts = global.timeScale;

if (global.debugControl && keyboard_check_pressed(ord("D")))
    playerDamage(self);

if (bubbleIgnoreTimer > 0)
{
    bubbleIgnoreTimer -= gts;
    
    if (bubbleIgnoreTimer <= 0)
        myBubble = -4;
}

jumpPadFatigueTimer -= gts;
onewayBoostRecovery = approach(onewayBoostRecovery, 0, gts);
hitStop = max(0, hitStop - gts);

if (!hitStop)
{
    entitySlamHitStop = 0;
    
    switch (currentState)
    {
        case "template":
            launchNoGravityTime -= gts;
            ysp = approach(ysp, 16, (grv * gts) / 2);
            cx += (xsp * gts);
            var xspRounded = floor(abs(cx)) * sign(cx);
            cx -= xspRounded;
            
            repeat (abs(xspRounded))
            {
                if (phcol_Wall(x + sign(xspRounded), y))
                {
                    xsp *= -0.25;
                    break;
                }
                else
                {
                    x += sign(xspRounded);
                }
            }
            
            cy += (ysp * gts);
            var yspRounded = floor(abs(cy)) * sign(cy);
            cy -= yspRounded;
            
            repeat (abs(yspRounded))
            {
                if (pvcol_EnemyStomp(x, y + sign(yspRounded)))
                {
                    addHitStop(12);
                    screenShake(3, 3);
                    playerStateChange("slam bounce");
                    refillJump1();
                    break;
                }
                else if (pvcol_Wall(x, y + sign(yspRounded)) || pvcol_OnewayPlatform())
                {
                    if (sign(yspRounded) > 0)
                    {
                        playerComboPayout();
                        playerStateChange("ground");
                        refillJumpTimes(global.jumpTimesMax);
                    }
                    else
                    {
                        ysp = 1;
                    }
                    
                    break;
                }
                else
                {
                    y += sign(yspRounded);
                }
            }
            
            ysp = approach(ysp, 16, (grv * gts) / 2);
            playerEnemyCheck();
            playerHazardCheck();
            break;
        
        case "init asleep on beast":
            if (instance_exists(oBeastInLobby))
            {
                while (!place_meeting(x, y + 1, oBeastInLobby))
                    y += 1;
                
                currentState = "ground - asleep";
                playerPickSleepSprite();
            }
            
            break;
        
        case "init asleep on ground":
            var _whileLoopCheck = 0;
            
            while (!(place_meeting(x, y + 1, parentWall) || place_meeting(x, y + 1, oOnewayPlatform)))
            {
                y += 1;
                _whileLoopCheck += 1;
                
                if (_whileLoopCheck > 32)
                {
                    y = ystart;
                    break;
                }
            }
            
            currentState = "ground - puzzle prepare";
            
            if (_whileLoopCheck > 32)
                currentState = "free";
            
            break;
        
        case "init on ground":
            if (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom + 32, parentWall, 0, 1) || collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom + 32, oOnewayPlatform, 0, 1))
            {
                while (!pvcol_Wall(x, y + 1) && !pvcol_OnewayPlatform())
                    y += 1;
                
                currentState = "ground";
            }
            else
            {
                currentState = "free";
            }
            
            break;
        
        case "ground":
        case "ground - chair":
        case "ground - asleep":
            launchNoGravityTime -= gts;
            ysp = 0;
            cy = 0;
            cy = 0;
            cx += (xsp * gts);
            xspRounded = floor(abs(cx)) * sign(cx);
            cx -= xspRounded;
            
            repeat (abs(xspRounded))
            {
                if (phcol_Wall(x + sign(xspRounded), y))
                {
                    xsp = 0;
                    break;
                }
                else
                {
                    var _edgeThreshold = 14;
                    var _slideCheckPathAhead = instance_place(x + sign(xspRounded) + (sign(xspRounded) * _edgeThreshold), y + 1, parentWall) || instance_place(x + sign(xspRounded) + (sign(xspRounded) * _edgeThreshold), y + 1, oOnewayPlatform);
                    
                    if (!_slideCheckPathAhead || instance_place(x + sign(xspRounded) + (sign(xspRounded) * (_edgeThreshold * 1)), y + 1, parentEnemy))
                        xsp = 0;
                    else
                        xsp = approach(xsp, 0, 0.4);
                    
                    x += sign(xspRounded);
                }
            }
            
            cy += (ysp * gts);
            yspRounded = floor(abs(cy)) * sign(cy);
            cy -= yspRounded;
            
            if (!pvcol_Wall(x, y + 1) && !pvcol_OnewayPlatform())
                playerStateChange("free");
            
            ysp = 1;
            playerEnemyCheck();
            playerHazardCheck();
            break;
        
        case "puzzle failed":
            launchNoGravityTime -= gts;
            ysp = approach(ysp, 16, (grv * gts) / 2);
            cx += (xsp * gts);
            xspRounded = floor(abs(cx)) * sign(cx);
            cx -= xspRounded;
            
            repeat (abs(xspRounded))
            {
                if (phcol_Wall(x + sign(xspRounded), y))
                {
                    xsp *= -0.25;
                    break;
                }
                else
                {
                    x += sign(xspRounded);
                }
            }
            
            cy += (ysp * gts);
            yspRounded = floor(abs(cy)) * sign(cy);
            cy -= yspRounded;
            
            repeat (abs(yspRounded))
            {
                if (pvcol_Wall(x, y + sign(yspRounded)) || pvcol_OnewayPlatform())
                {
                    ysp *= -0.5;
                    break;
                }
                else
                {
                    y += sign(yspRounded);
                }
            }
            
            ysp = approach(ysp, 16, (grv * gts) / 2);
            break;
        
        case "free":
        case "free - after spin":
        case "free - chair":
        case "free - asleep":
            launchNoGravityTime -= gts;
            ysp = approach(ysp, 16, (grv * gts) / 2);
            cx += (xsp * gts);
            xspRounded = floor(abs(cx)) * sign(cx);
            cx -= xspRounded;
            
            if (audioVarPlayerFalling == 0)
                audioVarPlayerFalling = 1;
            
            repeat (abs(xspRounded))
            {
                if (phcol_Wall(x + sign(xspRounded), y))
                {
                    xsp *= -0.25;
                    break;
                }
                else
                {
                    x += sign(xspRounded);
                }
            }
            
            cy += (ysp * gts);
            yspRounded = floor(abs(cy)) * sign(cy);
            cy -= yspRounded;
            
            repeat (abs(yspRounded))
            {
                if (pvcol_Wall(x, y + sign(yspRounded)) || pvcol_OnewayPlatform())
                {
                    if (yspRounded > 0)
                    {
                        if (playerComboPayout())
                        {
                        }
                        else if (currentState == "free - chair")
                        {
                            playerPickPuzzleChairSprite();
                            playerStateChange("ground - chair");
                            x = oPuzzleSwitch.x;
                            xsp = 0;
                        }
                        else
                        {
                            playerStateChange("ground");
                        }
                        
                        refillJumpTimes(global.jumpTimesMax);
                    }
                    else
                    {
                        addHitStop(2);
                        ysp = 1;
                    }
                    
                    break;
                }
                else if (pvcol_EnemyStomp(x, y + sign(yspRounded)))
                {
                    addHitStop(12);
                    screenShake(3, 3);
                    refillJump1();
                    break;
                }
                else if (pvcol_Stompable(x, y + sign(yspRounded)))
                {
                    break;
                }
                else
                {
                    y += sign(yspRounded);
                }
            }
            
            ysp = approach(ysp, 16, (grv * gts) / 2);
            playerEnemyCheck();
            playerHazardCheck();
            pcol_Bubble(x, y);
            pcol_Cannon(x, y);
            break;
        
        case "slam bounce":
        case "slam bounce - chair":
            launchNoGravityTime -= gts;
            ysp = approach(ysp, 16, (grv * gts) / 2);
            cx += (xsp * gts);
            xspRounded = floor(abs(cx)) * sign(cx);
            cx -= xspRounded;
            
            repeat (abs(xspRounded))
            {
                if (phcol_Wall(x + sign(xspRounded), y))
                {
                    xsp *= -0.25;
                    break;
                }
                else
                {
                    x += sign(xspRounded);
                }
            }
            
            cy += (ysp * gts);
            yspRounded = floor(abs(cy)) * sign(cy);
            cy -= yspRounded;
            
            repeat (abs(yspRounded))
            {
                if (pvcol_Wall(x, y + sign(yspRounded)) || pvcol_OnewayPlatform())
                {
                    if (sign(yspRounded) > 0)
                    {
                        playerComboPayout();
                        playerStateChange("ground");
                        refillJumpTimes(global.jumpTimesMax);
                    }
                    else
                    {
                        ysp = 1;
                    }
                    
                    break;
                }
                else if (pvcol_EnemyStomp(x, y + sign(yspRounded)))
                {
                    break;
                }
                else if (pvcol_Stompable(x, y + sign(yspRounded)))
                {
                    break;
                }
                else
                {
                    y += sign(yspRounded);
                }
            }
            
            ysp = approach(ysp, 16, (grv * gts) / 2);
            
            if (!--slamBounceTimer)
            {
                if (currentState == "slam bounce - chair")
                    playerStateChange("free - chair");
                else
                    playerStateChange("free");
            }
            
            playerEnemyCheck();
            playerHazardCheck();
            break;
        
        case "spin jump":
            launchNoGravityTime -= gts;
            
            if (!launchNoGravityTime)
                ysp = approach(ysp, 16, (grv * gts) / 2);
            
            cx += (xsp * gts);
            xspRounded = floor(abs(cx)) * sign(cx);
            cx -= xspRounded;
            
            repeat (abs(xspRounded))
            {
                if (phcol_Wall(x + sign(xspRounded), y))
                {
                    if (!phcol_CogBoostWall(x + sign(xspRounded), y))
                        phcol_WallJump(x + sign(xspRounded), y);
                    
                    break;
                }
                else if (intentionalSlide && slideChargeTimer > 0)
                {
                    slideChargeTimer = approach(slideChargeTimer, 0, 0.005555555555555556);
                    
                    if (slideChargeTimer <= 0)
                        playSoundPlayerSkidRelease();
                }
                else
                {
                    x += sign(xspRounded);
                }
            }
            
            var groundCollision = 0;
            var bounce = 0;
            cy += (ysp * gts);
            yspRounded = floor(abs(cy)) * sign(cy);
            cy -= yspRounded;
            
            repeat (abs(yspRounded))
            {
                if (pvcol_Wall(x, y + sign(yspRounded)) || pvcol_OnewayPlatform())
                {
                    if (!intentionalSlide)
                    {
                        if (yspRounded > 0)
                        {
                            if (playerComboPayout())
                            {
                            }
                            else
                            {
                                playerStateChange("ground");
                            }
                            
                            refillJumpTimes(global.jumpTimesMax);
                        }
                        else
                        {
                            playSoundPlayerBonkHead();
                            addHitStop(4);
                            screenShake(2, 3);
                            ysp = 1;
                        }
                        
                        break;
                    }
                    else
                    {
                        var _smokeDir = point_direction(0, 0, -xsp, 0);
                        
                        with (generateEffect(x, y + 4, "general smoke", _smokeDir))
                        {
                            grav = -0.1;
                            imageAngle = random(360);
                        }
                        
                        ysp = 0;
                        break;
                    }
                }
                else if (pvcol_EnemyStomp(x, y + sign(yspRounded)))
                {
                    addHitStop(12);
                    screenShake(3, 3);
                    refillJump1();
                    break;
                }
                else if (pvcol_Stompable(x, y + sign(yspRounded)))
                {
                    break;
                }
                else
                {
                    y += sign(yspRounded);
                    intentionalSlide = 0;
                }
            }
            
            ysp = approach(ysp, 16, (grv * gts) / 2);
            playerEnemyCheck();
            playerHazardCheck();
            pcol_Bubble(x, y);
            pcol_Cannon(x, y);
            break;
        
        case "invincible spin jump":
            launchNoGravityTime -= gts;
            
            if (!launchNoGravityTime)
                ysp = approach(ysp, 16, (grv * gts) / 2);
            
            cx += (xsp * gts);
            xspRounded = floor(abs(cx)) * sign(cx);
            cx -= xspRounded;
            
            repeat (abs(xspRounded))
            {
                if (phcol_Wall(x + sign(xspRounded), y))
                {
                    if (!phcol_CogBoostWall(x + sign(xspRounded), y))
                    {
                        if (phcol_WallJump(x + sign(xspRounded), y))
                        {
                            addHitStop(12);
                            screenShake(4, 4);
                        }
                    }
                    
                    break;
                }
                else
                {
                    x += sign(xspRounded);
                }
            }
            
            groundCollision = 0;
            bounce = 0;
            cy += (ysp * gts);
            yspRounded = floor(abs(cy)) * sign(cy);
            cy -= yspRounded;
            
            repeat (abs(yspRounded))
            {
                if (pvcol_Wall(x, y + sign(yspRounded)) || pvcol_OnewayPlatform())
                {
                    if (yspRounded > 0)
                    {
                        if (!playerComboPayout())
                            playerStateChange("ground");
                        
                        refillJumpTimes(global.jumpTimesMax);
                    }
                    else
                    {
                        addHitStop(6);
                        screenShake(2, 3);
                        ysp = 0;
                    }
                    
                    break;
                }
                else if (pvcol_EnemyStomp(x, y + sign(yspRounded), true))
                {
                    addHitStop(12);
                    screenShake(3, 3);
                    playerStateChange("invincible spin jump");
                    refillJump1();
                    break;
                }
                else if (pvcol_Stompable(x, y + sign(yspRounded)))
                {
                    playerStateChange("invincible spin jump");
                    break;
                }
                else
                {
                    y += sign(yspRounded);
                }
            }
            
            ysp = approach(ysp, 16, (grv * gts) / 2);
            var touchEnemy = instance_place(x, y, parentEnemy);
            
            if (touchEnemy)
            {
                enemyKillInInvincibilityEffect(touchEnemy);
                
                with (touchEnemy)
                {
                    audioEventEnemyStomped();
                    stomped = 1;
                    instance_destroy();
                }
                
                noStompFor(12);
                refillJump1();
            }
            
            playerHazardCheck(true);
            pcol_Bubble(x, y);
            pcol_Cannon(x, y);
            break;
        
        case "slamming - invincible":
        case "slamming":
            ysp = tapThrustSpeed;
            cx += (xsp * gts);
            xspRounded = floor(abs(cx)) * sign(cx);
            cx -= xspRounded;
            
            repeat (abs(xspRounded))
            {
                var targetWall = instance_place(x + sign(xspRounded), y, parentWall);
                
                if (targetWall == -4)
                    x += sign(xspRounded);
                else
                    break;
            }
            
            groundCollision = 0;
            bounce = 0;
            cy += (ysp * gts);
            yspRounded = floor(abs(cy)) * sign(cy);
            cy -= yspRounded;
            var _invincibleSlam = currentState == "slamming - invincible";
            
            repeat (abs(yspRounded))
            {
                if (pcol_Fruit(x, y))
                {
                }
                
                if (pcol_Bubble(x, y))
                    break;
                
                if (pcol_Cannon(x, y))
                    break;
                
                if (room == rmPlayableMainMenu)
                {
                    var _targetBouncyWall = instance_place(x, y + 1, oBouncyWall);
                    
                    if (_targetBouncyWall && !place_meeting(x, y, oBouncyWall))
                    {
                        _targetBouncyWall.ysp = clamp(ysp, -5, 5);
                        _targetBouncyWall.xsp = (x - _targetBouncyWall.x) / 75;
                    }
                    
                    _targetBouncyWall = instance_place(x, y + 1, oBouncySwitch);
                    
                    if (_targetBouncyWall && !place_meeting(x, y, oBouncySwitch))
                    {
                        with (_targetBouncyWall)
                        {
                            ysp = switchTravelLength;
                            var _randomPickArray = get3RandomizedAbility();
                            var _randomPickArrayLength = array_length(_randomPickArray);
                            
                            if (global.moneyJar >= getGachaCost() && _randomPickArray[0] != -1)
                            {
                                if (!pressed)
                                {
                                    playSoundLeverDown();
                                    getMoneyWithAnimation(-getGachaCost());
                                    shownMoneyAmountUpdate();
                                    playerControlLock();
                                    pressed = 1;
                                    origy += switchTravelLength;
                                    myAlarm3.setTimer(12);
                                    myAlarm1.setTimer(60);
                                }
                            }
                            else
                            {
                                playSoundLeverNotEnoughCoins();
                                noMoneyAlarmShake = 1;
                                curvePos = 0;
                            }
                        }
                    }
                    
                    _targetWall = instance_place(x, y + 1, oBeastInLobby);
                    
                    if (_targetWall && !instance_place(x, y, oBeastInLobby))
                    {
                        if (initialBonkPause)
                        {
                            instance_destroy(oLobbyBeastStompPrompt);
                            sleep(10);
                            addHitStop(1);
                            screenShake(5, 3);
                            y += 16;
                            
                            with (_targetWall)
                            {
                                breathState = "bonked";
                                beastFaceIndex = 0;
                                beastFaceSprite = sBeastPart_FaceSurpriseBonked;
                                breathStateSwitchDelayTimer = 0;
                            }
                            
                            _targetWall.y += 16;
                            generateEffect(x, y, "temp white flash in timescale", 0);
                            initialBonkPause = 0;
                            break;
                        }
                        else
                        {
                            playSoundBeastLobbyBonk();
                            _targetWall.image_index = 2;
                            _targetWall.pressed = 1;
                            _targetWall.ysp = 12;
                            playerEntityBounce();
                            addHitStop(13);
                            screenShake(3, 3);
                            refillJumpTimes(global.jumpTimesMax);
                            global.playerControlLock = 1;
                            myAlarm3.setTimer(1);
                            ysp = -14;
                            myAlarm4.setTimer(72);
                        }
                        
                        break;
                    }
                }
                
                _targetWall = instance_place(x, y + 1, oTutorialSlamSwitch);
                
                if (_targetWall && !place_meeting(x, y, _targetWall))
                {
                    with (_targetWall)
                    {
                        playSoundPlayerButtonPress();
                        pressed = 1;
                        mask_index = mask_nomask;
                        generateEffect(x, bbox_bottom, "temp white flash", 0);
                    }
                    
                    addHitStop(10);
                    screenShake(3, 3);
                    refillJump1();
                    playerEntityBounce();
                    ysp = -3;
                    playerStateChange("slam bounce");
                    addHitStop(6);
                    break;
                }
                
                if (pvcol_Wall(x, y + sign(yspRounded)) || pvcol_OnewayPlatform())
                {
                    var _target = instance_place(x, y + 1, oLaunchSwitchCase);
                    
                    if (_target)
                    {
                        with (_target)
                            stomped = 1;
                    }
                    
                    ysp = -3;
                    
                    if (abilityCheck(UnknownEnum.Value_9))
                    {
                        playSoundAbilityBouncySpring();
                        ysp = -4.5;
                    }
                    
                    addHitStop(10);
                    screenShake(4, 3);
                    playerComboPayout();
                    playerStateChange("slam bounce");
                    refillJumpTimes(global.jumpTimesMax);
                    generateEffect(x, y, "slam land", 0);
                    break;
                }
                else if (pvcol_EnemyStomp(x, y + sign(yspRounded), _invincibleSlam))
                {
                    if (currentState != "damage knocked")
                        slamBounceBack();
                    
                    refillJump1();
                    
                    if (_invincibleSlam)
                    {
                        sleep(4);
                        addHitStop(12);
                        screenShake(6, 6);
                        playerStateChange("invincible spin jump");
                    }
                    
                    break;
                }
                else if (pvcol_Stompable(x, y + sign(yspRounded)))
                {
                    if (_invincibleSlam)
                        playerStateChange("invincible spin jump");
                    
                    break;
                }
                else if (slamFruitSquash && (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom + 8, parentWall, 0, 0) || (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom + 8, oOnewayPlatform, 0, 0) && !place_meeting(x, y, oOnewayPlatform))) && !collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom + 8, parentEnemy, 0, 0))
                {
                    var _freezeDistance = 8;
                    
                    if (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom + _freezeDistance, parentWall, 0, 0) || (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom + _freezeDistance, oOnewayPlatform, 0, 0) && !place_meeting(x, y, oOnewayPlatform)))
                    {
                        cy = 0;
                        var slamImpactStopFrames = 2;
                        slamImpactGameStopInterval = slamImpactStopFrames + 1;
                        timeScaleChange(0, slamImpactStopFrames, 1);
                        timeScaleChange(1, slamImpactStopFrames + 1, 1);
                        slamFruitSquash -= doDelta(1);
                        
                        repeat (2)
                        {
                            with (generateEffect(x, y, "temp juice splash", 0))
                                setColor = make_color_rgb(255, 255, 255);
                        }
                        
                        exit;
                    }
                }
                else
                {
                    y += sign(yspRounded);
                }
            }
            
            slamImpactGameStopInterval -= 1;
            playerHazardCheck(_invincibleSlam);
            break;
        
        case "oneway boost":
            launchNoGravityTime -= gts;
            ysp = approach(ysp, 16, (grv * gts) / 2);
            cx += (xsp * gts);
            xspRounded = floor(abs(cx)) * sign(cx);
            cx -= xspRounded;
            
            repeat (abs(xspRounded))
            {
                if (phcol_Wall(x + sign(xspRounded), y))
                {
                    xsp *= -0.25;
                    break;
                }
                else
                {
                    x += sign(xspRounded);
                }
            }
            
            cy += (ysp * gts);
            yspRounded = floor(abs(cy)) * sign(cy);
            cy -= yspRounded;
            
            repeat (abs(yspRounded))
            {
                if (pvcol_EnemyStomp(x, y + sign(yspRounded)))
                {
                    addHitStop(12);
                    screenShake(3, 3);
                    playerStateChange("slam bounce");
                    refillJump1();
                    break;
                }
                else if (pvcol_Wall(x, y + sign(yspRounded)) || pvcol_OnewayPlatform())
                {
                    if (sign(yspRounded) > 0)
                    {
                        playerComboPayout();
                        playerStateChange("ground");
                        refillJumpTimes(global.jumpTimesMax);
                    }
                    else
                    {
                        ysp = 1;
                    }
                    
                    break;
                }
                else
                {
                    y += sign(yspRounded);
                }
            }
            
            ysp = approach(ysp, 16, (grv * gts) / 2);
            playerEnemyCheck();
            playerHazardCheck();
            break;
        
        case "cog cling":
            if (place_meeting(x + wallClingDirection, y, oCogWall))
            {
                if (ysp > -3)
                    ysp = -3;
                
                ysp = approach(ysp, -5, 0.25);
                cy += (ysp * gts);
                yspRounded = floor(abs(cy)) * sign(cy);
                cy -= yspRounded;
                
                repeat (abs(yspRounded))
                {
                    var targetWall = instance_place(x, y + sign(yspRounded), parentWall);
                    
                    if (targetWall)
                    {
                        ysp = 0;
                        jumpThrust = 0;
                        spinSpeed = -10;
                        xsp = 1 * -wallClingDirection;
                        playerStateChange("free - after spin");
                        screenShake(3, 3);
                        addHitStop(2);
                        break;
                    }
                    
                    if (!targetWall && place_meeting(x + wallClingDirection, y, oCogWall))
                        y += sign(yspRounded);
                }
            }
            else
            {
                playSoundPlayerVineRollTail();
                playSoundPlayerVineFlower();
                playerStateChange("free - after spin");
                _targetWall = instance_place(x + wallClingDirection, y + 8, oCogWall);
                
                if (_targetWall && !_targetWall.flowerOpen)
                {
                    with (_targetWall)
                        flowerOpen = 1;
                    
                    y = _targetWall.bbox_top;
                }
                
                ysp = -4;
                xsp = -wallClingDirection * 1.75;
                addHitStop(4);
                screenShake(3, 3);
            }
            
            touchEnemy = instance_place(x, y, parentEnemy);
            
            if (touchEnemy)
            {
                with (touchEnemy)
                {
                    stomped = 1;
                    instance_destroy();
                }
                
                addHitStop(6);
                screenShake(3, 2);
                refillJump1();
            }
            
            break;
        
        case "in bubble":
            bubbleIgnoreTimer = bubbleIgnoreTimerMax;
            xsp = 0;
            ysp = 0;
            
            if (instance_exists(myBubble))
            {
                x = myBubble.x;
                y = myBubble.y;
                cx = myBubble.cx;
                cy = myBubble.cy;
                touchEnemy = instance_place(x, y, parentEnemy);
                
                if (touchEnemy)
                {
                    with (touchEnemy)
                    {
                        stomped = 1;
                        instance_destroy();
                    }
                    
                    addHitStop(6);
                    screenShake(3, 2);
                }
            }
            else
            {
                playerStateChange("free");
            }
            
            break;
        
        case "in cannon":
            launchNoGravityTime -= gts;
            ysp = 0;
            xsp = 0;
            var _cannonTipLength = 18;
            var _cannonTipx = myCannon.x + lengthdir_x(_cannonTipLength, myCannon.cannonAngle + 90);
            var _cannonTipy = myCannon.y + lengthdir_y(_cannonTipLength, myCannon.cannonAngle + 90);
            x = _cannonTipx;
            y = _cannonTipy;
            playerEnemyCheck();
            playerHazardCheck();
            break;
        
        case "in-wall boost":
            var _boostSpeed = -5.5;
            
            if (place_meeting(x, y, parentWall))
            {
                ysp = _boostSpeed * 1.25;
                cy += (ysp * gts);
                yspRounded = floor(abs(cy)) * sign(cy);
                cy -= yspRounded;
                
                repeat (abs(yspRounded))
                {
                    if (!place_meeting(x, y, parentWall))
                        break;
                    
                    y += sign(yspRounded);
                }
            }
            else
            {
                spinSpeed = 30;
                ysp = _boostSpeed;
                xsp = 0;
                addHitStop(4);
                screenShake(3, 3);
                playerStateChange("spin jump");
                audioVarSpin = 0;
            }
            
            playerHazardCheck();
            break;
        
        case "stuck":
            xsp = 0;
            ysp = (ysp > -2) ? -2 : -4;
            xsp = 1 * -wallClingDirection;
            playerStateChange("free");
            ysp = approach(ysp, 0, 0.5);
            cy += (ysp * gts);
            yspRounded = floor(abs(cy)) * sign(cy);
            cy -= yspRounded;
            
            repeat (abs(yspRounded))
            {
                if (pvcol_EnemyStomp(x, y + sign(yspRounded)))
                {
                    addHitStop(12);
                    screenShake(3, 3);
                    playerStateChange("slam bounce");
                    refillJump1();
                    break;
                }
                else if (pvcol_Wall(x, y + sign(yspRounded)) || pvcol_OnewayPlatform())
                {
                    if (sign(yspRounded) > 0)
                    {
                        playerComboPayout();
                        playerStateChange("ground");
                        refillJumpTimes(global.jumpTimesMax);
                    }
                    else
                    {
                        ysp = 1;
                    }
                    
                    break;
                }
                else
                {
                    y += sign(yspRounded);
                }
            }
            
            playerEnemyCheck();
            playerHazardCheck();
            break;
        
        case "damage knocked":
            ysp = approach(ysp, 16, (grv * gts) / 2);
            cx += (xsp * gts);
            xspRounded = floor(abs(cx)) * sign(cx);
            cx -= xspRounded;
            
            repeat (abs(xspRounded))
            {
                if (phcol_Wall(x + sign(xspRounded), y))
                {
                    xsp *= -0.25;
                    break;
                }
                else
                {
                    x += sign(xspRounded);
                }
            }
            
            cy += (ysp * gts);
            yspRounded = floor(abs(cy)) * sign(cy);
            cy -= yspRounded;
            
            repeat (abs(yspRounded))
            {
                if (pvcol_Wall(x, y + sign(yspRounded)) || pvcol_OnewayPlatform())
                {
                    if (yspRounded > 0)
                    {
                        if (playerComboPayout())
                        {
                        }
                        else
                        {
                            playerStateChange("ground");
                        }
                        
                        refillJumpTimes(global.jumpTimesMax);
                    }
                    else
                    {
                        addHitStop(2);
                        ysp = 1;
                    }
                    
                    break;
                }
                else if (pvcol_EnemyStomp(x, y + sign(yspRounded)))
                {
                    addHitStop(12);
                    screenShake(3, 3);
                    refillJump1();
                    break;
                }
                else if (pvcol_Stompable(x, y + sign(yspRounded)))
                {
                    break;
                }
                else
                {
                    y += sign(yspRounded);
                }
            }
            
            ysp = approach(ysp, 16, (grv * gts) / 2);
            playerEnemyCheck();
            playerHazardCheck();
            pcol_Bubble(x, y);
            pcol_Cannon(x, y);
            break;
        
        case "dead":
            global.jumpTimes = 0;
            
            if (!grounded)
                ysp = approach(ysp, 8, (grv * gts) / 2);
            
            cx += (xsp * gts);
            xspRounded = floor(abs(cx)) * sign(cx);
            cx -= xspRounded;
            
            repeat (abs(xspRounded))
            {
                var targetWall = instance_place(x + sign(xspRounded), y, parentWall);
                
                if (targetWall == -4)
                {
                    x += sign(xspRounded);
                }
                else
                {
                    xsp *= -0.25;
                    break;
                }
            }
            
            groundCollision = 0;
            bounce = 0;
            cy += (ysp * gts);
            yspRounded = floor(abs(cy)) * sign(cy);
            cy -= yspRounded;
            
            repeat (abs(yspRounded))
            {
                var targetWall = instance_place(x, y + sign(yspRounded), parentWall);
                targetEnemy = instance_place(x, y + sign(yspRounded), parentEnemy);
                
                if (!targetWall)
                    targetWall = checkOnewayPlatform();
                
                if (targetWall)
                {
                    if (ysp >= 0)
                    {
                        groundCollision = 1;
                        playerComboPayout();
                    }
                    
                    if (ysp > 1)
                        ysp *= -0.4;
                    else
                        ysp = 0;
                    
                    cy = 0;
                    break;
                }
                else if (pvcol_EnemyStomp(x, y + sign(yspRounded)))
                {
                    break;
                }
                
                if (!targetWall)
                    y += sign(yspRounded);
            }
            
            var landed = 0;
            
            if (instance_place(x, y + 1, parentWall) || checkOnewayPlatform())
            {
                if (!grounded)
                    landed = 1;
                
                grounded = 1;
                xsp = approach(xsp, 0, fric * gts);
                
                if (currentState == "dead")
                    deathResetTimer = min(deathResetTimer, 30);
            }
            else
            {
                grounded = 0;
            }
            
            if (landed)
            {
            }
            
            if (!grounded)
                ysp = approach(ysp, 8, (grv * gts) / 2);
            
            var _deathTimerDecreaseBy = 1;
            
            if (global.orderChecklistFilled)
                _deathTimerDecreaseBy = 1/3;
            
            deathResetTimer = approach(deathResetTimer, 0, _deathTimerDecreaseBy * gts);
            
            if ((deathResetTimer <= 0 && !instance_exists(oResultsScreen)) && global.difficultyLevel < 25)
            {
                if (abilityCheck(UnknownEnum.Value_22))
                {
                    if (grounded)
                    {
                        resurrectionEffect(sItem_endless_mode);
                        global.lifePoint = 1;
                        addHitStop(4);
                        screenShake(3, 3);
                        playerControlLockTimer(8);
                        refillJumpTimes();
                        playerComboPayout();
                        currentState = "ressurection";
                        playerStateChange("slam bounce");
                        slamImageIndex = 0;
                        slamBounceTimer = slamBounceTimerMax;
                        playerEntityBounce();
                        deathResetTimer = deathResetTimerDefault;
                    }
                }
                else
                {
                    instance_create_depth(x, y, 0, oResultsScreen);
                }
            }
            
            playerHazardCheck();
            playerEnemyCheck();
            break;
        
        case "beast bonk launch":
            cy += (ysp * gts);
            yspRounded = floor(abs(cy)) * sign(cy);
            cy -= yspRounded;
            
            repeat (abs(yspRounded))
                y += sign(yspRounded);
            
            break;
        
        default:
            break;
    }
    
    var _interactibleGimmick = instance_place(x, y, parentInteractibleGimmick);
    
    if (_interactibleGimmick)
    {
        switch (_interactibleGimmick.object_index)
        {
            case oTouchTimerSpawner:
                with (_interactibleGimmick)
                {
                    if (!cracked)
                    {
                        crackFlash = 4;
                        cracked = 1;
                    }
                    
                    crackTimer = 0;
                }
                
                break;
            
            default:
                break;
        }
    }
    
    if (y > (global.unloadLevelArea_y - 160))
    {
        y = global.unloadLevelArea_y - 160;
        playerEntityBounce();
        addHitStop(12);
        screenShake(3, 3);
        xsp = 0;
        playerComboPayout();
        playerStateChange("slam bounce");
        refillJumpTimes(global.jumpTimesMax);
    }
}

damageInvincibility -= gts;
damageInvincibilityFlash -= gts;

if ((currentState == "spin jump" || currentState == "invincible spin jump") && abilityCheck(UnknownEnum.Value_3))
    fruitSuckInRadius = max(fruitSuckInRadius, fruitSuckInRadiusScoop);

collision_circle_list(x, y, fruitSuckInRadius, oFruit, 1, 1, fruitVicinityList, true);
ds_list_sort(fruitVicinityList, true);
var _fruitVicinityListSize = ds_list_size(fruitVicinityList);

if (_fruitVicinityListSize > 0)
{
    var _bannedFruitList = global.bannedFruitList;
    var _bannedFruitListSize = ds_list_size(global.bannedFruitList);
    
    for (var i = 0; i < _fruitVicinityListSize; i += 1)
    {
        while (i < (_fruitVicinityListSize - 1))
        {
            if (fruitVicinityList[| i] == fruitVicinityList[| i + 1])
            {
                ds_list_delete(fruitVicinityList, i + 1);
                _fruitVicinityListSize = ds_list_size(fruitVicinityList);
                
                if (i < _fruitVicinityListSize)
                    break;
            }
            else
            {
                break;
            }
        }
        
        var _bannedCheck = 0;
        
        for (var t = 0; t < _bannedFruitListSize; t += 1)
        {
            if (instance_exists(fruitVicinityList[| i]))
            {
                var _fruitType = fruitVicinityList[| i].fruitType;
                
                if (_fruitType == _bannedFruitList[| t])
                {
                    ds_list_delete(fruitVicinityList, i);
                    _bannedCheck = 1;
                    break;
                }
            }
        }
        
        if (!_bannedCheck)
        {
            if (instance_exists(fruitVicinityList[| i]))
            {
                with (fruitVicinityList[| i])
                {
                    if (!noGet && !suckResist)
                    {
                        if (!gettingSuckedIn)
                        {
                            var _parseSprite = sprIndex;
                            
                            with (instance_create_depth(x, y, 0, effectFruitSuckIn))
                                spriteIndex = _parseSprite;
                            
                            image_alpha = 0;
                        }
                        
                        gettingSuckedIn += 1;
                        var suckInRate = 0.2 + (gettingSuckedIn * 0.1);
                        x = deltaLerp(x, other.x, suckInRate);
                        y = deltaLerp(y, other.y, suckInRate);
                    }
                }
            }
            else
            {
                ds_list_delete(fruitVicinityList, i);
                i -= 1;
            }
        }
        
        _fruitVicinityListSize = ds_list_size(fruitVicinityList);
    }
}

fruitSuckInRadius = deltaLerp(fruitSuckInRadius, fruitSuckInRadiusDefault, 0.2);
pcol_Fruit(x, y);

switch (currentState)
{
    case "ground - asleep":
        sprite_index = sPlayerGroundAsleep;
        image_speed = 0;
        break;
    
    case "ground - puzzle prepare":
        sprite_index = sPlayerGroundPuzzleChair;
        image_speed = 0;
        image_speed = 0;
        
        if (oCamera.puzzleScrollMode)
            image_index = 3;
        else
            image_index = 2;
        
        if (global.puzzleMusicIntroPlay == UnknownEnum.Value_3 && getPlayerControlLock())
            image_index = 3;
        
        if (room == rmPlayableMainMenu)
            image_index = 3;
        
        break;
    
    case "ground - chair":
        sprite_index = sPlayerGroundPuzzleChair;
        
        if (instance_exists(oTE_circleCloseOnPlayer))
        {
            puzzleEyeTimer += doDelta(1/15);
            
            if (puzzleEyeTimer >= 1)
                image_index = 3;
        }
        
        xDirection = 1;
        break;
    
    case "ground":
        if (xsp != 0)
            xDirection = sign(xsp);
        
        sprite_index = sPlayerGround;
        image_index = 4;
        break;
    
    case "slamming":
        slamVisualTimer = 30;
        sprite_index = sPlayerSlam;
        
        if (!hitStop)
            slamImageIndex = min(3, slamImageIndex + (0.6 * gts));
        
        image_index = slamImageIndex;
        break;
    
    case "slamming - invincible":
        slamVisualTimer = 30;
        sprite_index = sPlayerSlam;
        
        if (!hitStop)
            slamImageIndex = min(3, slamImageIndex + (0.6 * gts));
        
        image_index = slamImageIndex;
        whiteFlash = 1;
        break;
    
    case "slam bounce":
    case "slam bounce - chair":
        if (hitStop)
            slamImageIndex = 5;
        else
            slamImageIndex = 4;
        
        sprite_index = sPlayerSlam;
        image_index = slamImageIndex;
        break;
    
    case "free":
    case "free - chair":
        sprite_index = sPlayerSpin16;
        image_index = 0;
        break;
    
    case "damage knocked":
        xDirection = sign(xsp + 0.01);
        sprite_index = sPlayerDamage;
        break;
    
    case "puzzle failed":
        xDirection = sign(xsp + 0.01);
        sprite_index = sPlayerDamage;
        break;
    
    case "dead":
        xDirection = sign(xsp + 0.01);
        sprite_index = sPlayerDead;
        image_index = 0;
        break;
    
    case "free - after spin":
        sprite_index = sPlayerSpin16;
        
        if (!hitStop)
        {
            var _lerpRate = 0.06;
            spinSpeed = lerp(spinSpeed, 0, _lerpRate * gts);
            spinSpeedFinal = spinSpeed * gts;
            spinSpeedFinal *= 2;
            var _clampTo = 157.5;
            imgAngle = clamp(imgAngle, _clampTo, 9999);
            _lerpRate = 0.075;
            imgAngle = lerp(imgAngle, 405, _lerpRate * gts);
        }
        
        sprite_index = sPlayerSpin16;
        var spinImgIndex = floor(imgAngle / 22.5);
        image_index = spinImgIndex;
        break;
    
    case "spin jump":
    case "beast bonk launch":
        if (xsp != 0)
            xDirection = sign(xsp);
        
        spinSpeed = 35;
        spinSpeedFinal = spinSpeed * gts;
        spinSpeedFinal *= 2;
        
        if (!hitStop)
            imgAngle += spinSpeedFinal;
        
        if (imgAngle > 360)
            imgAngle -= 360;
        else if (imgAngle < 0)
            imgAngle += 360;
        
        
        if (global.timeScale >= 0.6)
        {
            sprite_index = sPlayerSpin8;
            spinImgIndex = floor((imgAngle / 45) + 0.5);
        }
        else
        {
            sprite_index = sPlayerSpin16;
            spinImgIndex = imgAngle / 22.5;
        }
        
        image_index = spinImgIndex;
        
        if (entitySlamHitStop)
        {
            sprite_index = sPlayerSlam;
            image_index = 4;
        }
        
        break;
    
    case "invincible spin jump":
        if (xsp != 0)
            xDirection = sign(xsp);
        
        spinSpeed = 35;
        spinSpeedFinal = spinSpeed * gts;
        spinSpeedFinal *= 2;
        
        if (!hitStop)
            imgAngle += spinSpeedFinal;
        
        if (imgAngle > 360)
            imgAngle -= 360;
        else if (imgAngle < 0)
            imgAngle += 360;
        
        
        if (global.timeScale >= 0.6)
        {
            sprite_index = sPlayerSpin8;
            spinImgIndex = floor((imgAngle / 45) + 0.5);
        }
        else
        {
            sprite_index = sPlayerSpin16;
            spinImgIndex = imgAngle / 22.5;
        }
        
        whiteFlash = 1;
        image_index = spinImgIndex;
        break;
    
    case "cog cling":
        spinSpeed = 16;
        spinSpeedFinal = spinSpeed * gts;
        spinSpeedFinal *= 2;
        
        if (!hitStop)
            imgAngle += spinSpeedFinal;
        
        if (imgAngle > 360)
            imgAngle -= 360;
        else if (imgAngle < 0)
            imgAngle += 360;
        
        
        if (global.timeScale >= 0.6)
        {
            sprite_index = sPlayerSpin8;
            spinImgIndex = floor((imgAngle / 45) + 0.5);
        }
        else
        {
            sprite_index = sPlayerSpin16;
            spinImgIndex = imgAngle / 22.5;
        }
        
        image_index = spinImgIndex;
        break;
    
    case "in bubble":
        playerBubbleVisual();
        break;
    
    case "stuck":
        sprite_index = sPlayerSpin8;
        image_index = 4;
        break;
    
    default:
        break;
}

dcx = cx;
dcy = cy;
