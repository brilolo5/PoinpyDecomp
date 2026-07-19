switch (currentSequence)
{
    case "appear":
        diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, roomYToGui(oTutJuiceAltar.y) - 8);
        diagboxFloat(diagbox, 0, -10);
        
        if (input_check_pressed("select"))
        {
            if (diagboxTextFadedIn(diagbox))
                currentSequence = "lock";
            else
                diagboxTextSkip(diagbox);
        }
        
        break;
    
    case "lock":
        diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, roomYToGui(oTutJuiceAltar.y) + 24);
        diagboxLock(diagbox, global.windowCenterx, global.windowBottom);
        
        if (keyboard_check_pressed(ord("J")))
        {
            currentSequence = "fade out";
            diagboxTextFadeOut(diagbox);
        }
        
        break;
    
    case "fade out":
        diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, roomYToGui(oTutJuiceAltar.y) - 8);
        diagboxFloat(diagbox, 0, -10);
        
        if (diagboxTextFadedOut(diagbox))
        {
            currentSequence = "appear";
            guide.message_index++;
            diagboxSetText(diagbox, guide.messages[guide.message_index], 1/3);
            
            if (guide.message_index >= (array_length(guide.messages) - 1))
                currentSequence = "exit";
        }
        
        break;
    
    case "exit":
        diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, roomYToGui(oTutJuiceAltar.y) - 8);
        diagboxSetLimits(diagbox, global.windowLeft + 25, global.windowTop + 20, global.windowRight - 25, 99999999999999);
        diagboxFloat(diagbox, 0, -10);
        break;
}

diagboxTick(diagbox);
