function pcol_Bubble()
{
    target = instance_place(argument[0], argument[1], oGimBubble);
    
    if (target && target != myBubble)
    {
        audioSystemStopAsset(sfx_player_spin_med);
        playSoundPlayerBubbleHeadLp();
        stateBeforeBubble = currentState;
        bubbleVisualScaler = 1;
        bubbleIgnoreTimer = bubbleIgnoreTimerMax;
        currentState = "in bubble";
        noStompFor(12);
        global.jumpTimes += 1;
        myBubble = instance_place(argument[0], argument[1], oGimBubble);
        
        with (myBubble)
        {
            xsp = other.xsp / 1.5;
            ysp = other.ysp / 1;
            
            if (xsp == 0)
                xsp = sign((x - other.x) + 1) * 0.5;
            
            ysp = clamp(ysp, -5, 5);
            xDirection = sign(xsp);
            x = other.x;
            y = other.y;
            xShrink = 1.5;
            yShrink = 1.5;
            bubbleState = "active";
        }
        
        global.playerControlLock = 0;
        screenShake(2, 3);
        addHitStop(3);
        return true;
    }
}
