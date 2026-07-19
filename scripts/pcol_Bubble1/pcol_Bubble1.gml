function pcol_Bubble1()
{
    target = instance_place(argument[0], argument[1], oGimBubble);
    
    if (target && target != myBubble)
    {
        bubbleIgnoreTimer = bubbleIgnoreTimerMax;
        currentState = "in bubble";
        global.jumpTimes += 1;
        myBubble = instance_place(argument[0], argument[1], oGimBubble);
        
        with (myBubble)
        {
            xsp = other.xsp / 1.1;
            ysp = other.ysp / 1.1;
            ysp = clamp(ysp, -5, 5);
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
