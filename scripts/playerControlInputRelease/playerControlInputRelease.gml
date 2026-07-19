function playerControlInputRelease()
{
    if (slingLength < slingInputThreshold)
    {
        var _abilityButtonTap = room == rmPlayableMainMenu && checkCursorInsideAbilityButton();
        
        if (tapTimer < tapThresholdFrames && !_abilityButtonTap)
        {
            playerSlam();
        }
        else
        {
        }
    }
    else if (currentState != "in cannon")
    {
        if (currentState == "in bubble")
        {
            if (instance_exists(myBubble))
            {
                with (myBubble)
                {
                    playSoundPlayerBubbleTail();
                    instance_destroy();
                }
            }
        }
        
        haptic("peek");
        wallJumpCount = 0;
        
        if (currentState == "ground" || currentState == "ground - asleep" || currentState == "ground - puzzle prepare" || currentState == "ground - chair" || currentState == "slam bounce" || slideChargeTimer > 0 || intentionalSlide)
        {
            if (slingDirection > 180)
            {
                intentionalSlide = 1;
                slideChargeTimer = 1;
            }
            else
            {
                intentionalSlide = 0;
                slideChargeTimer = 0;
            }
        }
        else
        {
            intentionalSlide = 0;
            slideChargeTimer = 0;
        }
        
        if ((global.jumpTimes == 1 && abilityCheck(UnknownEnum.Value_13)) || currentState == "invincible spin jump" || (currentState == "in bubble" && (stateBeforeBubble == "invincible spin jump" || stateBeforeBubble == "slamming - invincible")))
        {
            playSoundAbilityFightingSpirit();
            playerStateChange("invincible spin jump");
        }
        else
        {
            with (oCamera)
                puzzleStarted = 1;
            
            playerStateChange("spin jump");
        }
        
        addHitStop(3);
        xsp = lengthdir_x(slingLength, slingDirection);
        ysp = lengthdir_y(slingLength, slingDirection);
        
        if (intentionalSlide)
        {
            playSoundPlayerSkidSpin();
            xsp = sign(xsp + 0.1) * slingLength * 1;
            ysp = 0;
            global.jumpTimes += 1;
            whiteFlash = 2;
        }
        else if (abilityCheck(UnknownEnum.Value_28))
        {
            fruitSuckInRadius = max(fruitSuckInRadius, fruitSuckInRadiusJumpStart);
        }
        
        global.cannonAngleGoal = slingDirection - 90;
        spin = 1;
        slam = 0;
        slamVisualTimer = 0;
        staticHoldCharge = global.staticHoldChargeMax;
        imgAngle = 315;
        image_index = floor((imgAngle / 45) + 0.5);
        previousImageIndex = image_index;
        thumbCircleRadius = 0;
        global.jumpTimes -= 1;
        
        if (!launched)
        {
            launched = 1;
            
            if (global.totalStamina <= 3)
            {
                with (oControl)
                    staminaWarningTextExpandTimer = staminaWarningTextExpandTimerMax;
            }
        }
        
        global.jumpReleaseInput = 1;
    }
}

function noStompFor(arg0 = 12)
{
    stompInputCancelTime = arg0;
}
