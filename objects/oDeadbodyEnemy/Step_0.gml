var gts = global.timeScale;

if (hitStop)
    hitStop -= gts;

if (!hitStop)
{
    var current_speed = sqrt((xsp * xsp) + (ysp * ysp));
    jobutsuTimer -= gts;
    
    if (jobutsuTimer <= 0)
    {
        fric = 0.3;
        gravityEnabled = 0;
        
        if (current_speed < 0.1 || jobutsuTimer < -60)
        {
            playSoundEnemyCorpseDisappear();
            
            if (flashDisappear)
                generateEffect(x, y, "temp white flash", 0);
            
            instance_destroy();
        }
    }
    else if (point_distance(xstart, ystart, x, y) > 32)
    {
        jobutsuTimer = 0;
    }
    
    switch (enemyState)
    {
        case "idle":
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
        var targetHazard = -1;
        
        if (!wallCollision || (!target && !targetHazard))
        {
            x += sign(xspRound);
        }
        else
        {
            xsp *= -0.75;
            break;
        }
    }
    
    repeat (abs(yspRound))
    {
        var target = instance_place(x, y + sign(yspRound), parentWall);
        var targetHazard = -1;
        
        if (!(target || targetHazard))
        {
            if (yspRound > 0)
            {
                if (place_meeting(x, y + 1, oOnewayPlatform) && !place_meeting(x, y, oOnewayPlatform))
                    target = instance_place(x, y + 1, oOnewayPlatform);
            }
        }
        
        if (!wallCollision || !(target || targetHazard))
        {
            y += sign(yspRound);
        }
        else
        {
            ysp *= -0.75;
            break;
        }
    }
    
    if (ysp >= 0 && (place_meeting(x, y + 1, parentWall) || (place_meeting(x, y + 1, oOnewayPlatform) && !place_meeting(x, y, oOnewayPlatform))))
    {
        grounded = 1;
        cy = 0;
    }
    else
    {
        grounded = -1;
    }
    
    ysp += (((grav * global.timeScale) / 2) * gravityEnabled);
    
    if (ysp > maxFallSpeed)
        ysp = maxFallSpeed;
    
    if (fric > 0)
    {
        var _timeFric = fric * gts;
        current_speed = sqrt((xsp * xsp) + (ysp * ysp));
        
        if (current_speed > _timeFric)
        {
            xsp *= ((current_speed - _timeFric) / current_speed);
            ysp *= ((current_speed - _timeFric) / current_speed);
        }
        else if (current_speed < -_timeFric)
        {
            xsp *= ((current_speed + _timeFric) / current_speed);
            ysp *= ((current_speed + _timeFric) / current_speed);
        }
        else
        {
            xsp = 0;
            ysp = 0;
        }
    }
}

xShrink = approach(xShrink, 1, 0.05 * gts);
yShrink = approach(yShrink, 1, 0.05 * gts);
xscale = xscaleBase * xDirection * xShrink;
yscale = yscaleBase * yDirection * yShrink;
dcx = cx;
dcy = cy;
