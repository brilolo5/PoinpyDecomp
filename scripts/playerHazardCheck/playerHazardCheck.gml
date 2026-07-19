function playerHazardCheck(arg0 = 0)
{
    if (!arg0)
    {
        touchHazard = instance_place(x, y, parentHazard);
        
        if (touchHazard)
        {
            if (!damageInvincibility)
                playerDamage(touchHazard);
        }
    }
    else
    {
        touchHazard = instance_place(x, y, oMagma);
        
        if (touchHazard)
        {
            if (!damageInvincibility)
            {
                playerDamage(touchHazard);
                
                with (oPlayer)
                {
                    ysp = -6;
                    var _maxJumpTimes = getMaxJump();
                    
                    if (global.jumpTimes != _maxJumpTimes)
                        refillJumpTimes(true);
                    
                    playerStateChange("damage knocked");
                }
            }
        }
    }
}
