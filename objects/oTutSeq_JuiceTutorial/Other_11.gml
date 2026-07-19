sequenceInitialize = function()
{
    if (initializeSequence)
    {
        initializeSequence = 0;
        return true;
    }
    else
    {
        return false;
    }
};

nextSequence = function(arg0)
{
    initializeSequence = 1;
    currentSequence = arg0;
};

function skipFadeDialog()
{
    if (diagboxTextFadedIn(diagbox))
        diagboxTextFadeOut(diagbox);
    else
        diagboxTextSkip(diagbox);
}

function nomzoSpeak()
{
    if (instance_exists(oTutJuiceAltar))
    {
        if (!diagboxTextFadedIn(diagbox))
        {
            with (oTutJuiceAltar)
                speakTime = 2;
        }
        
        var _textPos = diagbox.textElement.get_typewriter_pos();
        
        if (recordTextPos != _textPos)
        {
            recordTextPos = _textPos;
            textStoppedTime = 0;
        }
        else
        {
            textStoppedTime += 1;
            
            if (textStoppedTime >= 5)
            {
                with (oTutJuiceAltar)
                    speakTime = 0;
            }
        }
    }
}

diagboxSetLimits(diagbox, global.windowLeft + 20, (global.windowTop + 20) - 100, global.windowRight - 20, global.windowBottom - 15);
boxOverheadPosY = roomYToGui(oTutJuiceAltar.y) - 16 - 16;

