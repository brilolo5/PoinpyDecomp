function pvcol_EnemyStomp()
{
    var _target = instance_place(argument[0], argument[1], parentEnemy);
    var _invincible = false;
    
    if (argument_count >= 3)
        _invincible = argument[2];
    
    if (_target)
    {
        if (ysp > 0)
        {
            slamTargetx = _target.x;
            
            if (!_target.unstompable || _invincible || damageInvincibility)
            {
                playerEntityBounce(_target);
                
                if (abilityCheck(UnknownEnum.Value_1))
                {
                    playSoundAbilityOctopup();
                    fruitSuckInRadius = fruitSuckInRadiusSlam;
                }
                
                if (abilityCheck(UnknownEnum.Value_19))
                    gainComboElement(439, UnknownEnum.Value_24, 0);
                
                with (_target)
                {
                    audioEventEnemyStomped();
                    stomped = 1;
                    generateEffect(oPlayer.x, oPlayer.bbox_bottom, "enemy death smoke", 0);
                    generateEffect(oPlayer.x, oPlayer.bbox_bottom, "stomp impact flash", 0);
                    instance_destroy();
                }
                
                return true;
            }
            else if (_target.unstompable)
            {
                playerDamage(_target);
                return true;
            }
        }
    }
}
