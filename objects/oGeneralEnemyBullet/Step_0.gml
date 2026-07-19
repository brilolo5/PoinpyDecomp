var gts = global.timeScale;
cx += (xsp * global.timeScale);
cy += (ysp * global.timeScale);
var xspRound = floor(abs(cx)) * sign(cx);
var yspRound = floor(abs(cy)) * sign(cy);
cx -= xspRound;
cy -= yspRound;
ysp += ((grav * gts) / 2);

if (wallCollision)
{
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
            instance_destroy();
            break;
        }
    }
    
    repeat (abs(yspRound))
    {
        var target = instance_place(x, y + sign(yspRound), parentWall);
        
        if (!target)
        {
            y += sign(yspRound);
        }
        else
        {
            instance_destroy();
            ysp = 0;
        }
    }
}
else
{
    repeat (abs(xspRound))
        x += sign(xspRound);
    
    repeat (abs(yspRound))
        y += sign(yspRound);
}

ysp += ((grav * global.timeScale) / 2);

if (ysp > maxFallSpeed)
    ysp = maxFallSpeed;

if (fric != 0)
{
    var current_speed = sqrt((xsp * xsp) + (ysp * ysp));
    var _fric = fric * gts;
    
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
}

if (killTimer > 0)
{
    killTimer -= gts;
    
    if (killTimer <= 0)
        instance_destroy();
}

xShrink = approach(xShrink, 1, 0.05 * gts);
yShrink = approach(yShrink, 1, 0.05 * gts);
xscale = xscaleBase * xDirection * xShrink;
yscale = yscaleBase * yDirection * yShrink;
dcx = cx;
dcy = cy;
