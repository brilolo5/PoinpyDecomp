function playerEnemyCheck()
{
    var touchEnemy = instance_place(x, y, parentEnemy);
    
    if (touchEnemy)
    {
        var _enemyBboxCenter = mean(touchEnemy.bbox_bottom, touchEnemy.bbox_top);
        
        if ((_enemyBboxCenter < y || touchEnemy.unstompable) && touchEnemy.damagePlayer)
        {
            if (!damageInvincibility)
            {
                playerDamage(touchEnemy);
                var _orbEffectNum = instance_number(oJumpOrbReplenishEffect);
                
                if ((global.jumpTimes + _orbEffectNum) < getMaxJump())
                    refillJump1();
            }
        }
        else if (pvcol_EnemyStomp(x, y + 1))
        {
            addHitStop(12);
            screenShake(3, 3);
            refillJump1();
        }
    }
}
