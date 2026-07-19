function playerDamage()
{
    if (!global.playerControlLock)
    {
        with (oPlayer)
        {
            if (currentState != "dead")
            {
                addHitStop(0);
                screenShake(4, 4);
                selfShake = 8;
                selfShakeAmount = 5;
                playSfxWorld(sfx_player_take_damage);
                
                if (global.gameReinitializeState != "puzzle")
                {
                    timeScaleChange(0, 12, 1);
                    timeScaleChange(0.5, 13, 1);
                    timeScaleChange(1, 20, 0.015);
                }
                
                playerStateChange("damage knocked");
                
                if (abilityCheck(UnknownEnum.Value_0))
                {
                    playSoundAbilityMummyPlushie();
                    
                    with (oOrderControl)
                    {
                        repeat (1)
                            orderDebugGetAllFruit(recipeDataGrid, global.comboGrid);
                    }
                }
            }
            
            if (global.lifePoint >= 0)
            {
                with (oControl)
                {
                    var _effectPosx = _hpPosx + ((global.lifePoint - 1) * _hpOffsetByx);
                    var _effectPosy = _hpPosy + ((global.lifePoint - 1) * _hpOffsetByy) + 8;
                    
                    if (global.rescueLife > 0)
                    {
                        _effectPosx = _hpPosx + (global.lifePoint * _hpOffsetByx);
                        _effectPosy = _hpPosy + (global.lifePoint * _hpOffsetByy) + 8;
                    }
                    
                    generateEffect(_effectPosx, _effectPosy, "HP loss", 1);
                }
            }
            
            var _targetx = argument[0].x;
            var _targety = argument[0].y;
            var _xdif = _targetx - oPlayer.x;
            var _ydif = _targety - oPlayer.y;
            xsp = 3 * sign(-_xdif);
            ysp = -3;
            
            if (argument[0].object_index == oPlayer)
            {
                xsp = 0;
                ysp = -3;
            }
            
            jumpThrust = 0;
            slam = 0;
            spin = 0;
            comboElementGetRecordIndex = 0;
            tempScore = 0;
            
            with (oOrderControl)
                angerTimer = angerTimerMax;
            
            if (global.rescueLife > 0)
                global.rescueLife = 0;
            else if (!global.debugNoDamage)
                global.lifePoint -= 1;
            
            damageInvincibility = 180;
            damageInvincibilityFlash = 180;
            damageKnock = 60;
            global.playerControlLock = 1;
            global.playerControlLockReleaseTimer = 10;
            
            if (global.lifePoint <= 0)
            {
                if (currentState != "dead" && global.gameReinitializeState != "puzzle")
                {
                    if (abilityCheck(UnknownEnum.Value_22))
                    {
                        timeScaleChange(0, 35, 1);
                        timeScaleChange(0.5, 95, 1);
                    }
                    else
                    {
                        timeScaleChange(0, 35, 1);
                        timeScaleChange(0.5, 155, 1);
                    }
                    
                    xsp = 8 * sign(x - argument[0].x - 0.1);
                    playerStateChange("dead");
                    screenShake(5, 6);
                }
                
                damageInvincibility = 0;
                damageInvincibilityFlash = 0;
                damageKnock = 180;
                global.playerControlLock = 1;
                global.playerControlLockReleaseTimer = damageKnock;
            }
        }
    }
}
