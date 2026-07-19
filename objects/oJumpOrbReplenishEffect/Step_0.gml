var _forceObtain = oPlayer.mbHeld && global.jumpTimes == 0;
var _destx = oPlayer.x;
var _desty = oPlayer.y - 20;

if (!pause || _forceObtain)
{
    if (abs(angle_difference(angleFromPlayer, 90)) < 90)
    {
        closeInSpeed = deltaLerp(closeInSpeed, distanceFromPlayer / 5, 0.1);
        angleSpeed *= 0.5;
    }
    
    distanceFromPlayer -= doDelta(closeInSpeed);
    angleFromPlayer += doDelta(angleSpeed);
    var _xoffset = lengthdir_x(distanceFromPlayer, angleFromPlayer);
    var _yoffset = lengthdir_y(distanceFromPlayer, angleFromPlayer);
    x = _destx + _xoffset;
    y = _desty + _yoffset;
    imageAngle = point_direction(px, py, _xoffset, _yoffset);
    px = _xoffset;
    py = _yoffset;
    var jumpTimesOrbDrawSpaceInbetween = 7;
    var jumpTimesOrbDrawPosxLeft = global.jumpTimes * (jumpTimesOrbDrawSpaceInbetween / 2);
    
    if (global.jumpTimes >= 5)
        jumpTimesOrbDrawPosxLeft = 8;
    
    if (distanceFromPlayer < jumpTimesOrbDrawPosxLeft || _forceObtain)
    {
        with (oPlayer)
        {
            var _refillAmount = 1;
            var _maxJumpTimes = getMaxJump();
            global.jumpTimes += 1;
            jumpRefillSequence = global.jumpTimes;
            
            if (global.jumpTimes >= 5)
            {
                jumpRefillSequence = min(_maxJumpTimes, _refillAmount);
                jumpTimesOrbDrawPosyTween = 8;
            }
        }
        
        instance_destroy();
    }
    
    xscale = deltaLerp(xscale, 8 / sprite_get_width(sprite_index), 0.1);
    yscale = 6 / sprite_get_width(sprite_index);
}
else
{
    xscale = deltaLerp(xscale, 12 / sprite_get_width(sprite_index), 0.5);
    yscale = xscale;
}

pause -= doDelta(1);
