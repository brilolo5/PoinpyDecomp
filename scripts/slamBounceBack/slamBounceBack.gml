function slamBounceBack()
{
    var _slamHeight = y - slamHeightRecord;
    _slamHeight = clamp(_slamHeight, 0, 1584);
    
    if (_slamHeight >= 96)
    {
        sleep(4);
        addHitStop(12);
        screenShake(6, 6);
    }
    else
    {
        screenShake(3, 3);
        addHitStop(12);
    }
    
    if (abilityCheck(UnknownEnum.Value_15))
    {
        if ((slamTargetx - x) > 0)
            xsp = -2;
        else
            xsp = 2;
    }
    
    if (abilityCheck(UnknownEnum.Value_9))
    {
        playSoundAbilityBouncySpring();
        _slamHeight += 48;
    }
    
    var _bounceBackSpeed = -sqrt(2 * grv * _slamHeight);
    ysp = (_bounceBackSpeed < ysp) ? _bounceBackSpeed : ysp;
}
