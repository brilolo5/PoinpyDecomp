if (live_call())
    return global.live_result;

var gts = global.timeScale;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    switch (enemyState)
    {
        case "spawn":
            checkingLaser_x += (32 * xDirection);
            var _whileLoopStopper = 0;
            
            while (true)
            {
                if (collision_line(x + (16 * xDirection), y, checkingLaser_x, y, parentWall, 0, 0))
                    break;
                else
                    checkingLaser_x += (16 * xDirection);
                
                _whileLoopStopper += 1;
                
                if (_whileLoopStopper > 60)
                {
                    var _text = "h launch \n" + string(x) + "," + string(xDirection);
                    instance_destroy();
                    break;
                }
            }
            
            enemyState = "ready";
            break;
        
        case "ready":
            sprite_index = sDrillfish_idle;
            
            if (collision_line(x, y, checkingLaser_x, y, oPlayer, 0, 0))
            {
                enemyState = "prepare";
                stateTimer = 0;
            }
            
            break;
        
        case "alert":
            xShrink = approach(xShrink, 1, 0.05 * gts);
            yShrink = approach(yShrink, 1, 0.05 * gts);
            stateTimer += gts;
            
            if (stateTimer > 18)
            {
                stateTimer = 0;
                enemyState = "prepare";
            }
            
            break;
        
        case "prepare":
            drillSpeed = approach(drillSpeed, 0.2, 0.01);
            sprite_index = sDrillfish_drill;
            image_index += (drillSpeed * gts);
            xShrink = lerp(xShrink, 0.75, 0.025);
            yShrink = lerp(yShrink, 1.25, 0.025);
            stateTimer += gts;
            
            if (stateTimer > 28)
            {
                stateTimer = 0;
                enemyState = "launched";
                xsp = xDirection * launchSpeed;
                xShrink = 1.25;
                yShrink = 0.75;
            }
            
            break;
        
        case "launched":
            drillSpeed_normal = 0.75;
            drillSpeed = drillSpeed_normal;
            sprite_index = sDrillfish_drill;
            image_index += (drillSpeed * gts);
            
            if (audioVarDrillFishHeadLoop == 0)
            {
                playSoundEnemyDrillFishMoveHead();
                playSoundEnemyDrillFishMoveLoop();
                audioVarDrillFishTail = 0;
                audioVarDrillFishHeadLoop = 1;
            }
            
            xShrink = approach(xShrink, 1, 0.05 * gts);
            yShrink = approach(yShrink, 1, 0.05 * gts);
            cx += (xsp * global.timeScale);
            cy += (ysp * global.timeScale);
            var xspRound = floor(abs(cx)) * sign(cx);
            var yspRound = floor(abs(cy)) * sign(cy);
            cx -= xspRound;
            cy -= yspRound;
            
            repeat (abs(xspRound))
            {
                x += sign(xspRound);
                target = instance_place(x + (-sign(xspRound) * 8), y, parentWall);
                
                if (!target)
                    enemyState = "out of wall";
            }
            
            break;
        
        case "out of wall":
            sprite_index = sDrillfish_drill;
            image_index += (drillSpeed * gts);
            xShrink = approach(xShrink, 1, 0.05 * gts);
            yShrink = approach(yShrink, 1, 0.05 * gts);
            cx += (xsp * global.timeScale);
            cy += (ysp * global.timeScale);
            xspRound = floor(abs(cx)) * sign(cx);
            yspRound = floor(abs(cy)) * sign(cy);
            cx -= xspRound;
            cy -= yspRound;
            
            repeat (abs(xspRound))
            {
                target = instance_place(x + (-sign(xspRound) * 8), y, parentWall);
                
                if (target == -4)
                {
                    x += sign(xspRound);
                }
                else
                {
                    xsp = 0.75 * -xDirection;
                    ysp = -0.75;
                    hitStop = 1;
                    xShrink = 0.75;
                    yShrink = 1.25;
                    enemyState = "stuck";
                    break;
                }
            }
            
            break;
        
        case "stuck":
            sprite_index = sDrillfish_drill;
            image_index += (drillSpeed * gts);
            drillSpeed = approach(drillSpeed, 0, 0.016666666666666666 * gts);
            
            if (audioVarDrillFishTail == 0)
            {
                playSoundEnemyDrillFishMoveTail();
                audio_stop_sound(sfx_enemy_drillFish_move_lp);
                audioVarDrillFishTail = 1;
                audioVarDrillFishHeadLoop = 0;
            }
            
            xShrink = approach(xShrink, 1, 0.05 * gts);
            yShrink = approach(yShrink, 1, 0.05 * gts);
            break;
    }
}

xscale = xShrink * xDirection * xscaleBase;
yscale = yShrink * yDirection * yscaleBase;
