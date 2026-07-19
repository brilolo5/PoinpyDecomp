var gts = global.timeScale;
cx += (xsp * global.timeScale);
cy += (ysp * global.timeScale);
var xspRound = floor(abs(cx)) * sign(cx);
var yspRound = floor(abs(cy)) * sign(cy);
cx -= xspRound;
cy -= yspRound;
ysp += (((grav * gts) / 2) * gravityEnabled);

if (collideWithWall)
{
    var _checkCollisionWall = instance_place(x, y, parentWall);
    
    if (_checkCollisionWall)
        y += (y - _checkCollisionWall.y);
    
    repeat (abs(xspRound))
    {
        _checkCollisionWall = place_meeting(x + sign(xspRound), y, parentWall);
        
        if (!_checkCollisionWall)
        {
            x += sign(xspRound);
        }
        else
        {
            xsp *= -0.5;
            break;
        }
    }
    
    repeat (abs(yspRound))
    {
        _checkCollisionWall = place_meeting(x, y + sign(yspRound), parentWall);
        var _checkCollisionPlatform = place_meeting(x, y + 1, parentOnewayPlatform);
        
        if (_checkCollisionPlatform)
            _checkCollisionPlatform = !place_meeting(x, y, parentOnewayPlatform);
        
        if (!(_checkCollisionWall || _checkCollisionPlatform))
        {
            y += sign(yspRound);
        }
        else
        {
            ysp *= -0.75;
            xsp *= 0.75;
            break;
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

ysp += (((grav * gts) / 2) * gravityEnabled);

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

xShrink = approach(xShrink, 1, 0.05 * gts);
yShrink = approach(yShrink, 1, 0.05 * gts);
xscale = xShrink * xDirection * xscaleBase;
yscale = yShrink * yDirection * yscaleBase;
image_angle = 0;