switch (currentSequence)
{
    case "init":
        playerControlLock();
        
        if (oPlayer.currentState == "ground")
        {
            nextSequence("hello message");
            drawDiagbox = 1;
        }
        
        break;
    
    case "hello message":
        if (sequenceInitialize())
        {
            diagboxSetText(diagbox, loc("tutorial juiceman hello"), 1/3);
            diagboxFloat(diagbox, 0, -8);
            nextTextSign = 1;
            diagbox.boxY = boxOverheadPosY + 32;
            var _id = id;
            
            with (oTutSeq_SwipeToJump)
            {
                if (id != _id)
                    instance_destroy();
            }
        }
        else
        {
            nomzoSpeak();
            diagboxFloat(diagbox, 0, -8);
            global.playerControlLock = 1;
            playerControlLockTimer(0);
            
            if (input_check_pressed("select"))
                skipFadeDialog();
            
            if (diagboxTextFadedOut(diagbox))
                nextSequence("juice message 1");
        }
        
        diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, roomYToGui(oTutJuiceAltar.y) - 16);
        break;
    
    case "juice message 1":
        if (sequenceInitialize())
        {
            diagboxSetText(diagbox, loc("tutorial juiceman make me"), 1/3);
            diagboxFloat(diagbox, 0, -8);
            nextTextSign = 1;
        }
        else
        {
            nomzoSpeak();
            global.playerControlLock = 1;
            playerControlLockTimer(0);
            
            if (input_check_pressed("select"))
                skipFadeDialog();
            
            if (diagboxTextFadedOut(diagbox))
                nextSequence("juice message 2");
        }
        
        diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, roomYToGui(oTutJuiceAltar.y) - 16);
        break;
    
    case "juice message 2":
        if (sequenceInitialize())
        {
            instance_create_depth(x, y, 0, oOrderControl_Tutorial);
            diagboxSetText(diagbox, loc("tutorial juiceman recipe"), 1/3);
            nextTextSign = 1;
        }
        else
        {
            nomzoSpeak();
            global.playerControlLock = 1;
            
            if (input_check_pressed("select"))
                skipFadeDialog();
            
            if (diagboxTextFadedOut(diagbox))
                nextSequence("juice message 3");
        }
        
        diagboxLock(diagbox, global.windowCenterx, lerp(global.windowTop, global.windowMiddley, 0.5));
        diagboxSetKnobTarget(diagbox, diagbox.boxLockX, lerp(global.windowTop, global.windowMiddley, 0.5));
        break;
    
    case "juice message 3":
        if (sequenceInitialize())
        {
            diagboxSetText(diagbox, loc("tutorial juiceman squash"), 1/3);
            diagboxFloat(diagbox, 0, -8);
            nextTextSign = 1;
            diagbox.knobShow = 0;
        }
        else
        {
            nomzoSpeak();
            global.playerControlLock = 1;
            
            if (input_check_pressed("select"))
            {
                if (diagboxTextFadedIn(diagbox))
                    nextSequence("juice tutorial");
                else
                    diagboxTextSkip(diagbox);
            }
        }
        
        if (abs(diagbox.boxBottom - (roomYToGui(oTutJuiceAltar.y) - 16)) < 32)
            diagbox.knobShow = 1;
        
        diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, roomYToGui(oTutJuiceAltar.y) - 16);
        break;
    
    case "juice tutorial":
        if (sequenceInitialize())
        {
            diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, roomYToGui(oTutJuiceAltar.y) + 24);
            diagboxLock(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, global.windowBottom);
            global.playerControlLock = 1;
            global.playerControlLockReleaseTimer = 10;
            nextTextSign = 0;
            diagbox.forceLerpTween = 60;
        }
        else
        {
            diagbox.forceLerpTween = approach(diagbox.forceLerpTween, 0, 1);
            diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, diagbox.boxY);
        }
        
        break;
    
    case "glugging before timer":
        if (sequenceInitialize())
            delayTimer = 0;
        
        diagbox.forceLerpTween = 0;
        global.playerControlLock = 1;
        
        with (oPlayer)
            xDirection = -1;
        
        drawDiagbox = 0;
        diagboxSetText(diagbox, "[nbsp,5]", 1/3);
        
        if (!instance_exists(oJuiceHomingParticleEmitter))
        {
            delayTimer += doDelta();
            
            if (delayTimer >= 90)
                nextSequence("smile before timer");
        }
        
        break;
    
    case "smile before timer":
        if (sequenceInitialize())
        {
            delay = 144;
            var _delay = delay;
            delayTimer = 0;
            
            with (oTutJuiceAltar)
            {
                forceSmile = _delay - 72;
                playSoundTutorialGuyEatEnd();
            }
        }
        
        with (oPlayer)
            xDirection = -1;
        
        diagbox.forceLerpTween = 0;
        global.playerControlLock = 1;
        drawDiagbox = 0;
        diagboxSetText(diagbox, "[nbsp,5]", 1/3);
        delayTimer += doDelta();
        
        if (delayTimer >= delay)
            nextSequence("timer message 1");
        
        break;
    
    case "timer message 1":
        if (sequenceInitialize())
        {
            drawDiagbox = 1;
            diagboxSetText(diagbox, loc("tutorial juiceman good"), 1/3);
            diagboxFloat(diagbox, 0, -8);
            nextTextSign = 1;
            diagbox.boxY = boxOverheadPosY + 32;
        }
        else
        {
            nomzoSpeak();
            global.playerControlLock = 1;
            
            if (input_check_pressed("select"))
                skipFadeDialog();
            
            if (diagboxTextFadedOut(diagbox))
                nextSequence("timer message 2");
        }
        
        diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, roomYToGui(oTutJuiceAltar.y) - 16);
        break;
    
    case "timer message 2":
        if (sequenceInitialize())
        {
            diagboxSetText(diagbox, loc("tutorial juiceman fast test"), 1/3);
            diagboxFloat(diagbox, 0, -8);
            nextTextSign = 1;
        }
        else
        {
            nomzoSpeak();
            global.playerControlLock = 1;
            
            if (input_check_pressed("select"))
                skipFadeDialog();
            
            if (diagboxTextFadedOut(diagbox))
                nextSequence("timer message 3");
        }
        
        diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, roomYToGui(oTutJuiceAltar.y) - 16);
        break;
    
    case "timer message 3":
        if (sequenceInitialize())
        {
            instance_create_depth(x, y, 0, oOrderControl_Tutorial);
            diagboxSetText(diagbox, loc("tutorial juiceman see timer"), 1/3);
            diagboxLock(diagbox, global.windowCenterx, lerp(global.windowTop, global.windowMiddley, 0.5));
            nextTextSign = 0;
            
            with (oOrderControl_Tutorial)
            {
                tut_timerActive = 1;
                tut_juiceSuccessCount = 5;
                tut_renewRecipe();
            }
            
            timerShowTimer = 120;
        }
        else
        {
            nomzoSpeak();
            global.playerControlLock = 1;
            timerShowTimer -= doDelta(1);
            
            if (timerShowTimer <= 0)
                nextTextSign = 1;
            
            if (input_check_pressed("select") && nextTextSign)
                skipFadeDialog();
            
            if (diagboxTextFadedOut(diagbox))
                nextSequence("timer message 5");
        }
        
        diagboxLock(diagbox, global.windowCenterx, lerp(global.windowTop, global.windowMiddley, 0.5));
        diagboxSetKnobTarget(diagbox, diagbox.boxLockX, lerp(global.windowTop, global.windowMiddley, 0.5));
        break;
    
    case "timer message 5":
        if (sequenceInitialize())
        {
            diagboxSetText(diagbox, loc("tutorial juiceman beat timer"), 1/3);
            diagboxFloat(diagbox, 0, -8);
            nextTextSign = 1;
            
            with (oOrderControl_Tutorial)
                tut_timerActive = 0;
        }
        else
        {
            nomzoSpeak();
            global.playerControlLock = 1;
            
            if (input_check_pressed("select"))
            {
                if (diagboxTextFadedIn(diagbox))
                    nextSequence("timer tutorial");
                else
                    diagboxTextSkip(diagbox);
            }
        }
        
        diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, roomYToGui(oTutJuiceAltar.y) - 16);
        break;
    
    case "timer tutorial":
        if (sequenceInitialize())
        {
            diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, diagbox.boxY);
            diagboxLock(diagbox, roomXToGui(oTutJuiceAltar.x), global.windowBottom);
            global.playerControlLock = 1;
            global.playerControlLockReleaseTimer = 10;
            nextTextSign = 0;
            
            with (oOrderControl_Tutorial)
            {
                angerTimer = angerTimerMax * 1.05;
                tut_timerActive = 1;
                tut_angerActive = 1;
            }
            
            diagbox.forceLerpTween = 60;
        }
        else
        {
            diagbox.forceLerpTween = approach(diagbox.forceLerpTween, 0, 1);
            diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, diagbox.boxY);
        }
        
        break;
    
    case "timer fail":
        if (sequenceInitialize())
        {
            diagboxSetText(diagbox, loc("tutorial juiceman timer fail"), 1/3);
            diagboxFloat(diagbox, 0, -8);
            nextTextSign = 1;
            diagbox.boxY = boxOverheadPosY + 32;
        }
        else
        {
            nomzoSpeak();
            global.playerControlLock = 1;
            
            if (input_check_pressed("select"))
            {
                if (diagboxTextFadedIn(diagbox))
                    nextSequence("timer message 3");
                else
                    diagboxTextSkip(diagbox);
            }
        }
        
        diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, roomYToGui(oTutJuiceAltar.y) - 16);
        break;
    
    case "glugging before thanks":
        if (sequenceInitialize())
            delayTimer = 0;
        
        global.playerControlLock = 1;
        
        with (oPlayer)
            xDirection = -1;
        
        drawDiagbox = 0;
        diagboxSetText(diagbox, "[nbsp,5]", 1/3);
        
        if (!instance_exists(oJuiceHomingParticleEmitter))
        {
            delayTimer += doDelta();
            
            if (delayTimer >= 90)
                nextSequence("smile before thanks");
        }
        
        break;
    
    case "smile before thanks":
        if (sequenceInitialize())
        {
            delay = 180;
            var _delay = delay;
            delayTimer = 0;
            
            with (oTutJuiceAltar)
            {
                forceSmile = _delay - 72;
                playSoundTutorialGuyEatEnd();
            }
        }
        
        with (oPlayer)
            xDirection = -1;
        
        diagbox.forceLerpTween = 0;
        global.playerControlLock = 1;
        drawDiagbox = 0;
        diagboxSetText(diagbox, "[nbsp,5]", 1/3);
        delayTimer += doDelta();
        
        if (delayTimer >= delay)
            nextSequence("thanks 1");
        
        break;
    
    case "thanks 1":
        if (sequenceInitialize())
        {
            drawDiagbox = 1;
            diagboxSetText(diagbox, loc("tutorial juiceman delicious"), 1/3);
            diagboxFloat(diagbox, 0, -8);
            nextTextSign = 1;
            diagbox.boxY = boxOverheadPosY + 32;
        }
        else
        {
            nomzoSpeak();
            global.playerControlLock = 1;
            
            if (input_check_pressed("select"))
                skipFadeDialog();
            
            if (diagboxTextFadedOut(diagbox))
                nextSequence("thanks 2");
        }
        
        diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, roomYToGui(oTutJuiceAltar.y) - 16);
        break;
    
    case "thanks 2":
        if (sequenceInitialize())
        {
            diagboxSetText(diagbox, loc("tutorial juiceman farewell"), 1/3);
            diagboxFloat(diagbox, 0, -8);
            nextTextSign = 1;
        }
        else
        {
            nomzoSpeak();
            global.playerControlLock = 1;
            
            if (input_check_pressed("select"))
            {
                if (diagboxTextFadedIn(diagbox))
                    nextSequence("farewell");
                else
                    diagboxTextSkip(diagbox);
            }
        }
        
        diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, roomYToGui(oTutJuiceAltar.y) - 16);
        break;
    
    case "farewell":
        if (sequenceInitialize())
        {
            diagboxSetLimits(diagbox, global.windowLeft + 20, global.windowTop + 20, global.windowRight - 20, global.windowBottom + 100);
            global.playerControlLock = 1;
            global.playerControlLockReleaseTimer = 10;
            nextTextSign = 0;
            
            with (oTutorialSwitchEffectArea)
            {
                if (place_meeting(x, y, oTutJuiceAltar))
                    forceActivate = 1;
            }
            
            with (oCameraActivateArea)
            {
                if (place_meeting(x, y, oTutJuiceAltar))
                    instance_destroy();
            }
        }
        else
        {
        }
        
        diagboxSetLimits(diagbox, global.windowLeft + 20, global.windowTop + 20, global.windowRight - 20, global.windowBottom + 100);
        diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, roomYToGui(oTutJuiceAltar.y) - 16);
        break;
}

diagboxTick(diagbox);

if (drawDiagbox)
{
    draw_set_colour(c_white);
    diagboxDraw(diagbox, nextTextSign);
}
