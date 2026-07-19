function refillJumpTimes(arg0 = 1)
{
    with (oPlayer)
    {
        var _refillAmount = arg0;
        var _maxJumpTimes = getMaxJump();
        
        if (global.jumpTimes != _maxJumpTimes)
        {
            jumpRefillSequence = _maxJumpTimes;
            jumpTimesOrbDrawPosyTween = 16;
        }
        
        global.jumpTimes = clamp(_maxJumpTimes, 1, 99);
    }
}

function refillJump1()
{
    if (global.lifePoint > 0)
    {
        playSoundJumpOrbReplenish();
        instance_create_depth(x - 1, y + 16, 0, oJumpOrbReplenishEffect);
    }
}

function getMaxJump()
{
    var _maxJumpTimes = global.jumpTimesMax;
    var _pajamaAddOrReduce = -1;
    
    if (abilityCheck(UnknownEnum.Value_22))
    {
        _maxJumpTimes = 2;
        _pajamaAddOrReduce = 1;
    }
    
    if (abilityCheck(UnknownEnum.Value_7))
        _maxJumpTimes += 1;
    
    if (abilityCheck(UnknownEnum.Value_23))
        _maxJumpTimes += (2 * _pajamaAddOrReduce);
    
    if (abilityCheck(UnknownEnum.Value_24))
        _maxJumpTimes += (2 * _pajamaAddOrReduce);
    
    if (abilityCheck(UnknownEnum.Value_25))
        _maxJumpTimes += (2 * _pajamaAddOrReduce);
    
    if (abilityCheck(UnknownEnum.Value_26))
        _maxJumpTimes += (2 * _pajamaAddOrReduce);
    
    _maxJumpTimes = clamp(_maxJumpTimes, 1, infinity);
    return _maxJumpTimes;
}
