function playerSlam()
{
    if (stompInputCancelTime > 0)
        exit;
    
    if (!(0 || currentState == "slamming" || currentState == "ground - asleep" || currentState == "ground - puzzle prepare" || currentState == "ground - chair" || currentState == "dead"))
    {
        if (currentState == "in bubble")
        {
            if (instance_exists(myBubble))
            {
                with (myBubble)
                {
                    audioEvent("bubble exit and pop");
                    instance_destroy();
                }
            }
        }
        
        haptic("pop");
        xsp = lengthdir_x(tapThrustSpeed, 270);
        ysp = lengthdir_y(tapThrustSpeed, 270);
        slamImageIndex = 0;
        
        if (currentState != "ground")
        {
            whiteFlash = 2;
            addHitStop(12);
            var _squeezeRate = 0.15;
            yscale = 1 + _squeezeRate;
            xscale = 1 - _squeezeRate;
        }
        else
        {
            y -= 2;
            addHitStop(6);
            var _squeezeRate = 0.1;
            yscale = 1 + _squeezeRate;
            xscale = 1 - _squeezeRate;
        }
        
        if (abilityCheck(UnknownEnum.Value_16))
            fruitSuckInRadius = max(fruitSuckInRadius, fruitSuckInRadiusSlamStart);
        
        if (currentState == "invincible spin jump" || (currentState == "in bubble" && stateBeforeBubble == "invincible spin jump"))
            currentState = "slamming - invincible";
        else
            currentState = "slamming";
        
        slam = 1;
        audioSystemStopAsset(sfx_player_spin_med);
        audioSystemStopAsset(sfx_player_slomo_lp);
        audioSystemStopAsset(sfx_player_slomo_head);
        audioSystemStopAsset(sfx_player_post_wall_flying_lp);
        playSfxWorld(sfx_player_slam_head);
        slamHeightRecord = y;
        slingDirection = 90;
        
        if (room == rmPlayableMainMenu)
        {
            if (collision_rectangle(bbox_left, y, bbox_right, 1000, oBeastInLobby, 1, 1))
                playerControlLock();
        }
    }
}

function checkSlamFruitSquash()
{
    if (global.orderChecklistFilled)
    {
        var _totalTypes = ds_grid_height(global.comboGrid);
        var _totalFruits = ds_grid_get_sum(global.comboGrid, UnknownEnum.Value_1, 0, UnknownEnum.Value_1, _totalTypes);
        var _squashTimes = ceil(_totalFruits / 4);
        _totalTypes = ceil(ds_grid_height(global.comboGrid) / 1);
        var _totalSquashTimes = max(1, _squashTimes, _totalTypes);
        _totalSquashTimes = clamp(_totalSquashTimes, 0, 15);
        slamFruitSquash = _totalSquashTimes;
    }
    else
    {
        slamFruitSquash = 0;
    }
}
