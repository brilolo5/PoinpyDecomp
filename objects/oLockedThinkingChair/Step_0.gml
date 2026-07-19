var gts = global.timeScale;

if (!hanging)
{
    cy += (ysp * global.timeScale);
    var yspRound = floor(abs(cy)) * sign(cy);
    cy -= yspRound;
    ysp += ((grav * gts) / 2);
    imageAngle += 1;
    
    repeat (abs(yspRound))
    {
        var _sparkles = instance_place(x, y, oLobbySparkleArea);
        
        if (_sparkles)
        {
            with (_sparkles)
                instance_destroy();
        }
        
        target = instance_place(x, y + sign(yspRound), parentWall);
        
        if (!target)
        {
            y += sign(yspRound);
        }
        else
        {
            playSoundHangingChairLand();
            global.puzzleModeUnlocked = 1;
            instance_activate_object(oPuzzleSwitch);
            
            with (oPuzzleSwitch)
                instance_activate_object(myWall);
            
            with (oNotificationRabbit_Puzzle_Asleep)
                jumpAwake();
            
            screenShake(8, 8);
            instance_destroy();
        }
    }
    
    ysp += ((grav * global.timeScale) / 2);
    
    if (ysp > maxFallSpeed)
        ysp = maxFallSpeed;
}
