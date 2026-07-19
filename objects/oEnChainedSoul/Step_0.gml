var gts = global.timeScale;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    switch (enemyState)
    {
        case "idle":
            break;
        
        case "boost":
            var _dir2p = point_direction(x, y, oPlayer.x, oPlayer.y);
            var _sp = 1;
            xsp += lengthdir_x(_sp, _dir2p);
            ysp += lengthdir_y(_sp, _dir2p);
            enemyState = "drifting";
            boostTimer = 0;
            maxDistance = 80;
            maxSpeed = 2;
            break;
        
        case "drifting":
            boostTimer += gts;
            
            if (boostTimer >= 60)
                enemyState = "boost";
            
            fric = 0.015;
            var _fric = fric * global.timeScale;
            var current_speed = sqrt((xsp * xsp) + (ysp * ysp));
            
            if (current_speed > maxSpeed)
            {
                xsp *= (maxSpeed / current_speed);
                ysp *= (maxSpeed / current_speed);
            }
            
            current_speed = sqrt((xsp * xsp) + (ysp * ysp));
            
            if (current_speed > _fric)
            {
                xsp *= ((current_speed - _fric) / current_speed);
                ysp *= ((current_speed - _fric) / current_speed);
            }
            else if (current_speed < -_fric)
            {
                xsp *= ((current_speed + _fric) / current_speed);
                ysp *= ((current_speed + _fric) / current_speed);
            }
            else
            {
                xsp = 0;
                ysp = 0;
            }
            
            if (point_distance(xstart, ystart, x, y) >= maxDistance)
            {
                var _dir2start = point_direction(x, y, xstart, ystart);
                xsp = lengthdir_x(current_speed, _dir2start) * 0.75;
                ysp = lengthdir_y(current_speed, _dir2start) * 0.75;
            }
            
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
        var target = instance_place(x + sign(xspRound), y, parentWall);
        var targetHazard = instance_place(x + sign(xspRound), y, parentHazard);
        
        if (!target && !targetHazard)
        {
            x += sign(xspRound);
        }
        else
        {
            xsp = 0;
            hitStop = 6;
            break;
        }
    }
    
    repeat (abs(yspRound))
    {
        var target = instance_place(x, y + sign(yspRound), parentWall);
        var targetHazard = instance_place(x, y + sign(yspRound), parentHazard);
        
        if (!(target || targetHazard))
        {
            if (yspRound > 0)
            {
            }
        }
        
        if (!(target || targetHazard))
            y += sign(yspRound);
        else
            ysp = 0;
    }
    
    grounded = -1;
    ysp += (((grav * global.timeScale) / 2) * gravityEnabled);
    
    if (ysp > maxFallSpeed)
        ysp = maxFallSpeed;
}

xShrink = approach(xShrink, 1, 0.05 * gts);
yShrink = approach(yShrink, 1, 0.05 * gts);
xscale = xscaleBase * xDirection * xShrink;
yscale = yscaleBase * yDirection * yShrink;
dcx = cx;
dcy = cy;
