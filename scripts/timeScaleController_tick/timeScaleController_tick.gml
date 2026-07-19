function timeScaleController_tick()
{
    targetDelta = 0.016666666666666666;
    actualDelta = delta_time / 1000000;
    global.deltaTimeRate = actualDelta / targetDelta;
    global.deltaTimeRate = clamp(global.deltaTimeRate, 0, 3);
    
    if (os_type == os_ios || os_type == os_android)
    {
        if (os_is_paused() || !window_has_focus())
        {
            global.deltaTimeRate = 0;
            
            if (!global.mainGamePaused)
                global.gameReturnedTo = -1;
        }
        else if (global.gameReturnedTo == -1)
        {
            global.gameReturnedTo = 3;
        }
        else
        {
            global.gameReturnedTo = approach(global.gameReturnedTo, 0, 1);
        }
    }
    
    global.deltaTimeRate = clamp(global.deltaTimeRate, 0, 10);
    
    if (keyboard_check(vk_right) && global.debugControl)
        global.deltaTimeRate = 5;
    
    var _tsGridHeight = ds_grid_height(timeScaleGrid);
    
    if (_tsGridHeight >= 1)
    {
        ds_grid_sort(timeScaleGrid, UnknownEnum.Value_0, true);
        var _tsGoal = timeScaleGrid[# UnknownEnum.Value_0, 0];
        var _tsShift = timeScaleGrid[# UnknownEnum.Value_2, 0];
        global.timeScale_noDelta = clamp(approach(global.timeScale_noDelta, _tsGoal, _tsShift), 0, 1);
        _tsGridHeight = ds_grid_height(timeScaleGrid);
        ds_grid_add_region(timeScaleGrid, UnknownEnum.Value_1, 0, UnknownEnum.Value_1, _tsGridHeight - 1, -1 * global.deltaTimeRate);
        ds_grid_sort(timeScaleGrid, UnknownEnum.Value_1, false);
        
        if (timeScaleGrid[# UnknownEnum.Value_1, _tsGridHeight - 1] <= 0)
        {
            _tsGridHeight = ds_grid_height(timeScaleGrid);
            
            while (timeScaleGrid[# UnknownEnum.Value_1, _tsGridHeight - 1] <= 0)
            {
                ds_grid_resize(timeScaleGrid, UnknownEnum.Value_3, _tsGridHeight - 1);
                _tsGridHeight = ds_grid_height(timeScaleGrid);
                
                if (_tsGridHeight <= 0)
                    break;
            }
        }
        
        ds_grid_sort(timeScaleGrid, UnknownEnum.Value_0, true);
    }
    else
    {
        global.timeScale_noDelta = lerp(global.timeScale_noDelta, global.timeScaleDefault, 0.2 * global.deltaTimeRate);
    }
    
    global.timeScale = doDeltaWithAccessibility(global.timeScale_noDelta);
}
