var target;
var gts = global.timeScale;
blinkAlarm.tick();
maxSpeed = 0.6;
accel = 0.02;
activationRange = 96;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    frameTimeTracker += gts;
    
    if (frameTimeTracker >= 1)
    {
        tailArrayPush();
        frameTimeTracker -= 1;
    }
    
    switch (enemyState)
    {
        case "idle":
            xsp = 0;
            ysp = sin(global.timeScaledTime / 20) * 0.2;
            var _dir = point_direction(0, 0, xsp, ysp);
            eyeAngle -= ((angle_difference(eyeAngle, _dir) / 30) * gts);
            eyeAngle = facing + (ysp * 100 * -sign(facing));
            
            if (abs(y - oPlayer.y) < activationRange)
            {
                playSoundEnemyCyclopsWormAlerted();
                xShrink = 1.5;
                yShrink = 1.5;
                enemyState = "alert";
                _dir = point_direction(x, y, oPlayer.x, oPlayer.y);
                eyeAngle = _dir;
                blinking = 2;
                blinkAlarm.setTimer(blinkTime());
            }
            
            image_index = 0;
            break;
        
        case "alert":
            eyeIndex = 2;
            xsp = 0;
            ysp = 0;
            xShrink = approach(xShrink, 1, 0.05 * gts);
            yShrink = approach(yShrink, 1, 0.05 * gts);
            stateTimer += gts;
            _dir = point_direction(x, y, oPlayer.x, oPlayer.y);
            eyeAngle = _dir;
            
            if (stateTimer >= 30)
            {
                enemyState = "active";
                eyeIndex = 3;
            }
            
            var _xdir = -sign(x - oPlayer.x);
            
            if (_xdir != 0)
                xDirection = _xdir;
            
            break;
        
        case "active":
            xShrink = approach(xShrink, 1, 0.05 * gts);
            yShrink = approach(yShrink, 1, 0.05 * gts);
            dir = point_direction(x, y, oPlayer.x, oPlayer.y);
            
            if (point_distance(oPlayer.x, oPlayer.y, xstart, ystart) > 480)
                dir = point_direction(x, y, xstart, ystart);
            
            xsp += (accel * dcos(dir));
            ysp += (accel * dsin(-dir));
            var current_speed = sqrt((xsp * xsp) + (ysp * ysp));
            
            if (current_speed > maxSpeed)
            {
                xsp *= (maxSpeed / current_speed);
                ysp *= (maxSpeed / current_speed);
            }
            
            _dir = point_direction(x, y, oPlayer.x, oPlayer.y);
            eyeAngle -= ((angle_difference(eyeAngle, _dir) / 15) * gts);
            _xdir = -sign(x - oPlayer.x);
            
            if (_xdir != 0)
                xDirection = _xdir;
            
            break;
    }
    
    cx += (xsp * global.timeScale);
    cy += (ysp * global.timeScale);
    var xspRound = floor(abs(cx)) * sign(cx);
    var yspRound = floor(abs(cy)) * sign(cy);
    cx -= xspRound;
    cy -= yspRound;
    ysp += (((grav * gts) / 2) * gravityEnabled);
    
    repeat (abs(xspRound))
    {
        target = instance_place(x + sign(xspRound), y, parentWall);
        var targetHazard = 0;
        
        if (!target && !targetHazard)
        {
            x += sign(xspRound);
        }
        else
        {
            xsp *= -1;
            blinking = 1;
            break;
        }
    }
    
    repeat (abs(yspRound))
    {
        target = instance_place(x, y + sign(yspRound), parentWall);
        var targetHazard = 0;
        
        if (!(target || targetHazard))
        {
            y += sign(yspRound);
        }
        else
        {
            ysp *= -1;
            blinking = 1;
        }
    }
    
    ysp += (((grav * global.timeScale) / 2) * gravityEnabled);
    
    if (ysp > maxFallSpeed)
        ysp = maxFallSpeed;
}

target = instance_place(x, y, oEnHoming);

if (target)
{
    var current_speed = sqrt((xsp * xsp) + (ysp * ysp));
    dir = point_direction(x, y, target.x, target.y) - 180;
    xsp = current_speed * dcos(dir);
    ysp = current_speed * dsin(-dir);
}

xscale = xscaleBase * xDirection * xShrink;
yscale = yscaleBase * yDirection * yShrink;
dcx = cx;
dcy = cy;
